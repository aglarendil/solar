import click
import json
#import matplotlib
#matplotlib.use('Agg')  # don't show windows
#import matplotlib.pyplot as plt
import networkx as nx
import os
import subprocess

from solar.core import actions as xa
from solar.core import deployment as xd
from solar.core import resource as xr
from solar.core import signals as xs


@click.group()
def cli():
    pass


def init_cli_resource():
    @click.group()
    def resource():
        pass

    cli.add_command(resource)

    @click.command()
    @click.argument('resource_path')
    @click.argument('action_name')
    def action(action_name, resource_path):
        print 'action', resource_path, action_name
        r = xr.load(resource_path)
        xa.resource_action(r, action_name)

    resource.add_command(action)

    @click.command()
    @click.argument('name')
    @click.argument('base_path')
    @click.argument('dest_path')
    @click.argument('args')
    def create(args, dest_path, base_path, name):
        print 'create', name, base_path, dest_path, args
        args = json.loads(args)
        xr.create(name, base_path, dest_path, args)

    resource.add_command(create)

    @click.command()
    @click.argument('resource_path')
    @click.argument('tag_name')
    @click.option('--add/--delete', default=True)
    def tag(add, tag_name, resource_path):
        print 'Tag', resource_path, tag_name, add
        r = xr.load(resource_path)
        if add:
            r.add_tag(tag_name)
        else:
            r.remove_tag(tag_name)
        r.save()

    resource.add_command(tag)

    @click.command()
    @click.argument('path')
    @click.option('--all/--one', default=False)
    @click.option('--tag', default=None)
    def show(tag, all, path):
        if all or tag:
            for name, resource in xr.load_all(path).items():
                show = True
                if tag:
                    if tag not in resource.tags:
                        show = False

                if show:
                    print resource
                    print
        else:
            print xr.load(path)

    resource.add_command(show)

    @click.command()
    @click.argument('path')
    @click.argument('args')
    def update(args, path):
        print 'Update', path, args
        args = json.loads(args)
        # Need to load all resources for bubbling effect to take place
        # TODO: resources can be scattered around, this is a simple
        #   situation when we assume resources are all in one directory
        base_path, name = os.path.split(path)
        all = xr.load_all(base_path)
        r = all[name]
        r.update(args)

    resource.add_command(update)


def init_cli_connect():
    @click.command()
    @click.argument('emitter')
    @click.argument('receiver')
    @click.option('--mapping', default=None)
    def connect(mapping, receiver, emitter):
        print 'Connect', emitter, receiver
        emitter = xr.load(emitter)
        receiver = xr.load(receiver)
        print emitter
        print receiver
        if mapping is not None:
            mapping = json.loads(mapping)
        xs.connect(emitter, receiver, mapping=mapping)

    cli.add_command(connect)

    @click.command()
    @click.argument('emitter')
    @click.argument('receiver')
    def disconnect(receiver, emitter):
        print 'Disconnect', emitter, receiver
        emitter = xr.load(emitter)
        receiver = xr.load(receiver)
        print emitter
        print receiver
        xs.disconnect(emitter, receiver)

    cli.add_command(disconnect)


def init_cli_connections():
    @click.group()
    def connections():
        pass

    cli.add_command(connections)

    @click.command()
    def show():
        print json.dumps(xs.CLIENTS, indent=2)

    connections.add_command(show)

    # TODO: this requires graphing libraries
    @click.command()
    def graph():
        #g = xs.connection_graph()
        g = xs.detailed_connection_graph()

        nx.write_dot(g, 'graph.dot')
        subprocess.call(['dot', '-Tpng', 'graph.dot', '-o', 'graph.png'])

        # Matplotlib
        #pos = nx.spring_layout(g)
        #nx.draw_networkx_nodes(g, pos)
        #nx.draw_networkx_edges(g, pos, arrows=True)
        #nx.draw_networkx_labels(g, pos)
        #plt.axis('off')
        #plt.savefig('graph.png')

    connections.add_command(graph)


def init_cli_deployment_config():
    @click.command()
    @click.argument('filepath')
    def deploy(filepath):
        print 'Deploying from file {}'.format(filepath)
        xd.deploy(filepath)

    cli.add_command(deploy)


if __name__ == '__main__':
    init_cli_resource()
    init_cli_connect()
    init_cli_connections()
    init_cli_deployment_config()

    cli()