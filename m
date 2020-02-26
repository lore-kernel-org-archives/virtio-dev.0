Return-Path: virtio-dev-return-6791-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47AB8985E00
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Feb 2020 17:05:12 +0000 (UTC)
Date: Wed, 26 Feb 2020 18:05:04 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200226180504.66596367@collabora.com>
In-Reply-To: <20200226151224.tqctou74uxdaxtut@sirius.home.kraxel.org>
References: <20200207182842.770bfb27@collabora.com>
	<20200225162105.1912fae0@collabora.com>
	<20200226151224.tqctou74uxdaxtut@sirius.home.kraxel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an
 alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 26 Feb 2020 16:12:24 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> =20
> > So, I'm about to start working on virtio-pipe (I realize the name is
> > not that great since pipes are normally unidirectional, but I'm sure
> > we'll have plenty of time to bikeshed on that particular aspect once
> > the other bits are sorted out :)). =20
>=20
> virtio-ipc?
>=20
> > This device would be a singleton
> > (there can only be one per VM), =20
>=20
> Why?
>=20
> Alex already mentioned vhost-user.  This is basically a way to emulate
> virtio devices outside qemu (not sure whenever other vmms support that
> too).  With vhost emulation is done in the kernel, with vhost-user
> emulation is done in another process instead.  Communication with qemu
> runs over a socked with messages roughly equivalent to vhost ioctls.
>=20
> There is a vhost-user implementation of virtio-gpu (see
> contrib/vhost-user-gpu/ in qemu git repo).  Main motivation is that a
> separate process can have a much stricter sandbox (no need to have
> access to network or guest disk images), which is especially useful for
> a complex thing like 3D rendering.

Okay, thanks for this explanation.

>=20
> So one possible approach for the host side implementation would be to
> write the virtio protocol parser as support library, then implement the
> host applications (i.e. the host wayland proxy) as vhost-user process
> using that library.
>=20
> That would not work well with the singleton device approach though.

Hm, so you'd have several virtio-ipc devices exposed to the guest and
the guest user would have to select one, or would the guest only see
one virtio-ipc device? When I said singleton it was from the guest
perspective (though I thought this would also apply to the host).

>=20
> A vhost-user approach would allow for multiple vmms sharing the
> implementation.  It would allow to easily pick a language other
> than C (mostly relevant for qemu, crosvm isn't C anyway ...).
>=20
> > * manage a central UUID <-> 'struct file' map that allows virtio-pipe
> >   to convert FDs to UUIDs, pass UUIDs through a pipe and convert those
> >   UUIDs back to FDs on the other end
> >   - we need to expose an API to let each subsystem register/unregister
> >     their UUID <-> FD mapping (subsystems are responsible for the UUID
> >     creation/negotiation) =20
>=20
> Do you have a rough plan how to do that?
> On the guest side?
> On the host side?

On the guest side yes, but I need to familiarize a bit more with the
host side of things. This part is not entirely clear yet, but it would
probably involve the same kind of central UUID <-> FD tracking with an
API to add/remove a mapping.


                    |
          host      |         guest
 ____________       |       ____________
|            |      |      |            |
| virtio-ipc |<---link2--->| virtio-ipc |
|____________|      |      |____________|
      A             |             A
      |             |             |
     link1          |            link4
      |             |             |
 _____|______       |       ______|_____
|            |      |      |            |
| virtio-gpu |<---link3--->| virtio-gpu |
|____________|      |      |____________|
                    |


guest side prime export + FD transfer on an IPC connection:
-----------------------------------------------------------

* guest_virtio_gpu->prime_handle_to_fd()
  + virtio_gpu_resource_to_uuid() request sent on link3 to get a UUID
    - virglrenderer_get_resource_uuid() (the UUID is generated if it
      doesn't exist yet)
    - host_virtio_gpu exports the resource to a pseudo-'struct file'
      representation ('struct file' only exists kernel side, but maybe
      we can add the concept of resource on the host user space side
      and define an interface for this resource object?)
      We'll also need resource objs to be exported as plain FDs so we
      can pass them through a unix socket.
    - host_virtio_gpu calls host_virtio_ipc_add_mapping(UUID, host_side_res=
_obj)
      on link4
  + guest_virtio_gpu calls guest_virtio_ipc_add_mapping(UUID, file)

* guest_virtio_ipc->ioctl(create_connection, service_name_or_path)
  + virtio_ipc_create_connection() request on link2
    - create an ipc connection obj
    - open unix socket at service_name_or_path
    - bridge the ipc connection send/recvmsg requests to the  local
      unix socket
[optional, only needed if we want to pass the connection FD to the host
  + virtio_ipc_connection_to_uuid() request sent on link2
    - create/get the UUID for the ipc connection object
    - attach the UUID to the ipc connection resource obj using
      host_virtio_ipc_add_mapping(UUID, host_side_connection_obj)
      (both virtio_gpu_res and virtio_ipc_conn should implement a
      common virtio_ipc_resource interface which needs to be defined)
  + guest_virtio_ipc calls
    guest_virtio_ipc_add_mapping(UUID, file)
]

* guest_virtio_ipc_connection->ioctl(sendmsg, in-band-data, fds)
  + translate FDs/'struct file's to UUIDs (error out if any of the
    mappings does not exists)
  + virtio_ipc_connection_send_msg(connection, in-band-data, UUIDs)
    request sent on link2
    - translate UUIDs back to resource objects + get a plain FDs out
      of the resource objects (->get_fd() method ?)
    - call sendmsg() on the unix sock


I'm still unsure how FDs coming from a host application can be
converted to resource objects (and then UUIDs so they can be passed
to the ipc_connection) if they've not been previously created/passed
by the guest though. If we want to support that, we probably need to
expose new per-subsystem interfaces to import resources in a VM (those
methods would create a new FD <-> resource mapping for each imported
resource). Is that a use case we care about?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

