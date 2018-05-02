Return-Path: virtio-dev-return-4034-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D2585819164
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 May 2018 12:42:14 -0700 (PDT)
MIME-Version: 1.0
From: Radhesh Krishnan K <radheshkrishnank@gmail.com>
Date: Wed, 2 May 2018 12:42:12 -0700
Message-ID: <CAMYfGhDVst56pCL2H3VsxPvkeu76POPvhkEH0VgjnpL0eVyJ9A@mail.gmail.com>
Content-Type: multipart/alternative; boundary="000000000000876341056b3e482b"
Subject: [virtio-dev] Slow access using virtio : Ramblock device
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000876341056b3e482b
Content-Type: text/plain; charset="UTF-8"

Hi Everyone,


I am attaching a ramblock device to the guest machine as a
normal block device and trying to write from the guest machine
to host's ramblock device. Block device is attached using Virtio
using following command:

``` qemu-system-x86_64 -enable-kvm  -machine type=pc,accel=kvm -cpu host
smp 1 -nographic  -k de  -m 1024  ubuntu16.04.qcow2  -drive
if=none,id=drive0,file=/dev/ram -device  virtio-blk
pci,physical_block_size=4096,logical_block_size=4096,drive=drive0```

Looks like these writes from Guest to host's RAM using Virtio is very slow
(slow like writing to a SSD).  What could be the reason for that?  Does a
write  on a virtualized blkdev will result in a VMEXIT? If not, does it
will be
"zero-copy"?  What am I missing here? Any pointers on this is greatly
appreciated.
Thanks in advance.




Regards,
Radhesh Krishnan K.

--000000000000876341056b3e482b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Everyone,<div><br></div><div><br clear=3D"all"><div><di=
v>I am attaching a ramblock device to the guest machine as a=C2=A0</div><di=
v>normal block device and trying to write from the guest machine=C2=A0</div=
><div>to host&#39;s ramblock device. Block device is attached using Virtio=
=C2=A0</div><div>using following command:</div><div><br></div><div><span st=
yle=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;fon=
t-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-=
weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tran=
sform:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;float:non=
e;display:inline">``` qemu-system-x86_64 -enable-kvm=C2=A0 -machine type=3D=
pc,accel=3Dkvm -cpu host smp 1 -nographic=C2=A0 -k de=C2=A0 -m 1024=C2=A0 u=
buntu16.04.qcow2=C2=A0 -drive if=3Dnone,id=3Ddrive0,file=3D/dev/ram -device=
=C2=A0 virtio-blk pci,physical_block_size=3D4096,logical_block_size=3D4096,=
drive=3Ddrive0```</span><br></div><div><br></div><div>Looks like these writ=
es from Guest to host&#39;s RAM using Virtio is very slow=C2=A0</div><div>(=
slow like writing to a SSD).=C2=A0 What could be the reason for that?=C2=A0=
 Does a=C2=A0</div><div>write=C2=A0 on a virtualized blkdev will result in =
a VMEXIT? If not, does it will be=C2=A0</div><div>&quot;zero-copy&quot;?=C2=
=A0 What am I missing here? Any pointers on this is greatly appreciated.</d=
iv></div><div>Thanks in advance.</div><div><br></div><div style=3D"color:rg=
b(34,34,34);font-family:arial,sans-serif;font-size:small;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:start;text-indent:0px;text-transform:none;whit=
e-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-deco=
ration-style:initial;text-decoration-color:initial"><br></div><div style=3D=
"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-styl=
e:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight=
:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:=
none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial"><br></div><div=
 class=3D"gmail_signature">
<div>=C2=A0</div>
<div>Regards,</div>
<div>Radhesh Krishnan K.</div></div>
</div></div>

--000000000000876341056b3e482b--
