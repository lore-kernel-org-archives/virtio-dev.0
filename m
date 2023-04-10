Return-Path: <virtio-dev-return-12097-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0166C77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:50:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 982C044569
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:50:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22895986699
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 19:50:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9B243986353; Mon, 10 Apr 2023 19:50:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2C10298632A
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 19:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wSQOcQQuMcWyhppoBLqiMQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8O4xAWy9OLkX9SUJtHXe2lZ18P9NhBb+pkmHv2V0Lo=;
        b=hDggKX+l2ynJaP2saLZuHF9+0t29MsGHS/1STCtPnFpI07kFraw4Agunr1PVFYgfDJ
         UTQNfAp+nmGgvvYj+hhUJ/0ymKtP37I3OB8QVKVXzWcaxZKqScq6qE0OtbnN8yy15NGQ
         6NQnJqp7KM72jEffpcS4SJFY8rrtvnvNS+3VcqKR9QnTkon3+U4hASkBia4B9TObjhC5
         3BtfwJeQ3yNvIlcT90mPfhaSeCAtWFBDbnxtd4gJOYm0umuIoK2GG/sE1siPrY1h6lsg
         knrtAtl7+egs7t+ba8H2znfCgnEd7QVwZkMxp3FvhhEe9B4DMpYcMlWSSjZ0LBi4l0qx
         hpeA==
X-Gm-Message-State: AAQBX9chZ5t0k4vWR+BfLj00eE8CJm0F79VnUyQvvJHew+J01GqoW5GQ
	KY/AEVV4R4g7fRyuQP0c+xB0wJksUyzF5ocmkjSw4EvggoAJy8oQovjndRozlZ0QdzZNCUFl+y9
	n2R/0HNa6cQiJLmEFb3KxJsAe+5X4
X-Received: by 2002:adf:db43:0:b0:2ef:b31b:337c with SMTP id f3-20020adfdb43000000b002efb31b337cmr8677716wrj.37.1681156165492;
        Mon, 10 Apr 2023 12:49:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350YA3X9usOVz27xsNwnwIK/HNwBa7/o60Zr3U+ve2aSTGXYPm23tBlQo7sx1ZuyHCQNIQmImVg==
X-Received: by 2002:adf:db43:0:b0:2ef:b31b:337c with SMTP id f3-20020adfdb43000000b002efb31b337cmr8677705wrj.37.1681156165139;
        Mon, 10 Apr 2023 12:49:25 -0700 (PDT)
Date: Mon, 10 Apr 2023 15:49:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230410154518-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <20230404032922-mutt-send-email-mst@kernel.org>
 <87jzysjd4g.fsf@redhat.com>
 <20230404084126-mutt-send-email-mst@kernel.org>
 <878rf7kcna.fsf@redhat.com>
 <20230404102053-mutt-send-email-mst@kernel.org>
 <fce3c697-55a6-1410-2f42-db6499bd8f87@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <fce3c697-55a6-1410-2f42-db6499bd8f87@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Mon, Apr 10, 2023 at 12:21:56PM -0400, Parav Pandit wrote:
> 
> 
> On 4/4/2023 10:37 AM, Michael S. Tsirkin wrote:
> > On Tue, Apr 04, 2023 at 03:19:53PM +0200, Cornelia Huck wrote:
> > > > > > What does it "Co-developed-by" mean exactly that Signed-off-by
> > > > > > does not?
> > > > > 
> > > > > AIUI, "Co-developed-by:" is more akin to a second "Author:", i.e. to
> > > > > give attribution. (Linux kernel rules actually state that any
> > > > > "Co-developed-by:" must be followed by a "Signed-off-by:" for that
> > > > > author, but we don't really do DCO here, the S-o-b is more of a
> > > > > convention.)
> > > > 
> > > > 
> > > > Actually, we might want to generally, to signify agreement to the IPR.
> > > > How about adding this to our rules?  But in this case Satananda Burla is
> > > > a TC member so yes, no problem.
> > > 
> > > Adding a s-o-b requirement is not a bad idea... do you want to propose
> > > an update?
> > 
> > OK how about the following:
> > 
> > ---------------
> > The process for forwarding comments from others:
> > 
> > Generally, subscribing to the virtio comments mailing list
> > requires agreement to the OASIS feedback license, at
> > https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > 
> It is not straight forward for non virtio tc member to realize above
> obligation.
> It is worth to document it in the section [1].
> 
> [1]
> https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio#feedback
> 
> Something like,
> 
> From:
> If you're interested in following ongoing development and can't join the
> committee, I recommend you subscribe to the virtio-comment and virtio-dev
> lists.
> 
> To:
> If you're interested in following ongoing development and can't join the
> committee, I recommend you subscribe to the virtio-comment and virtio-dev
> lists. Your contribution to above mailing lists is licensed under the OASIS
> feedback license agreement describe at [1].

yes. unfortunately oasis does not let us tweak this section.


> > When forwarding (in modified or unmodified form) comments from others, please
> > make sure the commenter has read and agreed to the
> > feedback license. If this is the case, please include the following:
> > 
> > License-consent: commenter's name <commenter's email>
> > 
> > where commenter's name <commenter's email> is a valid
> > name-addr as specified in RFC 5322, see
> > https://datatracker.ietf.org/doc/html/rfc5322#section-3.4
> > 
> > If the comment is on behalf of an organization, please use the
> > organization's email address.
> > 
> > 
> > If forwarding a comment from a TC member, please instead get consent to
> > the full Virtio TC IPR, and then, as before, include
> > 
> > License-consent: commenter's name <commenter's email>
> > 
> License-consent tag do not capture the contribution by other virtio tc
> member(s) in the generated comment.
> 
> Signed-off-by captures it.
> So both tags are needed depending on comment contribution type.

Attribution is nice but Signed-off-by is not that.
And fundamentally people go read the PDF where the Signed-off-by
does not appear at all no one pokes at git history.
Let's just do:

Thanks-to: name <email>

if you want attribution.

will be helpful to fill in the thanks section in the spec
and does not mention signatures.



> Rest above change looks good to me.
> 
> > If you are reusing a comment that has already been posted to the
> > TC mailing list, the above tags are not required.
> > 
> > ---------------
> > 
> > We could reuse Signed-off-by though I am a bit concerned whether
> > people will assume it's a DCO thing which everyone copies.
> > Thoughts?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

