Return-Path: virtio-dev-return-2522-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DDE758190CD
	for <virtio-dev@lists.oasis-open.org>; Sun, 10 Sep 2017 18:11:28 -0700 (PDT)
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:32 +0800
Message-ID: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [virtio-dev] [RFC 0/8] virtio-crypto: add multiplexing mode support
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

*NOTE*
The code realization is based on the latest virtio crypto spec:
 [PATCH v19 0/2] virtio-crypto: virtio crypto device specification
   https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05217.html

In session mode, the process of create/close a session
makes we have a least one full round-trip cost from guest to host to guest
to be able to send any data for symmetric algorithms. It gets ourself into
synchronization troubles in some scenarios like a web server handling lots
of small requests whose algorithms and keys are different.

We can support one-blob request (no sessions) as well for symmetric
algorithms, including HASH, MAC services. The benefit is obvious for
HASH service because it's usually a one-blob operation.

Gonglei (3):
  virtio-crypto: add stateless crypto request handler
  cryptodev: extract one util function
  virtio-crypto: add host feature bits support

Longpeng(Mike) (5):
  virtio-crypto: add new definations for multiplexing mode
  virtio-crypto: add session creation logic for mux mode
  virtio-crypto: add dataq operation logic for mux mode
  cryptodev: add stateless mode cipher support
  cryptodev-builtin: add stateless cipher support

 backends/cryptodev-builtin.c                   | 189 ++++++++---
 backends/cryptodev.c                           |  21 ++
 hw/virtio/virtio-crypto.c                      | 433 +++++++++++++++++++++++--
 include/hw/virtio/virtio-crypto.h              |   2 +
 include/standard-headers/linux/virtio_crypto.h | 182 ++++++++++-
 include/sysemu/cryptodev.h                     |  21 ++
 6 files changed, 774 insertions(+), 74 deletions(-)

-- 
1.8.3.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

