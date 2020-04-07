Return-Path: virtio-dev-return-7014-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C05B985E77
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Apr 2020 09:21:31 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Tue, 7 Apr 2020 11:21:04 +0200
Message-ID: <5576106.alqRGMn8q6@os-lin-dmo>
In-Reply-To: <CAD90VcYDU+8L4u-CuRY8ZaRyzYD_w0qwV1AN=8TbFYCbfUGz3w@mail.gmail.com>
References: <20200206102058.247258-1-keiichiw@chromium.org> <CAPBb6MVhVL-2EAJZ3UiN8BwjTyUXVirjF0gnfBBZjuvx07ijKA@mail.gmail.com> <CAD90VcYDU+8L4u-CuRY8ZaRyzYD_w0qwV1AN=8TbFYCbfUGz3w@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: Alexandre Courbot <acourbot@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico
 Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans
 Verkuil <hverkuil@xs4all.nl>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Alexandre, Keiichi,

Thanks for the updates,

On Montag, 6. April 2020 13:46:33 CEST Keiichi Watanabe wrote:
> 
> It seems that you're suggesting a big struct where bitstream params,
> image params and all controls are merged into, right?
> After rethinking, it makes sense to me.
> Originally, we had two motivations to have input params and output
> params separately:
> (1) We could reuse virtio_video_params for both queues.
> (2) We have considered extending virtio-video for video capture like V4L2.
> However, (1) doesn't seem to be a good idea as per the recent discussion.
> Regarding (2), the virtio-video design shouldn't be affected by other
> possible use cases. They should be discussed after we finalize
> virtio-video design.
> Hence, I guess we have no reason to stick to separate params into two.
> I'm supportive of this idea now.
> Also, having only one struct would simplify updating parameters.
> 
> > struct codec_params {
> > 
> >     u32 frame_width;
> >     u32 frame_height;
> >     /* H264, VP8, VP9, etc */
> >     enum virtio_codec format;
> >     union {
> >     
> >         struct {
> >         
> >             enum h264_profile profile;
> >             enum h264_level level;
> >         
> >         } h264;
> >         struct {
> >         
> >             enum vp8_profile profile;
> >         
> >         } vp8;
> >         ....
> >     
> >     };
> >     u32 bitrate;
> >     ....
> > 
> > };
> 
> More specifically, this struct would be:
> 
> // the word "codec" might not be needed in the struct name.
> struct virtio_video_codec_params {
>     // Image format
>     enum virtio_video_frame_format frame_format;
>     le32 frame_width;
>     le32 frame_height;
>     le32 min_frame_buffers;
>     le32 max_frame_buffers;
>     le32 cur_frame_buffers; // It's needed for REQBUFS's "count"
>     struct virtio_video_crop crop;
>     le32 frame_rate;
>     le32 num_planes;
>     struct virtio_video_plane_format \
>         plane_formats[VIRTIO_VIDEO_MAX_PLANES];
> 
>     // Bitstream format
>     enum virtio_video_coded_format coded_format;
>     le32 min_coded_buffers;
>     le32 max_coded_buffers;
>     le32 cur_coded_buffers;
>     le32 bitrate;
>     union {
>         struct {
>           enum h264_profile profile;
>           enum h264_level level;
>         } h264;
>         struct {
>           enum vp8_profile profile;
>         } vp8;
>         ...
>     } codec;
> }
> 

I would strongly disagree with this approach as it kills the flexibility and 
any possibility of having a uni-directional stream for seemingly no reason.

I could be useful if it was possible to store the structure in the config 
space, but that won't fly as we have multiple streams with different settings. 
Also one device can support multiple formats, so we won't be able to handle 
the unions.

> > The idea being that depending on the value of "format", only the
> > relevant member of the union becomes meaningful. This ensures that the
> > device/driver does not need to check for every control whether it is
> > valid in the current context ; it just needs to check what "format" is
> > and take the values from the relevant members.
> 
> I like this idea to use union to make it more structured.
> 

I don't really have any strong objections agains unions per se, but I deem we 
need to keep the structure flexible. At the very beginning of the development 
there was a discussion about stream priority. If I add a 'prio' field to this 
structure it will break the binary compatibility with older versions.

> > I don't think we even need to have a different queue for both structs
> > (which is what V4L2 does, but again for its own reasons). Just a
> > single one per coding or decoding context could be enough AFAICT.
> > 
> > Depending on whether we are decoding or encoding, access to some
> > members would be restricted to read/only for the device or driver. For
> > instance, when encoding the driver can set "bitrate" to the desired
> > encoding rate. When decoding, the decoder can report the video's
> > bitrate there.
> > 
> > Now I'm not sure what would be the best way to share this structure.
> > Either a memory area shared between the driver and device, with
> > commands/messages sent to notify that something has changed, or
> > sending the whole structure with each command/message.
> 
> I don't think the first idea is feasible in the virtio mechanism. So,
> we can utilize the same way as the previous proposal; SET_PARAMS and
> GET_PARAMS.
> 

For similar thing the virtio config space exists, but as I mentioned above, it 
won't fit the current virtio-video design (or we probably can pre-define the max 
number of streams on the device side and have params for each stream in the 
config space, but this looks clumsy).

> We also need to think of how to advertise supported profiles and
> levels. Probably, we might want to extend struct
> virtio_video_format_desc to include supported profiles/levels in a
> response of QUERY_CAPABLITY.
> 

It would mean back to spec v1 AFAIR. We probably need to recall why we got rid 
of that.

> > Now the parameters I have listed above are not subject to changing a
> > lot, but there are also parameters that we may want to specify/be
> > notified on with each frame. For instance, whether we want a frame to
> > be forcibly encoded as a keyframe. V4L2 uses a control for this, but
> > we could probably do better if we can pass this information with each
> > frame to be encoded. Maybe we can implement that by using different
> > QUEUE commands for encoder and decoder, or again by using a union.
> 
> Ah, I haven't come up with such a kind of parameter. Perhaps, we can
> extend struct virtio_video_resource_queue to have this flag.
> 

This looks sane for me.

Best regards,
Dmitry.




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

