Return-Path: <virtio-dev-return-13641-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D63BEB8FB3
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 13:50:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7CBE6159D4C
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 13:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 41CDE9866DA
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 13:50:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DEE0E9865E3; Wed,  6 Sep 2023 13:50:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D17979865E0
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2023 13:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: TKFllOLJNzOSWBMB25l4UA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694008195; x=1694612995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00APrUkX7s01mqNtL1RlVQy0yrK13svYIndj4e4xSh8=;
        b=bDx5sHfs6rRhkO2yWb43AQshczd2STuonwffGs1m1ia7Nd3uZE17syg/jneaeVpEQ+
         RTbCnTwi6goRXT5kMhhxlbKKCBDARdmdyFYp4bWLxjpA0izzZTpmmw8W8ziVachfwGm8
         ZjYitUTPtIwM6sZMUudMv5YLsNieKsY71qw6AoSQAkU10b20xwiOUYeIbkYaevaBpJb5
         AOSLDOIj31gm4kjDvP/vQr2icCmrPGbUGWHDNDBXhV4I3bipyiB9Jm1NEDN8QO7dVVAB
         uYP89ZBYZo/2NPvrG2m95ylgJzNMq1DLtHOYx8v19jvKw4TYr9FBsEXZkHSHi7Bb0nhB
         ZTxw==
X-Gm-Message-State: AOJu0YxjRDX0WNG/u8Ug7Y9wYwg64kgW20qVMSISaEsPF5XNL37f+EVg
	yJAkYtP2tYREQWQVOCSnaXGQuiozGhg/akysDxDhLYV/dXkN1f5LgsORLsCXf1hwGpqa/ua8Oky
	4FtRIg6morudYywHNKuti+OriobRI
X-Received: by 2002:a17:906:5308:b0:9a1:f871:8a5f with SMTP id h8-20020a170906530800b009a1f8718a5fmr2384637ejo.32.1694008195398;
        Wed, 06 Sep 2023 06:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdz3f84MuTvye4mzwQ1pPIq/dxnpCcyHauT/jdkxjXjYjVTXA4toZUb4AfYQItesCGFy/9jw==
X-Received: by 2002:a17:906:5308:b0:9a1:f871:8a5f with SMTP id h8-20020a170906530800b009a1f8718a5fmr2384620ejo.32.1694008195023;
        Wed, 06 Sep 2023 06:49:55 -0700 (PDT)
Date: Wed, 6 Sep 2023 09:49:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230906094742-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906042851-mutt-send-email-mst@kernel.org>
 <aa6101cc-caf6-95e9-89cd-614ac7a43e55@intel.com>
MIME-Version: 1.0
In-Reply-To: <aa6101cc-caf6-95e9-89cd-614ac7a43e55@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 06, 2023 at 04:38:44PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/6/2023 4:29 PM, Michael S. Tsirkin wrote:
> > On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
> > > This series introduces
> > > 1)a new SUSPEND bit in the device status
> > > Which is used to suspend the device, so that the device states
> > > and virtqueue states are stabilized.
> > > 
> > > 2)virtqueue state and its accessor, to get and set last_avail_idx
> > > and last_used_idx of virtqueues.
> > > 
> > > The main usecase of these new facilities is Live Migration.
> > > 
> > > Future work: dirty page tracking and in-flight descriptors.
> > oh that answers my question - it's not covered.
> > I don't think we can merge this without in-flight descriptor
> > support.
> When SUSPEND, we require the device wait until all descriptors that
> being processed to finish and mark them as used.(In patch 2)
> at this point there may be no in-flight descriptors, so this is still
> self-consistent. The tracker for in-flight descriptors is excluded to
> make this series small and focus.

Does not work generally.
Imagine RX ring of a network device for example. You can wait
as long as you can but if there's no incoming network traffic
buffers will not be used.

Also please, keep to the spec terminology. buffers are used not
descriptors. Best to keep it straight errors will not leak into
spec.


> > 
> > 
> > 
> > > This series addresses many comments from Jason, Stefan and Eugenio
> > > from RFC series.
> > > 
> > > Zhu Lingshan (5):
> > >    virtio: introduce vq state as basic facility
> > >    virtio: introduce SUSPEND bit in device status
> > >    virtqueue: constraints for virtqueue state
> > >    virtqueue: ignore resetting vqs when SUSPEND
> > >    virtio-pci: implement VIRTIO_F_QUEUE_STATE
> > > 
> > >   content.tex       | 118 ++++++++++++++++++++++++++++++++++++++++++++++
> > >   transport-pci.tex |  18 +++++++
> > >   2 files changed, 136 insertions(+)
> > > 
> > > -- 
> > > 2.35.3
> > > 
> > > 
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > 
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > > 
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> > > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

