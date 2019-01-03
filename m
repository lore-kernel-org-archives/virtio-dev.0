Return-Path: virtio-dev-return-5238-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB8DA985C1A
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Jan 2019 16:08:12 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  3 Jan 2019 17:08:02 +0100
Message-Id: <20190103160804.21438-1-cohuck@redhat.com>
Subject: [virtio-dev] [PATCH 0/2] virtio: virtio_config_ops documentation
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, Wei Wang <wei.w.wang@intel.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

After the latest virtio-balloon changes, it became clear that
it is not obvious that some of the virtio operations (e.g.
reading or writing the config space) cannot be done from an
atomic context for all transports.

At least try to document that, and also fix some inconsistencies
I noticed along the way.

Cornelia Huck (2):
  virtio: fix virtio_config_ops description
  virtio: document virtio_config_ops restrictions

 include/linux/virtio_config.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.17.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

