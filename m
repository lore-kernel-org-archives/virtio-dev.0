Return-Path: <dledford@redhat.com>
MIME-Version: 1.0
References: <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com> <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
 <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com> <YgynQGK/xog1ugEd@unreal>
 <2818E401-AA08-42DB-90C0-75B199ECE47E@bytedance.com> <YgzIfyx7WyGb39mV@unreal>
 <38D3D312-E507-426F-BB3E-211AC273593B@bytedance.com> <Ygzo2nMVicb3jkAn@unreal>
 <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com>
In-Reply-To: <CACycT3vr8QgjR8SS7bbOGOurV5jKP9bh90jiPnekEZhqHPwtcg@mail.gmail.com>
From: Doug Ledford <dledford@redhat.com>
Date: Wed, 16 Feb 2022 10:40:59 -0500
Message-ID: <CAGbH50s1oPDRZ5VqCOkaQHvsw_OvhHMmt0UVBsmeNjhX-Xqquw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
Content-Type: multipart/alternative; boundary="000000000000fd920005d8247ea2"
To: Yongji Xie <xieyongji@bytedance.com>
Cc: Leon Romanovsky <leon@kernel.org>, Junji Wei <weijunji@bytedance.com>, Jason Wang <jasowang@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, yuval.shaia.ml@gmail.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Hannes Reinecke <hare@suse.de>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, Xiongchun Duan <duanxiongchun@bytedance.com>, zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com, RDMA mailing list <linux-rdma@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000fd920005d8247ea2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 9:08 AM Yongji Xie <xieyongji@bytedance.com> wrote:

> On Wed, Feb 16, 2022 at 8:06 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:
> > >
> > > > On Feb 16, 2022, at 5:48 PM, Leon Romanovsky <leon@kernel.org>
> wrote:
> > > >
> > > > On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:
> > > >
> > > > <...>
> > > >
> > > >>>
> > > >>> What is the use case for this virtio-rdma? Especially in context
> of RXE.
> > > >>
> > > >> Hmm... yes, we didn=E2=80=99t find one. In passthrough case we can=
 use RXE
> directly.
> > > >
> > > > It doesn't sound like a good sales pitch.
> > >
> > > Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t find=
 a user
> case
> > > for virtio-rdma with passthrough net device. Do you want to know the
> user
> > > case for our virtio-rdma(RoCE) proposal?
> >
> > Yes, please.
> >
>
> I think one point is: when running RDMA accelerated applications in
> VM, the virtio-rdma solution should get better performance than RXE
> since it has a shorter data path (guest app -> host dpdk, bypass guest
> kernel).
>

What's the security model?  Native RDMA has security on a per QP basis.
DPDK requires root/CAP_NET_RAW access and allows anything.  How are you
ensuring that rogue apps can't do bad things with this?


--=20
Doug Ledford <dledford@redhat.com>
GPG KeyID: B826A3330E572FDD
Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--000000000000fd920005d8247ea2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Feb 16, 2022 at 9:08 AM Yongji Xie &lt;<a href=3D"mailto:xie=
yongji@bytedance.com">xieyongji@bytedance.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On Wed, Feb 16, 2022 at 8:06 P=
M Leon Romanovsky &lt;<a href=3D"mailto:leon@kernel.org" target=3D"_blank">=
leon@kernel.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On Wed, Feb 16, 2022 at 06:03:29PM +0800, Junji Wei wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; On Feb 16, 2022, at 5:48 PM, Leon Romanovsky &lt;<a href=3D"=
mailto:leon@kernel.org" target=3D"_blank">leon@kernel.org</a>&gt; wrote:<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Wed, Feb 16, 2022 at 04:00:53PM +0800, Junji Wei wrote:<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &lt;...&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; What is the use case for this virtio-rdma? Especiall=
y in context of RXE.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Hmm... yes, we didn=E2=80=99t find one. In passthrough c=
ase we can use RXE directly.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; It doesn&#39;t sound like a good sales pitch.<br>
&gt; &gt;<br>
&gt; &gt; Maybe I misunderstanded what you mean. We mean we didn=E2=80=99t =
find a user case<br>
&gt; &gt; for virtio-rdma with passthrough net device. Do you want to know =
the user<br>
&gt; &gt; case for our virtio-rdma(RoCE) proposal?<br>
&gt;<br>
&gt; Yes, please.<br>
&gt;<br>
<br>
I think one point is: when running RDMA accelerated applications in<br>
VM, the virtio-rdma solution should get better performance than RXE<br>
since it has a shorter data path (guest app -&gt; host dpdk, bypass guest<b=
r>
kernel).<br></blockquote><div><br></div><div>What&#39;s the security model?=
=C2=A0 Native RDMA has security on a per QP basis.=C2=A0 DPDK requires root=
/CAP_NET_RAW access and allows anything.=C2=A0 How are you ensuring that ro=
gue apps can&#39;t do bad things with this? <br></div></div><br clear=3D"al=
l"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><=
div>Doug Ledford &lt;<a href=3D"mailto:dledford@redhat.com" target=3D"_blan=
k">dledford@redhat.com</a>&gt;</div><div style=3D"margin-left:40px">GPG Key=
ID: B826A3330E572FDD <br></div><div style=3D"margin-left:40px">Key fingerpr=
int =3D AE6B 1BDA 122B 23B4 265B=C2=A0 1274 B826 A333 0E57 2FDD<br></div></=
div></div></div>

--000000000000fd920005d8247ea2--

