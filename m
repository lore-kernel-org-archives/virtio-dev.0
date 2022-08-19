Return-Path: <virtio-dev-return-9825-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFEF7986492
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Aug 2022 14:49:09 +0000 (UTC)
From: Gavin Li <gavinl@nvidia.com>
Date: Fri, 19 Aug 2022 17:49:02 +0300
Message-Id: <20220819144904.3332-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 0/2] Improve virtio performance for 9k mtu
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com
Cc: parav@nvidia.com, gavi@nvidia.com, gavinl@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

This small series contains two patches that improves virtio netdevice
performance for 9K mtu when GRO/ guest TSO is disabled.

Gavin Li (2):
  virtio-net: introduce and use helper function for guest gso support
    checks
  virtio-net: use mtu size as buffer length for big packets

 drivers/net/virtio_net.c | 52 +++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 16 deletions(-)

--=20
2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

