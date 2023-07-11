Return-Path: <virtio-dev-return-13337-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CD8C0015E
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 09:14:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E898D3F8FE
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 09:14:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA17598655C
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Jul 2023 09:14:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C9DA2986503; Tue, 11 Jul 2023 09:14:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5249986547
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Jul 2023 09:14:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JBNX3qzEM3eX8Yrr3Z6MIA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066862; x=1691658862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh/P8RAOMdRN5Bi9QbBTT3riJvp8WHqp3iyzq+p1pmg=;
        b=OCPqC6Z5odDO0kTY4uE5aQkrG+2GtegBMii5Z08jzRHoRu60ERpVR7J/u914PcOsp/
         zFAVSC6D+KAp/Pd84y4rbjCDWPyjlY9NazEormCA5XqOqTl2ej6y4ye+2WY7GN5wikkR
         4MUEKYDuHnb2LImCOBrvVBR0fuhuZDlsGMBTmQ9RBy/mbo+R6MWDGKuHXoqagSjPgU7Z
         9/iwcZ4mtlmtPI3f8mvz1ccsrgF/TE6AAZIp6OTcYVsxhtAq7KEOTXkRj4mJvWJkHA1t
         myKlSiq4Iy960uU+TwAVsT2RJmCP26T/TOzHNm69PibY1pzIP7BrGztgSmEIGIt15ek3
         0TwQ==
X-Gm-Message-State: ABy/qLY7CrMzDd5FjgclNtnijU3ispUMAYL32XEFtFBAMbNuLw+qhDBf
	JhI/zbYwBGyXAwUzyvYZfyrSd8b/REe4j35geVDx0sOGbXpkp9dv0BeHrpnnnkSj9SzjkACDsyU
	AyD0URlRfrz5AsHnvoIHfZHeTVnjF
X-Received: by 2002:a05:6512:310a:b0:4fb:7626:31a2 with SMTP id n10-20020a056512310a00b004fb762631a2mr12126549lfb.43.1689066862472;
        Tue, 11 Jul 2023 02:14:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEBLvliDpl1qIvyb+qgbfXPhko67+y2b+7cQp3qA5bZN/DCC2To3P1hasktvoVaFIy81MhDxA==
X-Received: by 2002:a05:6512:310a:b0:4fb:7626:31a2 with SMTP id n10-20020a056512310a00b004fb762631a2mr12126525lfb.43.1689066862174;
        Tue, 11 Jul 2023 02:14:22 -0700 (PDT)
Date: Tue, 11 Jul 2023 05:14:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org,
	david.edmondson@oracle.com, virtio-dev@lists.oasis-open.org,
	sburla@marvell.com, jasowang@redhat.com, yishaih@nvidia.com,
	maorg@nvidia.com, shahafs@nvidia.com
Message-ID: <20230711051109-mutt-send-email-mst@kernel.org>
References: <20230710161752.204248-1-parav@nvidia.com>
 <20230710122502-mutt-send-email-mst@kernel.org>
 <87pm4ylspa.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87pm4ylspa.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v14] admin: Add group member legacy register access
 commands

On Tue, Jul 11, 2023 at 11:10:09AM +0200, Cornelia Huck wrote:
> On Mon, Jul 10 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Jul 10, 2023 at 07:17:52PM +0300, Parav Pandit wrote:
> >> +The \field{flags} value of 0x1 indicates that the notification address is of
> >> +the owner device, value of 0x2 indicates that the notification address is of
> >> +the member device, the value of 0 indicates that all the entries starting from
> >
> > , the -> and value of 0x0 
> 
> Looking at this sentence again, maybe make this
> 
> "A \field{flags} value of 0x1 indicates that the notification address is
> that of the owner device, a value of 0x2 indicates that the notification
> address is that of the member device, and a value of 0 indicates..."
> 
> if you're tweaking it anyway?

Oh yes, of course. Ack to that.

> >
> >
> >> +that entry are invalid entries in \field{entries}. All other values in
> >> +\field{flags} are reserved.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

