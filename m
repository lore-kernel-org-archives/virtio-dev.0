Return-Path: <virtio-dev-return-12528-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F5BC77B78
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:08:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5E2E911B668
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:08:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DE5F9866B5
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 20:08:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 41C099865A1; Wed,  3 May 2023 20:08:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B96C9865F0
	for <virtio-dev@lists.oasis-open.org>; Wed,  3 May 2023 20:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BhRNaDxgPcyWPNS4z77GgQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683144516; x=1685736516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI6YTHhd1bKfQaeoxTn2WqG+7vEDnQuA46epoKfOmQk=;
        b=aRrxBcLzmj39LEsmJ0vQo7XDm+GKGztrUq6a1P8nVbwlhQ38i3f9zk9DbSYPhU3Bzo
         q5rBM1fJn6xAzQIXzHHgJMEDQ3TC1iMgH0FcpgdaZUQVaLXohZnMWpLS7NSknD4k0ui1
         9r1fPldZxGAYQnpQpfoXYHhaL5OGo8FfS3JXJCNhhSwoK/+qBElt3gMm79GwpqxdxM3Z
         o7uo739x3eZptVQXTjGxQnaGSygEl+YT1jwbYcba93lPV8PIQFIDJmyxIW1Ez2FDhVsf
         /jgBfL/YQpBQyhqKr7NHKhYovjrgaOmljmYqHWD8x9Se3VFcVJOy3rgjvchS6z+y5a0L
         /4qw==
X-Gm-Message-State: AC+VfDx7X7n4/IGv2gV9D5zbLLHbA6558VaPUq1asHxML/kl1jDe8Yum
	XuQbXwJ4Ppe5yHsG60EfCStXGtBoqU4ycJV3smhBVf5CU0H+blJtXf8M2exNqBxnRMNZcdxm6ME
	9IJjUx8OuOy9ve6PTGsMweb1x0d1D
X-Received: by 2002:a05:600c:22d0:b0:3f1:7a57:45cd with SMTP id 16-20020a05600c22d000b003f17a5745cdmr15134622wmg.28.1683144516205;
        Wed, 03 May 2023 13:08:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ534WFTc3xdO9nDVdoGzsDXw32SaAdZ4e3Gy6R0odIXYjidzcIVmJVYny9u26IZpiqsDtRtng==
X-Received: by 2002:a05:600c:22d0:b0:3f1:7a57:45cd with SMTP id 16-20020a05600c22d000b003f17a5745cdmr15134613wmg.28.1683144515895;
        Wed, 03 May 2023 13:08:35 -0700 (PDT)
Date: Wed, 3 May 2023 16:08:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230503160748-mutt-send-email-mst@kernel.org>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503151908-mutt-send-email-mst@kernel.org>
 <8c9edc69-933a-9202-4495-ef60e2f93c5a@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <8c9edc69-933a-9202-4495-ef60e2f93c5a@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy
 registers access commands

On Wed, May 03, 2023 at 03:38:31PM -0400, Parav Pandit wrote:
> 
> 
> On 5/3/2023 3:21 PM, Michael S. Tsirkin wrote:
> > On Wed, May 03, 2023 at 06:26:58AM +0300, Parav Pandit wrote:
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_lreg_wr_data {
> > > +	u8 offset; /* Starting byte offset of the register(s) to write */
> > > +	u8 size; /* Number of bytes to write into the register. */
> > > +	u8 register[];
> > > +};
> > 
> > BTW if we don't have padding we could reuse buffer size and won't need
> > size here.
> Yes. sounds good.
> 
> > Do we want to tweak admin command structure generally to use
> > u8 and not le64 for command data then? WDYT?
> > 
> yeah, cmd and result be u8 is fine.
> If padding is needed for perf, may be that command can define the padding.

The commands that I defined do need u64 (much easier to
work on bitmaps in fixed size chunks), so they will use that.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

