Return-Path: <virtio-dev-return-11546-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163A1C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:25:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E3C92AEE2
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:25:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5DF719866F3
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 17:25:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4CE3A9866F0; Wed,  8 Mar 2023 17:25:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3CC819866F1
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Mar 2023 17:25:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bNGxsUlvNcOCotlgQv8lZQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMR1+cklR3Qh1TBpptTQ/ElZCO/VAT6ZrfM0l5AOoxY=;
        b=Pyeytse5s0/iDMUzcTrjiJC3gVzX5/+ONdmN6fi9U5mYToEklTLLArZQcPHV7AmVqe
         rMB8nK8922R1tysdwJ36VoZ3iVI6+GsxnAyvLEa92vQrUDzK4hdayJNX3qZZRsJR7V1B
         saCitQmlpuMMKxMaD7emXV36hAXi40RaMigwdXsyeWbF3H3NzccJLkLSD4ZyGNNgFsvW
         T9Ov5IikdIqu28NzRxn7CDXv6T+8G8X5728weiA8YIXOWPKKPsE8U10WWrsxaPMiSeSj
         2nXDhZXWxYrq1bqRouS0t1UccrYJhejEJLptVr67mQ0DSbHR2EeQxzLLLk9rc3P//igB
         xTCQ==
X-Gm-Message-State: AO0yUKXnnoJ4eEg1bINRRlVdXgBYnlqUjgjSrbHVgWNAzrjbIibKqP7L
	jwP+MzJRoNWdM9CqQnBdXz8poZZc2j25bWu6gJEcSm8SyMfFZ7qr4jB82Vpk9BsuRO8eunSfE03
	t1jxX0iEg1Od9OPVB4M8iIyPkV+vd
X-Received: by 2002:a17:906:7fc2:b0:8e4:dd4d:7b07 with SMTP id r2-20020a1709067fc200b008e4dd4d7b07mr18197853ejs.15.1678296304454;
        Wed, 08 Mar 2023 09:25:04 -0800 (PST)
X-Google-Smtp-Source: AK7set+Xf+dHR1d/ssoU5yHRjD5sDJA2wW3+PyvpsOF9wlvnbVrVYB9yPvcngMwPFNetB9/GMHyt/Q==
X-Received: by 2002:a17:906:7fc2:b0:8e4:dd4d:7b07 with SMTP id r2-20020a1709067fc200b008e4dd4d7b07mr18197834ejs.15.1678296304217;
        Wed, 08 Mar 2023 09:25:04 -0800 (PST)
Date: Wed, 8 Mar 2023 12:25:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Message-ID: <20230308122332-mutt-send-email-mst@kernel.org>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <m2lekf1iq8.fsf@oracle.com>
 <20230306175558-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A9D8A005A61139535CF7DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A9D8A005A61139535CF7DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation

On Wed, Mar 08, 2023 at 04:42:25PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, March 6, 2023 5:57 PM
> > 
> > On Thu, Mar 02, 2023 at 11:36:18AM +0000, David Edmondson wrote:
> > > > +                                        for an enabled transmit/receive virtqueue whose
> > number is \field{vqn}.
> > >
> > > Should this now be "whose index is \field{vqn}"?
> > 
> > Ugh.  I guess we'll have to fix the number/index mess in the spec first. Parav
> > you said you are looking into it?
> 
> Yes, I want to send v1 for " Rename queue index to queue number" series.
> V1 will include,
>  
> a. the vqn changes for net device rss and 
> b. other ccw changes that Cornelia requested.
> c. extra note that you asked to add to mmio for referring the old naming convention
> 
> I guess we agree that it should be vqn.
> Therefore, vq coalescing and aq series should progress with vqn terminology.
> This way all 3 series can progress in parallel (aq, vq coalescing, current spec cleanup).

Don't much care at this point but I think when I thought about this
deeply it seemed that yes, it is marginally better. Don't remember why
though ;)

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

