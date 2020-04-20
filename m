Return-Path: virtio-dev-return-7130-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40C1A985359
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Apr 2020 09:58:07 +0000 (UTC)
MIME-Version: 1.0
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <5576106.alqRGMn8q6@os-lin-dmo> <CAD90Vcb7UwWAqHOKb7rUV6q3TCSCCEpbbkv6oK0PnEL246TgJQ@mail.gmail.com>
 <3536507.QJadu78ljV@os-lin-dmo>
In-Reply-To: <3536507.QJadu78ljV@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 20 Apr 2020 18:57:52 +0900
Message-ID: <CAD90VcbgrcMEiYSGZo66qZS8uBznLim3nVPnsmbekstB3Brktg@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Alexandre Courbot <acourbot@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dmitry,

On Fri, Apr 17, 2020 at 5:09 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> w=
rote:
>
> Hi,
>
> On Donnerstag, 9. April 2020 12:46:27 CEST Keiichi Watanabe wrote:
> > Currently, we have three options of the design of per-stream properties=
:
> >
> > 1. Have two structs for image format and bitstream format.
> > Pros:
> > Well structured. Easy to support uni-directional stream.
> > Cons:
> > Not all properties may not be classified well. For example, bitrate in
> > encoder is about "how we encode it" rather than "what we encode it
> > into". So, it may be a bit strange to have it in the bitstream
> > information.
> >
> > 2. Have one struct that contains all properties.
> > Pros:
> > Well structured. Since updating one format affects the other format,
> > it may make more sense to have everything in one struct.
> > Also, we can have any per-stream properties there that may be tied to
> > neither image format nor bitstream format.
> > Cons:
> > If we want to support uni-directional streams in the virtio-video
> > protocol, we may be going to have many unused fields in that struct.
> >
> > 3. Have every property as a separate subcommand like v3's controls
> > Pros:
> > Easy to add more properties in the future.
> > Cons:
> > Less structured. So, we need to be careful not to overlook mandatory
> > properties when we implement the driver and device.
> >
> >
> > IMHO, I'm relatively supportive of 2, but we might need to rethink
> > whether we really want to support uni-directional streams in
> > virtio-video.
>
> Ok, let's assume we keep it is one struct. Anyway, we indeed can just ign=
ore
> some of the fields if we want so. We need to define some conventions for =
the
> struct. Like whether we should fill all the fields all the time when send=
ing
> set_params() and so on.

Right. We need to define whether each field in params is (i) either
mandatory, (2) applicable for encoder and decoder and (3) the driver
can modify it.

>
> I want to ask you about the frame-level bitrate control here [1]. Is it
> planned to support it? If yes, we also need a control to enable that and =
a way
> to pass minimum and maximum value for the quantization parameter.

I have no plan to support this kind of controls as I explained at
https://markmail.org/message/orbtthzxcg3qyzxo.

Even if we want to support max of bitrates doesn't make much sense
because a user can specify any big value as bitrate and encoder will
do its best to make better bitstream in the specified bitrate.
I think this is the reason why we didn't have a QUERY_CONTROL value
for bitrates in v3 spec.

>
> > I guess it's worthwhile to create a separate protocol like
> > virtio-camera even if it somehow overlaps with virtio-video.
> > Only for a simple video capture scenario, extending the virtio-video
> > protocol can be one of simple solutions. However, if we want to extend
> > it for more features like MIPI cameras, it's not hard to imagine the
> > protocol becoming very complicated.
> > I wonder if we can keep virtio protocols simple and clean rather than
> > making an all-in-one protocol for media devices like V4L2.
> >
> > > I could be useful if it was possible to store the structure in the co=
nfig
> > > space, but that won't fly as we have multiple streams with different
> > > settings. Also one device can support multiple formats, so we won't b=
e
> > > able to handle the unions.
> >
> > Yeah, this structure should be per-stream properties but virtio's
> > config is for per-device properties.
> > So, it doesn't work as you said.
> >
> > > > > The idea being that depending on the value of "format", only the
> > > > > relevant member of the union becomes meaningful. This ensures tha=
t the
> > > > > device/driver does not need to check for every control whether it=
 is
> > > > > valid in the current context ; it just needs to check what "forma=
t" is
> > > > > and take the values from the relevant members.
> > > >
> > > > I like this idea to use union to make it more structured.
> > >
> > > I don't really have any strong objections agains unions per se, but I=
 deem
