Return-Path: <xieyongji@bytedance.com>
MIME-Version: 1.0
References: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com> <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com> <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com> <YgzIfyx7WyGb39mV@unreal>
 <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com> <Ygzo2nMVicb3jkAn@unreal>
In-Reply-To: <Ygzo2nMVicb3jkAn@unreal>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Wed, 16 Feb 2022 22:08:19 +0800
Message-ID: <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Leon Romanovsky <leon@kernel.org>
Cc: Junji Wei <weijunji@bytedance.com>, Jason Wang <jasowang@redhat.com>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, yuval.shaia.ml@gmail.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Hannes Reinecke <hare@suse.de>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, Xiongchun Duan <duanxiongchun@bytedance.com>, zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com, RDMA mailing list <linux-rdma@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 16, 2022 at 8:06 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:
> >
> > > On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
> > >
> > > <...>
> > >
> > >>>
> > >>> What is the use case for this virtio-rdma? Especially in context of=
 RXE.
> > >>
> > >> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can u=
se RXE directly.
> > >
> > > It doesn't sound like a good sales pitch.
> >
> > Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t find a=
 user case
> > for virtio-rdma with passthrough net device. Do you want to know the us=
er
> > case for our virtio-rdma(RoCE) proposal?
>
> Yes, please.
>

I think one point is: when running RDMA accelerated applications in
VM, the virtio-rdma solution should get better performance than RXE
since it has a shorter data path (guest app -> host dpdk, bypass guest
kernel).

Thanks,
Yongji

