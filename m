Return-Path: virtio-dev-return-6528-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBA49985EFE
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Dec 2019 10:46:04 +0000 (UTC)
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
 <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <3cb7b655-857c-d787-57fa-befd35a3fc46@opensynergy.com>
Date: Wed, 18 Dec 2019 11:45:54 +0100
MIME-Version: 1.0
In-Reply-To: <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 17.12.2019 15:45, Gerd Hoffmann wrote:
>    Hi,
>=20
>> +\subsection{Feature bits}\label{sec:Device Types / Sound Device / Featu=
re bits}
>> +
>> +None currently defined.
>=20
> Flags for hostmem & guestmem here?
>=20
> This could be an information the driver might want to know before
> initializing the virtqueues.

Yes, it might be. Yet this means that there will be two sets of features. A=
nd
current draft makes things more consistent (or at least looks so). Like, th=
e
choice of transport looks more natural (just usual "feature negotiation").


>> +\item START
>> +\item PAUSE
>> +\item UNPAUSE
>> +\item STOP
>=20
> Why pause/unpause?
>=20
> I don't see a reason compelling for this given the driver can restart a
> stream (i.e. set-params -> prepare -> start -> stop -> start -> stop ->
> release).  Would a device handle stop and pause in a different way?

Well, usually restarting a paused stream means a lower start delay. But you
have a point here. I think it's worth asking other people's opinions on thi=
s.


>> +/* supported PCM stream features */
>> +enum {
>> +    VIRTIO_SND_PCM_F_HOST_MEM =3D 0,
>> +    VIRTIO_SND_PCM_F_GUEST_MEM,
>=20
> Is this useful as stream property?  I would expect when supported by a
> device it would work for all streams.

Since we allowed different capabilities for different streams, now it's
possible to have different backends for them. I=E2=80=99m not sure how much=
 this can
be a real scenario, but it is theoretically possible to have one backend th=
at
is able to work with shared memory, and the other is not. The same can be s=
aid
for other stream feature bits.


>> +    VIRTIO_SND_PCM_F_EVT_PERIOD,
>=20
> I think this is only useful for hostmem/guestmem.

Using message-based transport, an application can send the entire playback=
=20
buffer at the beginning, and then send period-sized parts on each period=20
notification.


>> +struct virtio_snd_pcm_set_params {
>> +    struct virtio_snd_pcm_hdr hdr; /* .code =3D VIRTIO_SND_R_PCM_SET_PA=
RAMS */
>> +    u8 features;
>> +    u8 channels;
>> +    u8 format;
>> +    u8 rate;
>> +    le32 buffer_bytes;
>> +    le32 period_bytes;
>> +};
>> +\end{lstlisting}
>> +
>> +The request contains the following fields:
>> +
>> +\begin{description}
>> +\item[\field{features}] (device-readable) is a selected feature bit map=
:
>> +\begin{itemize*}
>> +\item VIRTIO_SND_PCM_F_HOST_MEM: use shared memory allocated by the hos=
t (TBD),
>> +\item VIRTIO_SND_PCM_F_GUEST_MEM: use shared memory allocated by the gu=
est (TBD),
>=20
> I'd suggest to drop those bits here.  For hostmem + guestmem we probably
> need a virtio_snd_pcm_set_params_{hostmem,guestmem} struct (and command)
> with additional parameters anyway.

See comment at the beginning.


>> +\subsubsection{PCM I/O Messages}\label{sec:Device Types / Sound Device =
/ Device Operation / PCM IO Messages}
>> +
>> +An I/O message consists of the header part, followed by the buffer, and=
 then
>> +the status part.
>=20
> Each buffer MUST (or SHOULD?) be period_bytes in size.
>=20
> The driver SHOULD queue (buffer_bytes / period_bytes) virtio buffers, so
> the device has buffer_bytes total buffer space available.

I think, it's better not to set queued buffer size restrictions. Periods ar=
e
an optional feature. If the driver is not interested in period notification=
s,
it's unclear what period_bytes means here.

Although, for the input stream we could say, that the total size of buffers=
 in
the rx queue should be buffer_bytes.


> cheers,
>    Gerd
>=20
>=20

--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

