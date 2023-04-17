Return-Path: <virtio-dev-return-12247-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7534C77B76
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 07:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EDB1E33568
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 07:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51ABE98669B
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 07:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A4035986353; Mon, 17 Apr 2023 07:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3E23898632B
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 07:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: f8WUrRtHOoaVicXU7bX3wA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715082; x=1684307082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvzB1e4cW+pqb6hwqprUyb1PUFaW3hl1Of72kb9ZEKo=;
        b=lHt5Ic/jRDwycg8Be2cgPnpOQoy7OJQjj1kmICUCz+yb1HK7yyNRauWurM7UNSrBDj
         qXo2gKh9twx/Q/cbRoCrlXAc8FYBJDZsxVihPJz6LVrpp6FXn8QRWWuUti28tLGfG1Ma
         Up45Nck44vbDByw0EXJBYX+duZKevaYoJhw/eiRXSuyYljaai4qU/dRPtg5TEgYAwT/z
         MKRcrfUZr0ScjzFEnPgS7XedhjMADv5DGsKZWUxvOgg5w74hlUY2nmDzPgN0OGH3vaNI
         1vzIWgtlfCC4TJsI7g+a2Dgnelc9OItwBx8xw1ZR1xNxZ/LD3QzFcJEqRXPspBfyGsvj
         DMig==
X-Gm-Message-State: AAQBX9fJ1YfMMcQThC0hb5NgsAUzo+va+5mkqY4PfWzFDGjN4CifREM8
	uCLUIsCz7HyB/v5paW8Sr6UIuV9GufkjOaybmIT+xY/x3XCsNmjS668AsQwqY4gge2WX4yekZXp
	8khvGYKmfQOn5nW89azJ0ZM8kl5xU
X-Received: by 2002:a05:622a:4cf:b0:3e6:2d20:1737 with SMTP id q15-20020a05622a04cf00b003e62d201737mr17946473qtx.54.1681715082163;
        Mon, 17 Apr 2023 00:04:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350YcYhBOylfy7pKRFr/f6WSZ5f+Od50hOlLEL6XIKJ08IpiKLYyKakWjIE7Iceo6em1zAxHglQ==
X-Received: by 2002:a05:622a:4cf:b0:3e6:2d20:1737 with SMTP id q15-20020a05622a04cf00b003e62d201737mr17946459qtx.54.1681715081865;
        Mon, 17 Apr 2023 00:04:41 -0700 (PDT)
Date: Mon, 17 Apr 2023 03:04:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230417024402-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-4-parav@nvidia.com>
 <20230405012723-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C1EC27F79A87218C3767DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230405172731.561890b1.pasic@linux.ibm.com>
 <PH0PR12MB54819AFEDBFEC41CACA0CF92DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407073308-mutt-send-email-mst@kernel.org>
 <87ile2kdav.fsf@redhat.com>
 <PH0PR12MB54812C754ED9063E34E06E1BDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230417051844.70ba47cc.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230417051844.70ba47cc.pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [PATCH v12 03/10] content:
 Rename confusing queue_notify_data and vqn names

On Mon, Apr 17, 2023 at 05:18:44AM +0200, Halil Pasic wrote:
> On Tue, 11 Apr 2023 13:35:09 +0000
> Parav Pandit <parav@nvidia.com> wrote:
> 
> > > From: Cornelia Huck <cohuck@redhat.com>
> > > Sent: Tuesday, April 11, 2023 4:56 AM  
> > 
> > > 
> > > Yes, please leave it as F_CONFIG_DATA, as we're just putting some "data"
> > > there in the end (and F_CONFIG_COOKIE might indeed be confusing for the
> > > ccw case.)  
> > 
> > Since Halil didn't respond for 5+ days + Michel and you propose to continue use CONFIG_DATA and this is rare used field, I will rename 
> > 
> 
> Sorry, this one has fallen through the cracks.

Well this whole patchset is just a cleanup so it's not holding up other
work at least. But I have to say it's difficult to make progress when
someone comes back from outer space after more than a week of silence
while others finished a discussion and reopens it with some new
feedback.

I am not saying don't give feedback but I'm saying please help us
all be more organized, feedback time really should be within a
day or two, in rare cases up to a week.

And I'd like to remind everyone if you are going away you are supposed
to report a leave of absence.

TC's that have meetings just take away voting rights from someone who
does not attend two meetings in a row.  We do it by ballot so this does
not apply, but I think we should set some limits in group's bylaws,
anyway. Ideas on formalizing this? If not we can just have informal
guidelines.  There's of course a flip side to this. Some patches
seemingly go through two versions a day. Keeping up becomes a full time
job. We'd need a guideline for that, too.

I also feel high latency is one of the reasons people are beginning to
ask to split into subcommitees where they won't have to deal with this
kind of thing. Let's try to keep the latency low, please.

> For
> the preceding ones: I do not have a strong opinion. I do
> share Michael's and Connie's assessment regarding a possible
> clash with CCW.
> 
> Let me just note that the feature ain't called, "F_CONFIG_DATA" (i.e.
> with full name VIRTIO_F_CONFIG_DATA) but rather "F_NOTIF_CONFIG_DATA"
> (i.e. with full name VIRTIO_F_NOTIF_CONFIG_DATA).
> 
> > vqn to union of
> > 
> > vq_index
> > vq_config_data
> 
> In that sense vq_config_data is not good in my opinion, because
> it misses "notif" which is present in both "F_NOTIF_CONFIG_DATA"
> and "queue_notify_data".
> > 
> > Thanks. Will roll v13.
> >
> 
> I'm about tho have a look how this panned out in v13. I propose
> let us continue the discussion there.
> 
> Regards,
> Halil
>  
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> > 
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> > 
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

