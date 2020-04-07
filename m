Return-Path: virtio-dev-return-7018-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CF1E985EBF
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Apr 2020 14:49:29 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Tue, 7 Apr 2020 16:49:02 +0200
Message-ID: <4320831.CvnuH1ECHv@os-lin-dmo>
In-Reply-To: <20200206102058.247258-2-keiichiw@chromium.org>
References: <20200206102058.247258-1-keiichiw@chromium.org> <20200206102058.247258-2-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>
Cc: linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

> +\item[VIRTIO_VIDEO_CMD_STREAM_DESTROY] Destroy a video stream
> +  (context) within the device.
> +
> +\begin{lstlisting}
> +struct virtio_video_stream_destroy {
> +        struct virtio_video_cmd_hdr hdr;
> +};
> +\end{lstlisting}

Let's add more strict description to stream_destroy, like as follows:
Device MUST NOT generate any events for the stream in question after receiving 
the command. Before completing the command, Device MUST ensure that all 
asynchronous commands that are related to the stream have been completed and 
all memory objects are unreferenced.

Best regards,
Dmitry.




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

