Return-Path: virtio-dev-return-5700-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CBB8984364
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Apr 2019 13:48:07 +0000 (UTC)
Date: Mon, 29 Apr 2019 09:47:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190429134754.GI7587@stefanha-x1.localdomain>
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7IgncvKP0CVPV/ZZ"
Content-Disposition: inline
In-Reply-To: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Marco Martinelli - 13Byte srl <marco@13byte.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--7IgncvKP0CVPV/ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 12:22:41AM +0200, Marco Martinelli - 13Byte srl wro=
te:
> Hi everyone,
>=20
> my name is Marco, from Italy. I'm a developer that recently got an intere=
st
> in improving the current situation of audio in qemu/kvm.
>=20
> I've been working successfully on multiple patches for Scream
> (https://github.com/duncanthrax/scream
> <https://github.com/duncanthrax/scream> ), a virtual sound card for
> Microsoft Windows, that allow to transfer audio from a Windows VM to a Li=
nux
> host. The project initially supported only stereo sound over the network,
> but with my patches now it support up to 7.1 surround and it can transfer
> the audio samples using shared memory between the VM and the host (based =
on
> IVSHMEM), for lower latency.
>=20
> Now that was a good project, but I want to do more. I dream of an
> virtio-audio device that can handle multichannel audio in and out of the =
VM,
> to be used with more guest OSs than just Windows.
>=20
> I know I have a long way to go to reach this goal, but I'm motivated and
> willing to learn. I admit I don't have much experience with the qemu sour=
ce
> code or the virtio source code, but I learn fast.
>=20
> My work on Scream was to familiarize with Windows driver development,
> VM-to-host communication and low latency audio processing.
> My idea is to start with small self-contained projects to familiarize with
> the source codes of the various projects and gain the experience I lack,
> then moving on the real virtio-audio project.
> This way I can both obtain more knowledge on the subjects and help the op=
en
> source community that over the years have done so much for many.
>=20
> As we speak I'm reading the VirtIO documentation, where I've found out th=
at
> I need to require a new device number for this project (Appendix B.3). So,
> here I am.
>=20
> I'm not quite sure if this email is enough to obtain a new number or if I
> need to follow some process I'm not aware of. In the meantime I'm using t=
he
> device number 65535 as documented in the specifications.
>=20
> Looking around I've seen there is a recent issue on GitHub to reserve a
> virtio-audio device id, and a patch was submitter to assign id 25 to audio
> devices.

Is this the same virtio-audio device type that you want to work on or is
this an independent effort from another author?  It seems important to
contact the author (if it's not you) to find out the status of their
device and see what work can be shared.

> I'm not sure how this works, is that number already assigned and I should
> use that or should I get a new one?
>=20
> For last, I have a question to clear the things up for me. It is my
> understanding that in this mailing list you discuss about the
> specifications, not the actual code. What's the usual process when writin=
g a
> new virtio device?
> Should I start with writing the code and then document how it works or is=
 it
> the opposite? Should I document it and have it approved and then implement
> the specifications?
>=20
> I know that this may sound like a stupid question, but please be patient
> with me, it's my first time.

I suggest posting a draft specification for the new device type before
investing too much time in the implementation.

Then work on the code while the spec discussion is ongoing.  This way
you won't have to wait too long before implementation but you also won't
find that reviewers are asking for large changes after you completed
your work.

Stefan

--7IgncvKP0CVPV/ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcxwCKAAoJEJykq7OBq3PIk/sH/0lhwruiPh6omaNYZELl2d53
ZZ9jojZz93qI4PeIb0OYwQOFepeQ2wnH6gzP2GUXeEYQP+Nh9PfsTKlGdLVI4g9a
6dvIZDtkWlYxlyjfQf5ikeZuFes8sp3AaU5CKazEbbDmm716x5SB4AXDgollrxXX
CGOYLORpaOSB9bFINTDyQXdqhAs+9ZgODlkIHeqsqHOPuKQZJIyjMtLse2cyh+9F
ukSke2fDhCL8vVEWFTU1F0t58zg4ti3xmgIBCcUV9/YQXePhD4kLKI4N74YOjS3d
3lYEIEx9fbiLdUHF4wDGctkxsIhR8gN5ofQ4nLZgfs1vbW159HL8jtuSMIm6rgY=
=DgO2
-----END PGP SIGNATURE-----

--7IgncvKP0CVPV/ZZ--
