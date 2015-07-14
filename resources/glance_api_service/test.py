import json
import requests

from solar.core.log import log


def test(resource):
    log.debug('Testing glance_service')
    token_data = requests.post(
        'http://%s:%s/v2.0/tokens' % (resource.args['ip'].value, resource.args['keystone_port'].value),
        json.dumps({
            'auth': {
                'tenantName': 'services',
                'passwordCredentials': {
                    'username': 'glance_admin',
                    'password': resource.args['keystone_password'].value,
                }
            }
        }),
        headers={'Content-Type': 'application/json'}
    )

    token = token_data.json()['access']['token']['id']
    log.debug('GLANCE TOKEN: %s', token)

    images = requests.get(
        'http://%s:%s/v1/images' % (resource.args['ip'].value, 9393),
        headers={'X-Auth-Token': token}
    )
    assert images.json() == {'images': []}