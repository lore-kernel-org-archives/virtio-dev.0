Return-Path: <virtio-dev-return-12317-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713A7C6FD18
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:15:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CACAE44348
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:15:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B203298643A
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 16:15:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9DC11986432; Wed, 19 Apr 2023 16:15:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CE37986434
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Apr 2023 16:15:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yNK3MxpZMN-mm49FbLMI5Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920923; x=1684512923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gi0jCiUg+NgVxkDL2+pVJFtd19mgx0wxCt1ImZTqHyU=;
        b=Yn8Bsjap5/CVuPHlfi2x1rk/VkbHd9BTObC4IXM49osnimB6WXKNj5yQ6+rqX9UEWM
         SMh9TwZmuJ8/WnLEPod+Us6zFz1eQ8IfQ29G8+58Z1ejllN1RQGtNo5bA3P87qOB67B7
         hq86s7uR4O20fOo5wzMnz3hqt9gdecZ22FZ1FUqde5fcl3BnBq5tEGTHbeayh2lfOkNr
         3yee2JyB96PVlhpUaBr6WjsZlz9Im0OstTf7CrTR5FlRQydtzaEMhF6FhuASYR43R+xE
         eYntKL59HTMJgKwh/wQ2Cf/EiYU6RgIWYpUtecaHkUeSZ2lH1ld5oicUxcdRVy/P8d8y
         iZPQ==
X-Gm-Message-State: AAQBX9f0eyWPBNgi8lFOKjb89BKTkyG4TnJeaauuYctppa7+E7KE0OYV
	QhpeYgsfTxb3vFn2A5XX2mm1wKvLslFEC2col/4it8CI+2CyW50BYF3wPBhcv/qtaHnRlvCNwmD
	4q+OfMfK8KWI9bsxLpSooh91wAWdc
X-Received: by 2002:a1c:7509:0:b0:3f0:7f4f:2aa8 with SMTP id o9-20020a1c7509000000b003f07f4f2aa8mr16910239wmc.9.1681920922805;
        Wed, 19 Apr 2023 09:15:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350aPYAhWI/JGeRpA9RSEkqJXfH16Rx9PCPMiJdFOUSxqg+BNRBd7geRxM8DriXY5rlswMSoVnw==
X-Received: by 2002:a1c:7509:0:b0:3f0:7f4f:2aa8 with SMTP id o9-20020a1c7509000000b003f07f4f2aa8mr16910225wmc.9.1681920922499;
        Wed, 19 Apr 2023 09:15:22 -0700 (PDT)
Date: Wed, 19 Apr 2023 12:15:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230419121514-mutt-send-email-mst@kernel.org>
References: <20230411200358.753101-1-parav@nvidia.com>
 <87bkjkngj6.fsf@redhat.com>
 <PH0PR12MB5481908F52883B1C3BE31A15DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481908F52883B1C3BE31A15DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] device-types/multiple: replace queues with enqueues

On Wed, Apr 19, 2023 at 01:35:32PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Wednesday, April 19, 2023 9:33 AM
> > 
> > On Tue, Apr 11 2023, Parav Pandit <parav@nvidia.com> wrote:
> > 
> > > Queue is a verb and noun both. Replacing it with enqueue avoids
> > > ambiguity around plural queues noun vs verb; similar to virtio fs
> > > device description.
> > 
> > Personally, I don't think this patch adds much, but I don't really mind it, either.
> > 
> > >
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  device-types/blk/description.tex   | 2 +-
> > >  device-types/gpio/description.tex  | 4 ++--
> > >  device-types/i2c/description.tex   | 2 +-
> > >  device-types/scsi/description.tex  | 2 +-
> > > device-types/vsock/description.tex | 2 +-
> > >  5 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > 
> > (...)
> > 
> > > diff --git a/device-types/vsock/description.tex
> > > b/device-types/vsock/description.tex
> > > index 105bb30..07909d6 100644
> > > --- a/device-types/vsock/description.tex
> > > +++ b/device-types/vsock/description.tex
> > > @@ -218,7 +218,7 @@ \subsubsection{Buffer Space
> > > Management}\label{sec:Device Types / Socket Device /  \field{buf_alloc} and
> > \field{fwd_cnt} fields.
> > >
> > >  \subsubsection{Receive and Transmit}\label{sec:Device Types / Socket
> > > Device / Device Operation / Receive and Transmit} -The driver queues
> > > outgoing packets on the tx virtqueue and incoming packet
> > > +The driver enqueues outgoing packets on the tx virtqueue and incoming
> > > +packet
> > 
> > "queues (...) on" reads natural to me, but I'd use "to" with "enqueues"... 
> Yes, I agree.
> The driver enqueues outgoing packets to the tx virtqueue reads better to me.

+1

> > can any
> > native speakers comment?
> > 
> > >  receive buffers on the rx virtqueue. Packets are of the following form:
> > >
> > >  \begin{lstlisting}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

