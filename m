Return-Path: <virtio-dev-return-13650-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9677BEC8750
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 19:23:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AA259C623C
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 19:23:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83C05986639
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 19:23:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 636EA986602; Thu,  7 Sep 2023 19:23:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53508986603
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Sep 2023 19:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8Z1d3j7iNpqKRZCxesihRg-1
Date: Thu, 7 Sep 2023 15:22:59 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: slp@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org
Message-ID: <20230907192259.GC1560640@fedora>
References: <20230901110018.3704459-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lgoOqfMumJCnPwrC"
Content-Disposition: inline
In-Reply-To: <20230901110018.3704459-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [RFC PATCH v2] docs/interop: define PROBE feature for vhost-user
 VirtIO devices

--lgoOqfMumJCnPwrC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 12:00:18PM +0100, Alex Benn=E9e wrote:
> Currently QEMU has to know some details about the VirtIO device
> supported by a vhost-user daemon to be able to setup the guest. This
> makes it hard for QEMU to add support for additional vhost-user
> daemons without adding specific stubs for each additional VirtIO
> device.
>=20
> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.
>=20
> Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
> VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
> daemons which are capable of handling all aspects of the VirtIO
> transactions with only a generic stub on the QEMU side. These daemons
> can also be used without QEMU in situations where there isn't a full
> VMM managing their setup.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

I think the mindset for this change should be "vhost-user is becoming a
VIRTIO Transport". VIRTIO Transports have a reasonably well-defined
feature set in the VIRTIO specification. The goal should be to cover
every VIRTIO Transport operation via vhost-user protocol messages so
that the VIRTIO device model can be fully conveyed over vhost-user.

Anything less is yet another ad-hoc protocol extension that will lead to
more bugs and hacks when it turns out some VIRTIO devices cannot be
expressed due to limitations in the protocol.

This requires going through the VIRTIO spec to find a correspondence
between virtio-pci/virtio-mmio/virtio-ccw's interfaces and vhost-user
protocol messages. In most cases vhost-user already offers messages and
your patch adds more of what is missing. I think this effort is already
very close but missing the final check that it really matches the VIRTIO
spec.

Please do the comparison against the VIRTIO Transports and then adjust
this patch to make it clear that the back-end is becoming a full-fledged
VIRTIO Transport:
- The name of the patch series should reflect that.
- The vhost-user protocol feature should be named F_TRANSPORT.
- The messages added in this patch should have a 1:1 correspondence with
  the VIRTIO spec including using the same terminology for consistency.

Sorry for the hassle, but I think this is a really crucial point where
we have the chance to make vhost-user work smoothly in the future...but
only if we can faithfully expose VIRTIO Transport semantics.

>=20
> ---
> v2
>   - dropped F_STANDALONE in favour of F_PROBE
>   - split probe details across several messages
>   - probe messages don't automatically imply a standalone daemon
>   - add wording where probe details interact (F_MQ/F_CONFIG)
>   - define VMM and make clear QEMU is only one of many potential VMMs
>   - reword commit message
> ---
>  docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++-----
>  hw/virtio/vhost-user.c      |  8 ++++
>  2 files changed, 88 insertions(+), 10 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..ba3b5e07b7 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -7,6 +7,7 @@ Vhost-user Protocol
>  ..
>    Copyright 2014 Virtual Open Systems Sarl.
>    Copyright 2019 Intel Corporation
> +  Copyright 2023 Linaro Ltd
>    Licence: This work is licensed under the terms of the GNU GPL,
>             version 2 or later. See the COPYING file in the top-level
>             directory.
> @@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication, *f=
ront-end* and
>  *back-end*. The *front-end* is the application that shares its virtqueue=
s, in
>  our case QEMU. The *back-end* is the consumer of the virtqueues.
> =20
> -In the current implementation QEMU is the *front-end*, and the *back-end*
> -is the external process consuming the virtio queues, for example a
> -software Ethernet switch running in user space, such as Snabbswitch,
> -or a block device back-end processing read & write to a virtual
> -disk. In order to facilitate interoperability between various back-end
> -implementations, it is recommended to follow the :ref:`Backend program
> -conventions <backend_conventions>`.
> +In the current implementation a Virtual Machine Manager (VMM) such as
> +QEMU is the *front-end*, and the *back-end* is the external process
> +consuming the virtio queues, for example a software Ethernet switch
> +running in user space, such as Snabbswitch, or a block device back-end
> +processing read & write to a virtual disk. In order to facilitate
> +interoperability between various back-end implementations, it is
> +recommended to follow the :ref:`Backend program conventions
> +<backend_conventions>`.
> =20
>  The *front-end* and *back-end* can be either a client (i.e. connecting) =
or
>  server (listening) in the socket communication.
> =20
> +Probing device details
> +----------------------
> +
> +Traditionally the vhost-user daemon *back-end* shares configuration
> +responsibilities with the VMM *front-end* which needs to know certain
> +key bits of information about the device. This means the VMM needs to
> +define at least a minimal stub for each VirtIO device it wants to
> +support. If the daemon supports the right set of protocol features the
> +VMM can probe the daemon for the information it needs to setup the
> +device.

"... without a per-device stub in the VMM"

This makes it clear that this sentence is describing an alternative
to the per-device stub in the VMM.

> See :ref:`Probing features for standalone daemons
> +<probing_features>` for more details.

The current section is named "Probing device details" and one being
reference is called "Probing features for standalone daemons". Are
"features" or "device details" two terms for the same thing? Why
"daemons" and not "back-end"?

