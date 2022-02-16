Return-Path: <leon@kernel.org>
Date: Wed, 16 Feb 2022 09:26:56 +0200
From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
Message-ID: <YgynQGK/xog1ugEd@unreal>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Junji Wei <weijunji@bytedance.com>
Cc: Jason Wang <jasowang@redhat.com>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, yuval.shaia.ml@gmail.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Hannes Reinecke <hare@suse.de>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Yongji Xie <xieyongji@bytedance.com>, =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, Xiongchun Duan <duanxiongchun@bytedance.com>, zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com, RDMA mailing list <linux-rdma@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 16, 2022 at 03:13:11PM +0800, Junji Wei wrote:
>=20

<...>

> >> We can't. So do you mean we can implement virtio-rdma only for IB in t=
he future?
> >=20
> > It's probably virtio-IB but we need to listen to others.
>=20
> Agreed, one problem is that there might be some duplicated works.

Once it will be needed, the code can be refactored. IB and RoCE are
different from user perspective, so combining them into one virtio-rdma
module doesn't give too much advantage.

>=20
> >=20
> >>=20
> >>>> And currently virtio-rdma doesn't have a strong dependency on
> >>>> virtio-net (except for gid and ah stuffs). Is it OK to mix them up?
> >>>=20
> >>> There are a bunch of hardware vendors that ship a converged Ethernet
> >>> adapter. It simplifies the management and deployment.
> >>=20
> >> Virtio-rdma is not depend on virtio-net, we can bind it to another eth=
ernet device
> >> via mac address in the future. And is it too mass to mix up two differ=
ent device
> >> in one spec?
> >=20
> > So either should be fine, we just need to figure out which one is
> > better. What I meant is to extend the virtio-net to be capable of
> > converged ethernet.
>=20
> Got it. One question is whether there will be some cases that user want
> to use virtio-rdma binding to other types of ethernet device such as
> passthroughed net device. In this case, we don=E2=80=99t need a virtio-ne=
t
> device actually.

What is the use case for this virtio-rdma? Especially in context of RXE.

Thanks

>=20
> Thanks.
>=20

