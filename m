Return-Path: <virtio-dev-return-12057-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDDBC6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:24:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E32C62113C
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:24:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D72CF9865E3
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:24:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CA3ED983F7B; Fri,  7 Apr 2023 11:24:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B881B9865D8
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 11:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0S4sPYCQMhapUa3harFwCQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680866681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9wV+HPybbcwvA0ir1v/VEcSMEAVkTUNIV/pHtIIsug=;
        b=0Jqa9zcVEYe3fvor2q/AicLXkVYnEVDIWmBJgjxm4tq5/kTjzQqpshfvILLQsBUFxz
         mAuY2wc6qYhBMFRrl0KqZgN9tC/Yjhsr+QuB8G0Oc5nAQrID5yB3VFANanAkFm0swtR+
         b/Z5bGtGM3mmggodaryUea3STgYLu3UDDQuKYQ0QqGKyqmqr989UrHCeSLVujCCps++L
         cJEQi/Xz6lFy4yMDoJ6DUcd0vn5g1xzAiC8noOK/bgAB6DZJWg8hnCz446muGUYJx1Nl
         eXPu14Et7RLI2xAb1GfHKJqRJPiKcCc5ovoiVzFyMlrk3Z8bNYeJiLkbPoaiwSlo0AxP
         XNag==
X-Gm-Message-State: AAQBX9eWN0mtGcwLvfdNfsCxiAkhOHCo0irg2/m4L6QMUbyJVSYGulQX
	V5/cy9ZPqQZq+ppWu1PIthbE4CBMKikPfJZBuVBHQp8CQrE5GgNcLjJC3x7gEX/QC9b5CmEVC3t
	ck5WwBR2/yy3ueCGKe6Uu5LGF/Cg1
X-Received: by 2002:adf:f54c:0:b0:2ce:ab0a:81fe with SMTP id j12-20020adff54c000000b002ceab0a81femr1097936wrp.62.1680866681303;
        Fri, 07 Apr 2023 04:24:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZzhDDK/LlcybITOO75HAuXJuWz/Li2ZHZf1zN7tShcpSdZbeuJStlg58lZ2IwTrpB33g9KRQ==
X-Received: by 2002:adf:f54c:0:b0:2ce:ab0a:81fe with SMTP id j12-20020adff54c000000b002ceab0a81femr1097929wrp.62.1680866680979;
        Fri, 07 Apr 2023 04:24:40 -0700 (PDT)
Date: Fri, 7 Apr 2023 07:24:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230407071926-mutt-send-email-mst@kernel.org>
References: <87edoyqvnu.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87edoyqvnu.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [RFC] virtio 1.3 schedule

On Wed, Apr 05, 2023 at 03:57:09PM +0200, Cornelia Huck wrote:
> The virtio 1.2 spec has been released on July 1st, 2022, so I think we
> should come up with a plan for the 1.3 release. Given that it took us
> several months last time, we need to think about declaring freeze during
> (northern hemisphere) summer if we want to have a release ready before
> the end-of-year holiday season starts.
> 
> We have some things currently under discussion/review that we should
> still consider for 1.3:
> 
> - vq index etc. naming cleanup
> - admin vq
> - virtio-video
> - some things we deferred for 1.2 (see
>   https://github.com/oasis-tcs/virtio-spec/issues?q=is%3Aissue+is%3Aopen+label%3Adeferred-in-v1.2-csprd01)
> - other things that are not on my personal list (please mention whatever
>   you think is important)
> 
> Please also keep in mind that 1.3 will not be the last virtio release,
> and many projects like Linux or QEMU consider features stable and ready
> for inclusion once the spec has hit the git tree, but not neccessarily a
> virtio spec release.
> 
> That said, let me propose the following timeline:
> 
> - July 1st 2023: enter feature freeze; all proposed changes must at
>   least have an open github issue that refers to a proposal on-list
> - August 1st 2023: enter change freeze; everything needs to have been
>   voted upon (i.e. we can start with preparations for a release like
>   compiling the change log)
> - at the same time, fork virtio-next, which can be used for development
>   while we're working on the release
> - August/September 2023: prepare draft, initiate initial voting etc.

Hmm looks like you forgot a 30 day the public review period (or is that
included in the "etc"? ).  During this period we will likely receive
review comments which we have to address. Should the changes turn out to
be material, another public review period will be required.
Let's spell it out please.



> - by September/October 2023: have the final 1.3 spec ready, voted upon,
>   and released
> - virtio-next can be merged into mainline, and we continue with business
>   as usual
> 
> Thoughts? We might want to move things a tad earlier, but I don't think
> we should push the schedule out much further.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

