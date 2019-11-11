Return-Path: virtio-dev-return-6315-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BA8D985DE9
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Nov 2019 17:18:27 +0000 (UTC)
MIME-Version: 1.0
References: <4fa78a91-751d-a7b5-fadf-b0ae8a5d5903@siemens.com>
In-Reply-To: <4fa78a91-751d-a7b5-fadf-b0ae8a5d5903@siemens.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Mon, 11 Nov 2019 12:17:51 -0500
Message-ID: <CAJPjb1+Jnm-eHUQSFjhRBKAFNKqceHQMdRWtKEG+uncypGYKcA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] split-ring: Demand that a device must not
 change descriptor entries
Content-Type: multipart/alternative; boundary="000000000000a73cf50597155192"
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000a73cf50597155192
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

what is trying to be solved here? There is a reason why this is allowed as
some vendors update the table when using RX_MERABLE_BUFFERs & F_IN_ORDER
features

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Mon, Nov 11, 2019 at 12:13 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> So far the spec only indirectly says that a descriptor table entry is
> not modified by a device when processing it. Make this explicit by
> adding it as normative requirement. Existing drivers already depend on
> this.
>
> See also
> https://lists.oasis-open.org/archives/virtio-dev/201910/msg00057.html.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  split-ring.tex | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/split-ring.tex b/split-ring.tex
> index 123ac9f..bfef62d 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -217,7 +217,7 @@ \subsection{The Virtqueue Descriptor
> Table}\label{sec:Basic Facilities of a Virt
>  \devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic
> Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Tab=
le}
>  A device MUST NOT write to a device-readable buffer, and a device SHOULD
> NOT
>  read a device-writable buffer (it MAY do so for debugging or diagnostic
> -purposes).
> +purposes). A device MUST NOT write to any descriptor table entry.
>
>  \drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic
> Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Tab=
le}
>  Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in
> total;
> --
> 2.16.4
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

--000000000000a73cf50597155192
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">what is trying to be solved=C2=A0here? There is a reason w=
hy this is allowed as some vendors update the table when using RX_MERABLE_B=
UFFERs &amp; F_IN_ORDER features<div><br clear=3D"all"><div><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"=
ltr">Rob Miller<div><a href=3D"mailto:rob.miller@broadcom.com" target=3D"_b=
lank">rob.miller@broadcom.com</a></div><div>(919)721-3339</div></div></div>=
</div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon, Nov 11, 2019 at 12:13 PM Jan Kiszka &lt;<a href=3D"=
mailto:jan.kiszka@siemens.com">jan.kiszka@siemens.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">From: Jan Kiszka &lt;<=
a href=3D"mailto:jan.kiszka@siemens.com" target=3D"_blank">jan.kiszka@sieme=
ns.com</a>&gt;<br>
<br>
So far the spec only indirectly says that a descriptor table entry is<br>
not modified by a device when processing it. Make this explicit by<br>
adding it as normative requirement. Existing drivers already depend on<br>
this.<br>
<br>
See also <a href=3D"https://lists.oasis-open.org/archives/virtio-dev/201910=
/msg00057.html" rel=3D"noreferrer" target=3D"_blank">https://lists.oasis-op=
en.org/archives/virtio-dev/201910/msg00057.html</a>.<br>
<br>
Signed-off-by: Jan Kiszka &lt;<a href=3D"mailto:jan.kiszka@siemens.com" tar=
get=3D"_blank">jan.kiszka@siemens.com</a>&gt;<br>
---<br>
=C2=A0split-ring.tex | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/split-ring.tex b/split-ring.tex<br>
index 123ac9f..bfef62d 100644<br>
--- a/split-ring.tex<br>
+++ b/split-ring.tex<br>
@@ -217,7 +217,7 @@ \subsection{The Virtqueue Descriptor Table}\label{sec:B=
asic Facilities of a Virt<br>
=C2=A0\devicenormative{\subsubsection}{The Virtqueue Descriptor Table}{Basi=
c Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Tab=
le}<br>
=C2=A0A device MUST NOT write to a device-readable buffer, and a device SHO=
ULD NOT<br>
=C2=A0read a device-writable buffer (it MAY do so for debugging or diagnost=
ic<br>
-purposes).<br>
+purposes). A device MUST NOT write to any descriptor table entry.<br>
<br>
=C2=A0\drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basi=
c Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Tab=
le}<br>
=C2=A0Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in=
 total;<br>
-- <br>
2.16.4<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div>

--000000000000a73cf50597155192--

