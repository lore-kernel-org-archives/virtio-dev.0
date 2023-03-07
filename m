Return-Path: <virtio-dev-return-11485-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6519FC6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:15:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 957712A887
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:15:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 900879866D9
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:15:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 849819866CC; Tue,  7 Mar 2023 17:15:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 742109866CD
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Mar 2023 17:15:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BFT7Gk-LMyKMgoEq-ajtVw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9tfkcdHcSjyUmRJCpNoL5f0TcTXbihgplDDNbKgyzQ=;
        b=cHvePqTStrNfBkbAP4RjG5pp5qunNgCVW25BveVMu2ypf0uT6xfL5oWsGaK8vrEvx1
         TDauSVo+YRuLcdzCmiLLijOb27BQ5f0LPPdSdlAMfPDzBzjAqpU9tBADzstKJUgJOpDR
         sMPgcp6Y8OHZPbHW5TdaAMh73zugRtqsjQdj27q3v78MvPI+AFhyW57Cl9dW3cC8evW2
         8DRqDzPGHppDgwyiboCrvnAElJXvCk47cLhwR7f4lZY1ZLrmy63PjCB92AU5oj36AzLB
         j4qFuV8Nknj9akKcszIwQK4WSq2yHO74rnjsl+x7e2FSowQxwSU5NFfC44FLomxuUJBP
         EnJQ==
X-Gm-Message-State: AO0yUKU9MBu72sdkL+Ho53IMil6mBWanRReU78IJ6gHtkdeZ0A3WHVz7
	3j4iT45pikJ3CJKJEZ9VmE18k4zb7VcsybvSr0AxIDm1ujrQUclg9h/fFoREKRnKXZuH3vb6j3g
	zNL/SGAIYEDjUJLEsjVAURHuxDRuP
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id c12-20020a05600c0a4c00b003dc0d5c76d9mr14322240wmq.0.1678209318972;
        Tue, 07 Mar 2023 09:15:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/R4YX3qhGoPH/6DVrZdjBvv+J9mgSrD/HrYg1CDyY/mLAzez/hgcUTMyaLN/1DzJlCPgG4BQ==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id c12-20020a05600c0a4c00b003dc0d5c76d9mr14322216wmq.0.1678209318649;
        Tue, 07 Mar 2023 09:15:18 -0800 (PST)
Date: Tue, 7 Mar 2023 12:15:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230307121455-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAYXZPVulKWDIuRr@nanopsycho>
 <20230306174654-mutt-send-email-mst@kernel.org>
 <ZAbk763tfCRpRIBV@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAbk763tfCRpRIBV@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

On Tue, Mar 07, 2023 at 08:17:03AM +0100, Jiri Pirko wrote:
> Mon, Mar 06, 2023 at 11:48:32PM CET, mst@redhat.com wrote:
> >On Mon, Mar 06, 2023 at 05:40:04PM +0100, Jiri Pirko wrote:
> >> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
> >> 
> >> [...]
> >> 
> >> 
> >> >  admin: introduce device group and related concepts
> >> >  admin: introduce group administration commands
> >> >  admin: introduce virtio admin virtqueues
> >> 
> >> The ordering seems a bit odd to me. I think that at the beginning, the
> >> admin virtqueue should be introduced with generic concepts (including
> >> the generic command structure), only after that the section introducing
> >> device group stuff and related commands.
> >
> >That's intentional.
> >
> >Jason is working on additional ways to pass commands to
> >devices, using memory mapped registers.
> >
> >Thus admin commands stand by themselves, and the queue is
> >just a way to issue them.
> 
> Okay, in that case, woudnlt it make sense if the generic CMD text
> (including the generic command structure) would go first, then the
> "group" related cmds?
> 

there are not other commands though - they are all group related.

> >
> >
> >
> >> This publicly archived list offers a means to provide input to the
> >> OASIS Virtual I/O Device (VIRTIO) TC.
> >> 
> >> In order to verify user consent to the Feedback License terms and
> >> to minimize spam in the list archive, subscription is required
> >> before posting.
> >> 
> >> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >> List help: virtio-comment-help@lists.oasis-open.org
> >> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> >> Committee: https://www.oasis-open.org/committees/virtio/
> >> Join OASIS: https://www.oasis-open.org/join/
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

