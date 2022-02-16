Return-Path: <weijunji@bytedance.com>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
From: Junji Wei <weijunji@bytedance.com>
In-Reply-To: <YgzIfyx7WyGb39mV@unreal>
Date: Wed, 16 Feb 2022 18:03:29 +0800
Message-Id: <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
 <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com>
 <YgzIfyx7WyGb39mV@unreal>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, yuval.shaia.ml@gmail.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Hannes Reinecke <hare@suse.de>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Yongji Xie <xieyongji@bytedance.com>, =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, Xiongchun Duan <duanxiongchun@bytedance.com>, zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com, RDMA mailing list <linux-rdma@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org> wrote:
>=20
> On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
>=20
> <...>
>=20
>>>=20
>>> What is the use case for this virtio-rdma? Especially in context of RXE=
.
>>=20
>> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can use R=
XE directly.
>=20
> It doesn't sound like a good sales pitch.

Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t find a use=
r case=20
for virtio-rdma with passthrough net device. Do you want to know the user
case for our virtio-rdma(RoCE) proposal?

Thanks.

