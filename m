Return-Path: <virtio-dev-return-12331-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C985DC77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:32:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 119622AC49
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:32:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03D6398663C
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Apr 2023 20:32:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EBB31983DDD; Thu, 20 Apr 2023 20:32:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4DA698634C
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Apr 2023 20:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: iRQ7o6TbMxe_ZfeR6FZ4-Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022744; x=1684614744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FOpHFaAs+DuDz5mAaX9ANVlTWQeBMsRGoDcsv0LXys=;
        b=PRKe+VWQDuJ6Q275nxfAbnk8LEDATExd+7lztjbc3F5nuqY6ZVWScXvxSBOTSdxMPX
         TYWfevLuwyx63xMKHqIp2mYcyuqaBcA3ss61bDJ+LIvbO1I0ohOls4B8bWnt0TFPrpJ7
         nJydCsgh9zFn2wBDOiqa7gfRuYBQCohsW2KZBb9t8DefP6H/8+DRKKRogBq1Tblyb7Gp
         gPoZsl4sJH6gPLxmn23VVugQiu/hVzQXEkPI77eZkji6AgP16p81ldCw3ISIfMoxjC5C
         7Zl4JiPu9AvFvUdEEKLZ75aHs0XtocpNYezt5WJ6XOvQDRn6ABC4PL1GitELPiRrLNCb
         fZ3g==
X-Gm-Message-State: AAQBX9fyjQYQM0CUimr/PuQii1V/IZXoXKONEaHeZYx+CzfZhXjcV89A
	6PwsdNU4+gUDZDylSEMactBEhSV4HoONviix4pE1lxjQbbZwtWiORWMBQWdHEfbSq+FTWs/9aPu
	RPvnpKlqsdh+Y+EgXoFTCDg+5d8C5
X-Received: by 2002:adf:db09:0:b0:2fb:9995:f707 with SMTP id s9-20020adfdb09000000b002fb9995f707mr2146504wri.67.1682022744603;
        Thu, 20 Apr 2023 13:32:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350aybwoiAvDPsym5YHR7fa06lELbwC+tbhGIp18vQJo9sZ5+BWtV0LpA0lIzCGzPhzetA6gaCA==
X-Received: by 2002:adf:db09:0:b0:2fb:9995:f707 with SMTP id s9-20020adfdb09000000b002fb9995f707mr2146495wri.67.1682022744232;
        Thu, 20 Apr 2023 13:32:24 -0700 (PDT)
Date: Thu, 20 Apr 2023 16:32:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Message-ID: <20230420163158-mutt-send-email-mst@kernel.org>
References: <20230420124647.58488-1-david.edmondson@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230420124647.58488-1-david.edmondson@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 0/2] Minor improvements

On Thu, Apr 20, 2023 at 01:46:45PM +0100, David Edmondson wrote:
> A couple of minor improvements:
> - add "and" between two "MUST",
> - avoid using abbreviated flag names, making it easier to search the
>   specification for the actual flag names.
> 
> David Edmondson (2):
>   virtio-net: Minor wording improvement
>   virtio-net: Avoid abbreviating flag names
> 
>  device-types/net/description.tex | 89 ++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 39 deletions(-)


Acked-by: Michael S. Tsirkin <mst@redhat.com>

seems like an editorial change. Cornelia, want to commit?

> -- 
> 2.39.2 (Apple Git-143)
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

