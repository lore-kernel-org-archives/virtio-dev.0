Return-Path: virtio-dev-return-2664-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1938D58190CD
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Nov 2017 02:39:46 -0800 (PST)
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 6 Nov 2017 10:39:24 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA461542@DGGEMA505-MBS.china.huawei.com>
References: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1509951528-30976-1-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [v21 RESEND 0/2] virtio-crypto: virtio crypto device
 specification
To: longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Luonengjun <luonengjun@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "brian.a.keating@intel.com" <brian.a.keating@intel.com>, "liang.j.ma@intel.com" <liang.j.ma@intel.com>, "john.griffin@intel.com" <john.griffin@intel.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "agraf@suse.de" <agraf@suse.de>, "jasowang@redhat.com" <jasowang@redhat.com>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "Zhang, Roy Fan" <roy.fan.zhang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi guys,

What a long time iteration it is.

Hoping this is the final version if no big arguments exist as
discussed with Stefan at KVM Forum 2017 this October. People
can submit patches to fix some grammar issues or little problems,=20
and then Xin' can submit the asymmetric crypto services spec
based on this version.

I'll start a vote for virtio crypto device after one week. :)

Please reviewing in time, thanks a lot!


Regards,
-Gonglei


> -----Original Message-----
> From: longpeng
> Sent: Monday, November 06, 2017 2:59 PM
> To: qemu-devel@nongnu.org; virtio-dev@lists.oasis-open.org
> Cc: Luonengjun; mst@redhat.com; cornelia.huck@de.ibm.com;
> stefanha@redhat.com; denglingli@chinamobile.com; Jani Kokkonen;
> Ola.Liljedahl@arm.com; Varun.Sethi@freescale.com; xin.zeng@intel.com;
> brian.a.keating@intel.com; liang.j.ma@intel.com; john.griffin@intel.com;
> Huangweidong (C); agraf@suse.de; jasowang@redhat.com;
> vincent.jardin@6wind.com; Gonglei (Arei); pasic@linux.vnet.ibm.com; wangx=
in
> (U); Zhoujian (jay); longpeng
> Subject: [v21 RESEND 0/2] virtio-crypto: virtio crypto device specificati=
on
>=20
> This is the specification about the new virtio crypto device.
>=20
> ---
> v21 -> v20
>  - rename 'queue_id' to 'reserved' [Halil]
>  - redescribe the format of the structures which using 'union'
>    in the previous version [Halil]
>=20
> v20 -> v19
>  - fix some typos and grammar fixes [Halil]
>  - make queue_id reserved [Halil]
>  - remove 'Steps of Operation'
>=20
> v19 -> v18:
>  - fix some typos and grammar fixes [Stefan, Halil]
>  - rename VIRTIO_CRYPTO_F_STATELESS_MODE to
> VIRTIO_CRYPTO_F_MUX_MODE
>  - describe the VIRTIO_CRYPTO_STATUS in detial. [Halil]
>  - refactor and redescribe the controlq/dataq request's format
>    of mux mode. [Halil]
>  - other small fixes. [Halil]
>=20
> v18 -> v17:
>  - fix many English grammar problems suggested by Stefan, Thanks a lot!
>=20
> v17 -> v16:
>  - Some grammar fixes [Stefan, Halil, Michael]
>  - add a section named "Supported crypto services" in order to explain bi=
t
>    numbers and valuse clearly. [Halil, Cornelia]
>  - avoid word reptition [Halil]
>  - rename non-session mode to stateless mode [Halil]
>  - change descriptions for all elements in struct virtio_crypto_config [H=
alil]
>  - add Halil as a reviewer in the ackonwledgement part, thanks for his wo=
rk.
>  - other fixes here and there.
>=20
> Changes since v15:
>  - use feature bits for non-session mode in order to keep compatibility w=
ith
>    pre-existing code. [Halil & Michael]
>  - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control all
> other
>    non-session mode feature bits.
>  - fix some typos. [Stefan]
>  - introduce struct virtio_crypto_op_data_req_mux to support both session
>    and non-session based crypto operations and keep compatibility with
>    pre-existing code.
>=20
> Changes since v14:
>  - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
>  - correct a sentence about dataqueue and controlq in the first paragraph=
.
> [Halil]
>  - change a MAY to MUST about max_dataqueues. [Halil]
>  - add non-session mode support
>    a) add four features for different crypto services to identify wheathe=
r
> support session mode.
>    b) rewrite some
>=20
> For pervious versions of virtio crypto spec, Pls see:
>=20
> [v18]:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg444897.html
>=20
> [v14]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html
>=20
> [v13]:
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html
>=20
> For more information, please see:
>  http://qemu-project.org/Features/VirtioCrypto
>=20
> ---
> Gonglei (2):
>   virtio-crypto: Add virtio crypto device specification
>   virtio-crypto: Add conformance clauses
>=20
>  acknowledgements.tex |    3 +
>  conformance.tex      |   29 +
>  content.tex          |    2 +
>  virtio-crypto.tex    | 1426
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1460 insertions(+)
>  create mode 100644 virtio-crypto.tex
>=20
> --
> 1.8.3.1
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

