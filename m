Return-Path: virtio-dev-return-2854-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 165A258190D3
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Dec 2017 03:35:22 -0800 (PST)
Date: Tue, 19 Dec 2017 11:35:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171219113505.GA8499@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM communication
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:33:09AM +0800, Wei Wang wrote:
> Vhost-pci is a point-to-point based inter-VM communication solution. This
> patch series implements the vhost-pci-net device setup and emulation. The
> device is implemented as a virtio device, and it is set up via the
> vhost-user protocol to get the neessary info (e.g the memory info of the
> remote VM, vring info).
>=20
> Currently, only the fundamental functions are implemented. More features,
> such as MQ and live migration, will be updated in the future.
>=20
> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
> http://dpdk.org/ml/archives/dev/2017-November/082615.html

This thread has become long so I've summarized outstanding issues:

 * Whether to define a virtio device for each device type or to have a sing=
le
   virtio device that speaks the vhost-user protocol.  Discussion ongoing.

 * Please structure the code so there is a common vhost-pci component that
   other device types (scsi, blk) could use.  This will show that the code =
is
   designed with other device types (scsi, blk) in mind.

 * Please validate all inputs from vhost-user protocol messages to protect
   against buffer overflows and other bugs.

 * Please handle short reads/writes and EAGAIN with the UNIX domain socket.=
  Do
   not use read/write_all() functions because they hang QEMU until I/O
   completes.

 * What happens when the vhost-user master disconnects while we're running?

 * How does the guest know when the QEMU vhost-user slave has finished
   initializing everything?  It seems like a guest driver could access the
   device before things are initialized.

 * How can the vhost-user slave inside the guest participate in feature
   negotiation?  It must be able to participate, otherwise slaves cannot
   disable features that QEMU supports but they don't want to support.

   It's not feasible to pass in host_features as a QEMU parameter because
   that would require libvirt, OpenStack, cloud providers, etc to add
   support so users can manually set the bits for their slave
   implementation.

 * How can the the guest limit the number of virtqueues?

 * Please include tests.  See tests/virtio-net-test.c and
   tests/vhost-user-test.c for examples.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOPlpAAoJEJykq7OBq3PI13YH/Rw3/QmvSXYL4F/riixoW0Wp
ar9AVht/MIYYZsaeQYgeffAhodUgYvNsuW4M2OgFv1/u2rQwKU2x+09cA4qLvY0Y
OqGRpPEXzr5k0UGtlJCn+d6cAUwvYgnftu7L30vKbgHUb+cH/3u2lDGzfi6s5wfz
BnQNSO3PBpne7syqS3yFQeUT22XzbYjB4LE95/ZvCnDWeqBY86F1Rh0W8p+Z8IEN
2DJg3raO3qyeQf8DylHWYQVHb4w/Gl7UfNoYcgzZWn3O/WYoBzdBs8062HwUGE2K
0qnM1Fy3hGtdX9jr1t8/nUTlVvhly/heYzrBth7Cr72XTHw//5kIrrVYXGSCpuc=
=8/bp
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
