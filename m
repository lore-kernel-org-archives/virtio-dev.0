Return-Path: virtio-dev-return-6448-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B82E3985EE1
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Dec 2019 09:00:45 +0000 (UTC)
Date: Tue, 3 Dec 2019 10:00:38 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191203090038.2bwfz4br7g4gvnaf@sirius.home.kraxel.org>
References: <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
 <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
 <770a5ce0-ba97-df47-5d65-67404b7e1bf6@opensynergy.com>
 <20191125093110.vixnxeasmpdfbcxs@sirius.home.kraxel.org>
 <b96600a6-1161-dbaf-c74c-c1bf8331de00@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <b96600a6-1161-dbaf-c74c-c1bf8331de00@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 02, 2019 at 02:06:53PM +0100, Anton Yakovlev wrote:
> Hi,
>=20
> Sorry for the late reply, I was not available for a week.
>=20
>=20
> On 25.11.2019 10:31, Gerd Hoffmann wrote:
> >    Hi,
> >=20
> > > > Instead of PCM_OUTPUT and PCM_INPUT I would put the number of input=
 and
> > > > output streams into the device config space (and explicitly allow c=
ount
> > > > being zero).
> > >=20
> > > There are several options for the number of streams:
> > >=20
> > > 1. The device can provide one input and/or output stream.
> > > 2. The device can provide several input and/or output streams, and al=
l of them
> > > share the same capabilities.
> > > 3. The device can provide several input and/or output streams, and th=
ey can
> > > have different set of capabilities.
> > >=20
> > > Overall design depends on chosen option. Current draft is based on p.=
1. But we
> > > have never discussed what is the best solution here.
> >=20
> > (3) looks most useful to me.
>=20
> Then we need to refactor device configuration. I would propose to put int=
o
> configuration space only a total number of all available PCM streams and
> introduce special control request to query per-stream configuration. A
> response should contain a stream type (input/output) and all its capabili=
ties.

Yes, that will fine work too.

> > > > PCM_MSG -- I would drop the feature bit and make that mandatory, so=
 we
> > > > have a common baseline on which all drivers and devices can agree o=
n.
> > >=20
> > > Then we need to inform device what "transport" will be in use (I assu=
med it
> > > would be feature negotiation).
> >=20
> > Whenever other transports (i.e. via shared memory) are supported: yes,
> > that should be a feature bit.
> >=20
> > Not sure about choosing the transport.  If both msg (i.e. via virtqueue=
)
> > and shared memory are available, does it make sense to allow the driver
> > choose the transport each time it starts a stream?
>=20
> Shared memory based transport in any case will require some additional
> actions. For HOST_MEM case the driver will need to get an access to host
> buffer somehow. In GUEST_MEM case the driver will need to provide a buffe=
r for
> the host.
>=20
> At first sight, we could extend the set_params request with the
> transport_type field and some additional information.

Or have a per-transport set_params request command.

> For example, in case
> of GUEST_MEM the request could be followed by a buffer sg-list.

I'm not convinced guest_mem is that useful.  host_mem allows to give the
guest access to the buffers used by the hosts sound hardware, which is
probably what you need if the MSG transport can't handle the latency
requirements you have.

> > > > > struct virtio_snd_pcm_status {
> > > > >       le32 status;
> > > > >       le32 actual_length;
> > > > > };
> > > >=20
> > > > Hmm.  Why actual_length?  Do we want allow short transfers?  Why?
> > > > Wouldn't it be more useful to just fill the buffer completely?
> > >=20
> > > In current design we have no buffer size requirements. It means, that=
 in
> > > theory the device and the driver could have buffers with different si=
zes.
> >=20
> > Should we define that the (virtio) buffer size must be period_bytes the=
n?
>=20
> It will have no sense, since the driver chooses period_bytes at runtime.

Yep, the driver will choose period_bytes when starting a stream.
The driver will also queue the buffers (for the MSG transport),
so it should be no problem for the driver to make the two match.

> If we gonna introduce any buffer constrains, it must be set by the
> device in a stream configuration.

If we want allow the device specify min/max period_bytes which it can
handle, then yes, that should go into the stream configuration.

Or we use negotiation: driver asks for period_bytes in set-params, the
driver picks the closest period_bytes value it can handle and returns
that.

> > > Also, the capture stream is a special case. Now we don't state explic=
itly
> > > whether read request is blockable or not.
> >=20
> > The concept of "blockable" doesn't exist at that level.  The driver
> > submits buffers to the device, the device fills them and notifies the
> > driver when the buffer is full.  It simply doesn't work like a read(2)
> > syscall.
>=20
> But you described exactly "blockable" case: an I/O request is completed n=
ot
> immediately but upon some condition (the buffer is full). In case of mess=
age-
> based transport, both the device and the driver will have its own buffers=
.

Well, no.  The device doesn't need any buffers, it can use the buffers
submitted by the driver.  Typical workflow:

  (1) The driver puts a bunch of empty buffers into the rx (record/read)
      virtqueue (each being period_bytes in size).
  (2) The driver starts recording.
  (3) The device fills the first buffer with recorded sound data.
  (4) When the buffer is full the device returns it to the driver,
      takes the next from the virtqueue to continue recording.
  (5) The driver takes the filled buffer and does whatever it wants do
      with the data (typically pass on to the userspace app).
  (6) The driver submits a new empty buffer to the virtqueue to make
      sure the device doesn't run out of buffers.

So, it's not a "here is a buffer, fill it please", "here is the next,
..." ping pong game between driver and device.  There is a queue with
multiple buffers instead, and the device fills them one by one.

Note: The device implementation can have additional buffering of course.
When using alsa the library records to its own private buffers, then
goes copy the data to the buffer provided by the application when you
call snd_pcm_readi().  But it is not required.  The device
implementation could also pass on the empty guest buffers directly to
the host sound hardware (if host hardware and host api allow that).

> And
> for capturing these buffers might be filled at different speed. For examp=
le,
> in order to improve latency, the device could complete requests immediate=
ly
> and fill in buffers with whatever it has at the moment.

Latency obviously depends on period_bytes.  If the driver cares about
latency it should simply work with lots of small buffers instead of a
few big ones.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

