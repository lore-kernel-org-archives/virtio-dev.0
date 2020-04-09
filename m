Return-Path: virtio-dev-return-7035-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72F5C985F36
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Apr 2020 13:23:32 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Thu, 9 Apr 2020 15:13:46 +0200
Message-ID: <17068786.sWSEgdgrri@os-lin-dmo>
In-Reply-To: <CAD90Vca4jqLPdK4my3mCmPM45Lwc5te6PbDhA+H=0X1QyTFWzQ@mail.gmail.com>
References: <20200206102058.247258-1-keiichiw@chromium.org> <4320831.CvnuH1ECHv@os-lin-dmo> <CAD90Vca4jqLPdK4my3mCmPM45Lwc5te6PbDhA+H=0X1QyTFWzQ@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

On Donnerstag, 9. April 2020 12:46:56 CEST Keiichi Watanabe wrote:
> Hi,
> 
> On Tue, Apr 7, 2020 at 11:49 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> 
wrote:
> > Hi,
> > 
> > > +\item[VIRTIO_VIDEO_CMD_STREAM_DESTROY] Destroy a video stream
> > > +  (context) within the device.
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_video_stream_destroy {
> > > +        struct virtio_video_cmd_hdr hdr;
> > > +};
> > > +\end{lstlisting}
> > 
> > Let's add more strict description to stream_destroy, like as follows:
> > Device MUST NOT generate any events for the stream in question after
> > receiving the command. Before completing the command, Device MUST ensure
> > that all asynchronous commands that are related to the stream have been
> > completed and all memory objects are unreferenced.
> 
> Sounds good. But, the device should probably be able to generate
> VIRTIO_VIDEO_EVENT_ERROR for a device-wide error?
> Or, should VIRTIO_VIDEO_EVENT_ERROR always be a per-stream error? (I
> haven't documented it in v3)
> 

In the current version of the driver  I have we interpret it a stream error. I 
think it makes sense as several stream formats might be backed by different 
hardware devices on the host side. So it would be an overkill to mark the 
whole virtio device as broken on the guest side.

BTW, I think we should add some hard limit to the max_cap_length and 
max_resp_length in the spec, so buggy device does not make us allocate all 
memory for a response on the host side by providing a garbage value. I think 
4k might be a good value.

Best regards,
Dmitry.

> Best regards,
> Keiichi
> 
> > Best regards,
> > Dmitry.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

