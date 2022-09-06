Return-Path: <virtio-dev-return-9897-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Alyssa Ross <hi@alyssa.is>
In-Reply-To: <87v8q1keul.fsf@linaro.org>
References: <877d61wuc0.fsf@linaro.org> <87r10svr77.fsf@alyssa.is>
 <87v8q1keul.fsf@linaro.org>
Date: Tue, 06 Sep 2022 07:47:48 +0000
Message-ID: <87bkrtc5az.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: [virtio-dev] Re: [Stratos-dev] Re: [virtio-dev] Next VirtIO device for Project
 Stratos?
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Matt Spencer <Matt.Spencer@arm.com>, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Peter Hilber <peter.hilber@opensynergy.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Puck Meerburg <puck@puckipedia.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>, Vasyl Vavrychuk <vasyl.vavrychuk@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e via Stratos-dev <stratos-dev@op-lists.linaro.org> writes:

> Alyssa Ross <hi@alyssa.is> writes:
>
>> As I understand it, virtio-wayland is effectively deprecated in favour
>> of sending Wayland messages over cross-domain virtio-gpu contexts.  It's
>> possible to do this now with an upstream kernel, whereas virtio-wayland
>> always required a custom driver in the Chromium kernel.
>
> That's good to know. I guess there is nothing that prevents the final
> display of virtual GPUs from multiple guests being mapped onto the
> final presentation? The automotive use case seems to treat each
> individual VM with a UI as presenting a surface which the final console
> manager composites up together depending on safety rules to display to
> the user.

Well, in the Wayland use case, AIUI virtio-gpu is just a transport for
the Wayland protocol + shared memory resources.  The simplest case is
just sending shared CPU memory buffers around (wl_shm), so there's not
really any GPU involved in anything but name.  Alternatively, it's
possible to use dma-bufs, and graphics acceleration through the
virtio-gpu devices, and yes, when doing that it's still possible for the
host Wayland compositor to combine everything into one presentation =E2=80=
=94 I
think they're all just dma-bufs to it.

Does that make sense?  I'm also no expert on this but hopefully I'm not
too far off.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmMW+yUACgkQ+dvtSFmy
ccD/YQ/+I03TOSPIRIahu909I7xeXIe7d8iEvbCKlYRetG90P8bp07+c6v2VKiQP
3ZJfszlWSZrZxbx70qR3Rx/odUgLmeXCCq+QJvMViCLa04L+GnOXvw0zgpniiBKD
SBcHPo10kJNLnmaMsXgg0ZhNGDjJHhPe/FgJaoBep6mlWe7/tC0w4AiEJQY5K8Er
HIg6hO4PW/aVYgjV62zN6vdW6UfmPnQfJvjNUfY3LwWlyXMXPMDt4Enzb+5Fb9q7
Z3ao2wdgiTvGWPbJG3zYssK1Rr5MTIXkryXDngHuztQqr9v0tNbvDYBvv7lYsLjH
eqttGcGKmdL+nZGEnXAev9K7aBcKk/Sz2+jMLsthzUyS+IALbFWmGu36DeBpYKS1
113CbRFl5zc25QcXsuBtfD6/ltM2BUTIt91r3wwtQehs88CiG1crfE/EAYL7UsSM
DgcvBeb9cAeTM+B+SEQCqMwZaD7T6QJTo7hMeiarDOBhX5MZTQI3zqsDw1nOXcTL
UNUbLsHgZa80IHMWyNvPFmqoC9lyBnfuKHwNnjkTixuI67uP5aC95RoVcuRrGc1I
Ill6U53IB9LslumWECsOYCr033VDef+ErfU/KoK4yF6RvF3r7VJ4E91KxuKcjPAt
TIcu3Ldc/kRgkjwUa3+Ic1PFX68u8lSUzuYqpQeKLLOC6gTxOgQ=
=sjLy
-----END PGP SIGNATURE-----
--=-=-=--