> > > we need to keep the structure flexible. At the very beginning of the
> > > development there was a discussion about stream priority. If I add a
> > > 'prio' field to this structure it will break the binary compatibility
> > > with older versions.
> > Hmm, I don't think unions can incur any extra binary compatibility
> > issues compared with designs using only structs.
> > Since alignment rules are well-defined for unions as well as structs,
> > it'd be okay.
> > We might want to have an explicit field to show the size of a union lik=
e:
> >
> > union {
> >   struct {
> >     ...
> >   } h264;
> >   struct {
> >     ...
> >   } vp8;
> >   ...
> >   u8 _align[MAX_SIZE_OF_FIELDS_IN_THIS_UNION];
> > }
> >
> > > > > I don't think we even need to have a different queue for both str=
ucts
> > > > > (which is what V4L2 does, but again for its own reasons). Just a
> > > > > single one per coding or decoding context could be enough AFAICT.
> > > > >
> > > > > Depending on whether we are decoding or encoding, access to some
> > > > > members would be restricted to read/only for the device or driver=
. For
> > > > > instance, when encoding the driver can set "bitrate" to the desir=
ed
> > > > > encoding rate. When decoding, the decoder can report the video's
> > > > > bitrate there.
> > > > >
> > > > > Now I'm not sure what would be the best way to share this structu=
re.
> > > > > Either a memory area shared between the driver and device, with
> > > > > commands/messages sent to notify that something has changed, or
> > > > > sending the whole structure with each command/message.
> > > >
> > > > I don't think the first idea is feasible in the virtio mechanism. S=
o,
> > > > we can utilize the same way as the previous proposal; SET_PARAMS an=
d
> > > > GET_PARAMS.
> > >
> > > For similar thing the virtio config space exists, but as I mentioned
> > > above, it won't fit the current virtio-video design (or we probably c=
an
> > > pre-define the max number of streams on the device side and have para=
ms
> > > for each stream in the config space, but this looks clumsy).
> > >
> > > > We also need to think of how to advertise supported profiles and
> > > > levels. Probably, we might want to extend struct
> > > > virtio_video_format_desc to include supported profiles/levels in a
> > > > response of QUERY_CAPABLITY.
> > >
> > > It would mean back to spec v1 AFAIR. We probably need to recall why w=
e got
> > > rid of that.
> >
> > Probably, this reply:
> > https://markmail.org/thread/zr3ycvxixnwi5agt
> > At that time, I assumed that we'll have profiles/levels/bitrates as
> > controls, aparting from other per-stream properties. In that
> > situation, it made sense to have a separate mechanism to get/set/query
> > these properties.
> > However, we are likely not to end up distinguishing these properties
> > from other properties. If so, we don't need any other querying
> > mechanism other than QUERY_CAPABILITY.
> >
> > To support profiles, we can extend virtio_video_format_desc to
> > (a) add fields like "profiles" and "levels" that shows supported
> > values as bit mask, or
> > (b) add fields like "num_profiles" and "num_levels" that describes the
> > lengths of arrays that follows.
> >
> > My personal preference is (a).
> >
>
> Yes, this should be ok. We had arrays in the spec v1, but as we have now
> bitmasks for formats, we can do so for profiles and levels.
>
> We currently have two problems with capabilities when it comes to the rea=
l
> implementation:
>
> 1. If we want to avoid calling stream_create in open(), we need to have
> bitrates already on per-format basis in capabilities.
> 2. We also need to know min input and output buffer count in advance, i.e=
. it
> should not be in params, especially for encoder that won't report it afte=
r
> metadata parsing like decoder, please see [2] (thanks Nicolas Dufresne fo=
r
> helping with that issue).

I think these problems wouldn't be problems if we distinguish "guest
driver's internal session" and "virtio-video stream'.
The open() is an operation to create a guest driver's internal
session, not virtio-video stream.
Specifically, in your driver patch, we can define a struct like the
following example for the driver's internal context.

// Represents an internal state of a driver session.
struct virtio_video_context {
  enum virtio_video_context_state;
  struct video-_device *video_dev;
  struct v4l2_fh fh;
  ...

  // The following pointers are NULL at the initialization.
  virtio_video_stream *stream;
  virtio_video_params *params;
};

This struct will be allocated in open(), as it represents a driver's
internal state.
Its fields associated with a virtio-video stream will be initialized
at the time when it's really needed via an accessor function like
this:

// Gets virtio-video stream information from a context.
// If a given context is associated to no virtio-video stream,
// it creates one by the STREAM_CREATE command.
virtio_video_stream* ctx2stream(struct virtio_video_context *ctx)
{
  if (!ctx->stream)
    ctx->stream =3D virtio_video_cmd_stream_create(...);

  return ctx->stream;
}

In this implementation, we can delay creation of a virtio-video stream
until it's actually needed without considering where it is.


Regarding the second problem you mentioned, I think the min/max number
of buffers _should_ be in params because they're per-stream parameters
and can be changed at the middle of a stream because of resolution
changes, for example.

Best regards,
Keiichi

>
> [1] https://github.com/chromium/chromium/blob/master/media/gpu/v4l2/
> v4l2_video_encode_accelerator.cc#L1579
> [2] https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/-/issues/67=
2
>
> Best regards,
> Dmitry.
>
> > Best regards,
> > Keiichi
> >
> > > > > Now the parameters I have listed above are not subject to changin=
g a
> > > > > lot, but there are also parameters that we may want to specify/be
> > > > > notified on with each frame. For instance, whether we want a fram=
e to
> > > > > be forcibly encoded as a keyframe. V4L2 uses a control for this, =
but
> > > > > we could probably do better if we can pass this information with =
each
> > > > > frame to be encoded. Maybe we can implement that by using differe=
nt
> > > > > QUEUE commands for encoder and decoder, or again by using a union=
.
> > > >
> > > > Ah, I haven't come up with such a kind of parameter. Perhaps, we ca=
n
> > > > extend struct virtio_video_resource_queue to have this flag.
> > >
> > > This looks sane for me.
> > >
> > > Best regards,
> > > Dmitry.
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

