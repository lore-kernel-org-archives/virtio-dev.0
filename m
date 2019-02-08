Return-Path: virtio-dev-return-5380-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05C81986027
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Feb 2019 07:57:13 +0000 (UTC)
Date: Fri, 8 Feb 2019 15:57:03 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190208075703.GK16257@stefanha-x1.localdomain>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190205100427.GA2693@work-vm>
 <CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
 <20190206070350.vaonutyqljccuh5y@sirius.home.kraxel.org>
 <CAEkmjvUHzSx-Vr2O4MWDN4Cmqe-+dm9N6hbxg7gLu-SUUo6u6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <CAEkmjvUHzSx-Vr2O4MWDN4Cmqe-+dm9N6hbxg7gLu-SUUo6u6Q@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Roman Kiryanov <rkir@google.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 06, 2019 at 07:09:36AM -0800, Frank Yang wrote:
> I've looked at virtio-vsock and it seems general, but requires Unix
> sockets, which is not going to work for us on Windows and not going to work
> as expected on macOS (most likely). Is there anything that is similar to
> and as portable as goldfish pipe which is more like a raw virtqueue? This
> would then work on memory in the same process, with callbacks registered to
> trigger upon transmission.

virtio-vsock is independent of UNIX domain sockets.  I'm not sure what
you mean here.

I think Linaro implemented virtio-vsock inside QEMU for the Android
emulator but I'm not sure how far they got.  Today virtio-vsock relies
on a Linux host machine because the vhost_vsock.ko driver is used to
integrate into the host network stack.  The Linaro implementation moved
that into QEMU userspace (with the drawback that socket(AF_VSOCK) no
longer works on the host and you need to talk to QEMU instead).

Stefan

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcXTZPAAoJEJykq7OBq3PI/GEIALq+M6L0v63b+bjk+PIPID70
Jsob5xpejzXZLU2+EtdR3ZuM2mV4hGFO+/AfBtBqUyh8B/ZhqU2MzVpX1ox6/HAt
e2gmdyZOKE/1lqFRGziDFRFYFjMMa06fUTK5f4aG1bTTpStKGVJYSEh1O75ZHjRP
swaAsiTmuF0ZYMIjjX8C5CyfAOV2P8mWRpR8GvUdNG+jtKQBtDyzBjUhRzecrARq
oBqWFfkHlOaUCPbbbRTBfy5Yl07vXE9d6b7N+2Gpuy7HWTEtq2n65guaDq6Lu/80
pknn7SWfDkBYoSsmqZEKriYwWwbNQJrysRiiyy2Dnu0w/OZ2HdEMPBCdbyvjZWQ=
=urp/
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
