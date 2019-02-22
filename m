Return-Path: virtio-dev-return-5514-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C99A98610A
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 22:05:33 +0000 (UTC)
Date: Fri, 22 Feb 2019 17:05:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190222163900-mutt-send-email-mst@kernel.org>
References: <20190212164626.GG2715@work-vm>
 <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <CAEkmjvVu0r9cpFPNv8xSityiZ1hZLBPy0uyN1Jp_i1CAnu+zJA@mail.gmail.com>
 <20190212135924-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzwfNW4QL8E52=AEXvN_RoeEoOHCODaefsa4wSLOMmZg@mail.gmail.com>
 <20190212221738-mutt-send-email-mst@kernel.org>
 <20190212231458-mutt-send-email-mst@kernel.org>
 <CAEkmjvVD7E_DcBkoucNSYs74T10K2qrJHAYbzCqUF=7C+B-4GQ@mail.gmail.com>
 <CAEkmjvVON9+h_S90LDmaobKq4CG=VZz2HarVcRFP04oFK=H2cw@mail.gmail.com>
 <CAEkmjvU8vAXcH4SmMsbD_suU82w6XzLXzDCJSDY-UT2Xq6+TAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEkmjvU8vAXcH4SmMsbD_suU82w6XzLXzDCJSDY-UT2Xq6+TAw@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 13, 2019 at 11:15:12PM -0800, Frank Yang wrote:
> Revised the spec to clean up a straggling mention of callbacks, and added=
 a
> concrete example of how it would be used for a video codec.
>=20
> Inlined here:

BTW I'd rather you started sending versioned RFC patches.
This thread's too large already.


> \subsection{Example Use Case}\label{sec:Device Types / Host Memory Device=
 /
> Example Use Case}
>=20
> Suppose the guest wants to decode a compressed video buffer.
>=20
> \begin{enumerate}
>=20
> \item Guest creates an instance for the codec vendor id / device id / rev=
ision.

OK we'll need to see how do we come up with a way to avoid conflicts
here, e.g. if multiple vendors will use this device.

> \item Guest allocates into the PCI region via config virtqueue messages.

OK so who allocates memory out of the PCI region?
Is it the host or the guest?
E.g. does guest say "I want X bytes" and host would respond
"here they are, start at offset X"?

> \item Guest sends a message over the ping virtqueue for the host to back =
that
> memory.

And all of these will need to be maintained on the host right?
How many of these regions need to be supported?

>=20
> \item Host codec device implementation exposes codec library's buffer dir=
ectly
> to guest.
>=20
> \item Guest: now that the memory is host backed, the guest mmap()'s and
> =A0 =A0 downloads the compressed video stream directly to the host buffer.
>=20
> \item Guest: After a packet of compressed video stream is downloaded to t=
he
> =A0 =A0 buffer, another message, like a doorbell, is sent on the ping vir=
tqueue to
> =A0 =A0 =A0 =A0 consume existing compressed data. The ping message's offs=
et field is
> =A0 =A0 =A0 =A0 set to the proper offset into the shared-mem object.

BTW is this terminology e.g. "download", "ping message" standard somewhere?

> \item Host: The ping message arrives on the host and the offset is resolv=
ed to
> =A0 =A0 a physical address and then, if possible, the physical address to=
 a host
> =A0 =A0 =A0 =A0 pointer. Since the memory is now backed, the host pointer=
 is also
> =A0 =A0 =A0 =A0 resolved.
>=20
> \item Host: Codec implementation decodes the video and puts the decoded f=
rames
> =A0 =A0 to either a host-side display library (thus with no further guest
> =A0 =A0 =A0 =A0 communication necessary), or puts the raw decompressed fr=
ame to a
> =A0 =A0 =A0 =A0 further offset in the host buffer that the guest knows ab=
out.
>=20
> \item Guest: Continue downloading video streams and hitting the doorbell,=
 or
> =A0 =A0 optionally, wait until the host is done first. If scheduling is n=
ot that
> =A0 =A0 =A0 =A0 big of an impact, this can be done without even any furth=
er VM exit, by
> =A0 =A0 =A0 =A0 the host writing to an agreed memory location when decodi=
ng is done,
> =A0 =A0 =A0 =A0 then the guest uses a polling sleep(N) where N is the cor=
rectly tuned
> =A0 =A0 =A0 =A0 timeout such that only a few poll spins are necessary.
>
>
> \item Guest: Or, the host can send back on the event virtqueue \field{rev=
ents}
> =A0 =A0 and the guest can perform a blocking read() for it.
>=20
> \end{enumerate}
>=20
> The unique / interesting aspects of virtio-hostmem are demonstrated:
>=20
> \begin{enumerate}
>=20
> \item During instance creation the host was allowed to reject the request=
 if
> =A0 =A0 the codec device did not exist on host.
>=20
> \item The host can expose a codec library buffer directly to the guest,
> allowing the guest to write into it with zero copy and the host to decomp=
ress
> again without copying.
>=20
> \item Large bidirectional transfers are possible with zero copy.

However just to make sure, sending small amounts of data
is slower since you get to do all the mmap dance.


> \item Large bidirectional transfers are possible without scatterlists, be=
cause
> =A0 =A0 the memory is always physically contiguous.

It might get fragmented though. I think it would be up to
host to try and make sure it's not too fragmented, right?


> \item It is not necessary to use socket datagrams or data streams to
> =A0 =A0 communicate the ping messages; they can be raw structs fresh off =
the
> =A0 =A0 =A0 =A0 virtqueue.

OK and ping messages are all fixed size?


> \item After decoding, the guest has the option but not the requirement to=
 wait
> =A0 =A0 for the host round trip, allowing for async operation of the code=
c.
>=20
> \item The guest has the option but not the requirement to wait for the ho=
st
> =A0 =A0 round trip, allowing for async operation of the codec.
>=20
> \end{enumerate}

OK I still owe you that write-up about vhost pci.  will try to complete
that early next week. But generally if I got it right that the host
allocates buffers then what you describe does seem to fit a bit better
with the vhost pci host/guest interface idea.

One question that was asked about vhost pci is whether it is in fact
necessary to share a device between multiple applications.
Or is it enough to just have one id per device?

Thanks!
--=20
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

