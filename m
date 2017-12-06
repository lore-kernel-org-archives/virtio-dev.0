Return-Path: virtio-dev-return-2766-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 612E158180CA
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 23:38:28 -0800 (PST)
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Wed, 6 Dec 2017 15:37:18 +0800
Message-ID: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [virtio-dev] [v22 0/2] virtio-crypto: virtio crypto device specification
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This is the specification about the new virtio crypto device.

---
v22 -> v21
 - fix some typos and grammar fixes [Halil, Stefan]
 - reorder names in alphabetical order [Stefan]
 - redescribe the date format [Halil]

v21 -> v20
 - rename 'queue_id' to 'reserved' [Halil]
 - redescribe the format of the structures which using 'union'
   in the previous version [Halil]

v20 -> v19
 - fix some typos and grammar fixes [Halil]
 - make queue_id reserved [Halil]
 - remove 'Steps of Operation'

v19 -> v18:
 - fix some typos and grammar fixes [Stefan, Halil]
 - rename VIRTIO_CRYPTO_F_STATELESS_MODE to VIRTIO_CRYPTO_F_MUX_MODE
 - describe the VIRTIO_CRYPTO_STATUS in detial. [Halil]
 - refactor and redescribe the controlq/dataq request's format
   of mux mode. [Halil]
 - other small fixes. [Halil]

v18 -> v17:
 - fix many English grammar problems suggested by Stefan, Thanks a lot!

v17 -> v16:
 - Some grammar fixes [Stefan, Halil, Michael]
 - add a section named "Supported crypto services" in order to explain bit
   numbers and valuse clearly. [Halil, Cornelia]
 - avoid word reptition [Halil]
 - rename non-session mode to stateless mode [Halil]
 - change descriptions for all elements in struct virtio_crypto_config [Halil]
 - add Halil as a reviewer in the ackonwledgement part, thanks for his work.
 - other fixes here and there.

Changes since v15:
 - use feature bits for non-session mode in order to keep compatibility with
   pre-existing code. [Halil & Michael]
 - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control all other
   non-session mode feature bits.
 - fix some typos. [Stefan]
 - introduce struct virtio_crypto_op_data_req_mux to support both session
   and non-session based crypto operations and keep compatibility with
   pre-existing code.

Changes since v14:
 - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
 - correct a sentence about dataqueue and controlq in the first paragraph. 
[Halil]
 - change a MAY to MUST about max_dataqueues. [Halil]
 - add non-session mode support
   a) add four features for different crypto services to identify wheather 
support session mode.
   b) rewrite some

For pervious versions of virtio crypto spec, Pls see:

[v18]:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg444897.html

[v14]:
https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html

[v13]:
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html

For more information, please see:
 http://qemu-project.org/Features/VirtioCrypto

---
Gonglei (2):
  virtio-crypto: Add virtio crypto device specification
  virtio-crypto: Add conformance clauses

 acknowledgements.tex |    4 +
 conformance.tex      |   29 +
 content.tex          |    2 +
 virtio-crypto.tex    | 1510 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1545 insertions(+)
 create mode 100644 virtio-crypto.tex

-- 
1.8.3.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