I suggest calling this section "Standalone back-ends" and the other
section "Probing standalone back-ends" to keep the terminology
consistent.

> +
> +
>  Support for platforms other than Linux
>  --------------------------------------
> =20
> @@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
>  * ``VHOST_USER_GET_VRING_BASE``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SH=
MFD``)
> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALON=
E``)

F_STANDALONE vs F_PROBE

"SPECS" vs "features" vs "details".

Please be consistent.

> =20
>  .. seealso::
> =20
> @@ -396,9 +412,10 @@ must support changing some configuration aspects on =
the fly.
>  Multiple queue support
>  ----------------------
> =20
> -Many devices have a fixed number of virtqueues.  In this case the front-=
end
> -already knows the number of available virtqueues without communicating w=
ith the
> -back-end.
> +Many devices have a fixed number of virtqueues. In this case the
> +*front-end* usually already knows the number of available virtqueues
> +without communicating with the back-end. For standalone daemons this

"Usually" is vague. It's possible to be precise:

  In this case a front-end that is aware of the device type already
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  knows the number of available virtqueues without communicating with
  the back-end.

> +number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` message.

Then this sentence can be adjusted to:

  When the front-end is not aware of the device type, the number can be
  probed with the ``VHOST_USER_GET_MIN_VQ`` message.

> =20
>  Some devices do not have a fixed number of virtqueues.  Instead the maxi=
mum
>  number of virtqueues is chosen by the back-end.  The number can depend o=
n host
> @@ -885,6 +902,23 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> +  #define VHOST_USER_PROTOCOL_F_PROBE                18
> +
> +.. _probing_features:
> +
> +Probing features for standalone daemons
> +---------------------------------------
> +
> +The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
> +of additional messages which allow the *front-end* to probe details
> +about the VirtIO device from the *back-end*. However for a *back-end*
> +to be described as standalone it must also support:
> +
> +  * ``VHOST_USER_PROTOCOL_F_STATUS``
> +  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
> +
> +which are required to ensure the *back-end* daemon can operate
> +without the *front-end* managing some aspects of its configuration.
> =20
>  Front-end message types
>  -----------------------
> @@ -1440,6 +1474,42 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
> =20
> +``VHOST_USER_GET_DEVICE_ID``
> +  :id: 41
> +  :request payload: N/A
> +  :reply payload: ``u32``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end
> +  to query what VirtIO device the back-end support. This is intended
> +  to remove the need for the front-end to know ahead of time what the
> +  VirtIO device the backend emulates is.

"... VIRTIO device type that the backend emulates is."

"Device type" is the name used in the VIRTIO spec.

> +
> +``VHOST_USER_GET_CONFIG_SIZE``
> +  :id: 42
> +  :request payload: N/A
> +  :reply payload: ``u32``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end
> +  to query the size of the VirtIO device's config space. This is
> +  intended to remove the need for the front-end to know ahead of time
> +  what the size is. Replying with 0 when
> +  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
> +  an bug.

"a bug"

What is the harm in returning 0 when the device has an empty
Configuration Space like the Entropy device, the I2C Adapter, the SCMI
device, etc?

> +
> +``VHOST_USER_GET_MIN_VQ``
> +  :id: 43
> +  :request payload: N/A
> +  :reply payload: ``u32``
> +
> +  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end to
> +  query minimum number of VQ's required to support the device. A
> +  device may support more than this number of VQ's if it advertises
> +  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
> +  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` would
> +  indicate a bug.

What is the purpose of this message? I don't see an equivalent in the
VIRTIO specification.

> =20
>  Back-end message types
>  ----------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 8dcf049d42..4d433cdf2b 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>      uint16_t queue_size;
>  } VhostUserInflight;
> =20
> +typedef struct VhostUserBackendSpecs {
> +    uint32_t device_id;
> +    uint32_t config_size;
> +    uint32_t min_vqs;
> +    uint32_t max_vqs;
> +} VhostUserBackendSpecs;

This message is undocumented? I think it may be outdated and you split
it up into individual messages.

> +
>  typedef struct {
>      VhostUserRequest request;
> =20
> @@ -226,6 +233,7 @@ typedef union {
>          VhostUserCryptoSession session;
>          VhostUserVringArea area;
>          VhostUserInflight inflight;
> +        VhostUserBackendSpecs specs;
>  } VhostUserPayload;
> =20
>  typedef struct VhostUserMsg {
> --=20
> 2.39.2
>=20

--lgoOqfMumJCnPwrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6IxMACgkQnKSrs4Gr
c8iSjgf+IkWolVeNkg3f2aGMQM2FHN/Q0VIUNrNdUOo7YejI8Sivh0aXa2vI4Gll
XtKbXHGhvs/jPj6830VDtka4pZENZbUAhL59Zg0xNc1/SYMoXxZX39nf+K6lVSbI
S3HvV1bsHqan89BYaUB2Vc6kbPZ7HkIVgKwugVPrn6WnjwJw+QOJqMWGXw9wpDa6
6wVvY6R6yJg+Uv92Gm4G5Xc4SPVOoVmdgySpO2XKFTip9Id4rcEHqGoFS0n37XJd
7yhSWoNfj/h1Z+jcuFnHnMFtIMUk4+0K2wEWV257q2JIe3YgUPWly6XuaebLpT5/
ugc8vv/mM+6mwZ9dmHQ6f0KPbekQug==
=2VvJ
-----END PGP SIGNATURE-----

--lgoOqfMumJCnPwrC--

