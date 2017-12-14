Return-Path: virtio-dev-return-2830-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C39B5818D93
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Dec 2017 12:31:57 -0800 (PST)
From: Jason Baron <jbaron@akamai.com>
Message-ID: <bf96d8c2-4aac-cdfd-24b9-218e0f89a7ef@akamai.com>
Date: Thu, 14 Dec 2017 15:31:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Add VIRTIO_NET_F_SPEED_DUPLEX (4) feature bit
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

We have found it useful to have the virtio net device export a linkspeed
and duplex setting, such that a guest linkspeed and duplex settings can
be set automatically from the host side. We have some guest software
that relies on this setting, and fails without a valid value provided.
Thus, I would like to propose adding a new feature bit:

VIRTIO_NET_F_SPEED_DUPLEX (4) Device provides a linkspeed and duplex setting

I have provided sample qemu hypervisor and linux kernel guest code to
implement this feature here:

http://lkml.iu.edu/hypermail/linux/kernel/1712.1/05692.html

Thanks,

-Jason

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

