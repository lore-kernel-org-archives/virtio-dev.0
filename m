Return-Path: <virtio-dev-return-12960-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C94EB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 15:18:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D9E6116DFCE
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 15:18:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B30F69863A9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 15:18:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 91E8B9863A6; Mon, 19 Jun 2023 15:18:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DA349863B0
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 15:18:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Hitwpun6POeWvZumuL__kA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187919; x=1689779919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUvPoaiG48BOW46u+ZKGb+PBS4kbXbLAXBSnhFstXHo=;
        b=hKN5IJ3JNHM1OWUHzjQsW04BP8/akUzssiiQItmtn4TeNMzUPw522/BblCnbX4sid5
         L/uRohPq9COtwKmfO77LDNJEO9eIV93Cqy0DlxqIe8SLGYcut8syco7iejEIsFsL7nO2
         GoePl6MFhvs+GkZdFAautKGv9wY0hJZ5oCHnXX5agwgoJDwINnH/JasmSf/BDXcoggHP
         YgKxBmfc4+gPgTLauUjlIrEaZU12bfjagyGeHxt3Ydr8nTUJfbGTZYmATXnavCxft4vc
         /eMSmZoAVfKmzINecqJLslfPdDgvJW00PPcC58D1aSp0mL9BHmO8aPoOMwAy2Zad4O8M
         x/kQ==
X-Gm-Message-State: AC+VfDwBwOF44LTXA8dFNOMbrQrh4STqQdhucZrPeUdzgcwnrbxYAtv6
	jlzVgVQ1f8VQOkKnIwMGMbj/oSdbSslwUMvTXTqccHQBXtfgSChWziJI2qRQwYOLzSRQ42Yf66B
	mAuT8+AVHeAqPvULSuRsbdDD1thSO
X-Received: by 2002:a05:600c:2212:b0:3f7:2a13:9621 with SMTP id z18-20020a05600c221200b003f72a139621mr6531902wml.40.1687187919189;
        Mon, 19 Jun 2023 08:18:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ403EopivTA+GuFpePD6nAo95tPPGew4dIdrZI6hkTV48uIhtMpkZG9ndiKNvOouXZRA236kw==
X-Received: by 2002:a05:600c:2212:b0:3f7:2a13:9621 with SMTP id z18-20020a05600c221200b003f72a139621mr6531887wml.40.1687187918880;
        Mon, 19 Jun 2023 08:18:38 -0700 (PDT)
Date: Mon, 19 Jun 2023 11:18:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230619111731-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <PH0PR12MB54815F02CE10368D6204EC8CDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815F02CE10368D6204EC8CDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 0/4] admin: Introduce legacy registers access using AQ

On Mon, Jun 19, 2023 at 12:38:29PM +0000, Parav Pandit wrote:
> Hi Michael,
> 
> > From: Parav Pandit <parav@nvidia.com>
> > Sent: Tuesday, June 13, 2023 1:30 PM
> > 
> > This short series introduces legacy registers access commands for the owner
> > group member PCI PF to access the legacy registers of the member VFs.
> > 
> 
> [..]
> 
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > ---
> > changelog:
> > v5->v6:
> > - fixed previous missed abbreviation of LCC and LD
> > - added text for the PCI capability for the group member device
> > v4->v5:
> > - split pci transport and generic command section to new patch
> > - removed multiple references to the VF
> > - written the description of the command as generic with member
> >   and group device terminology
> > - reflected many section names to remove VF
> > - split from pci transport specific patch
> > - split conformance to transport and generic sections
> > - written the description of the command as generic with member
> >   and group device terminology
> > - reflected many section names to remove VF
> > - rename fields from register to region
> > - avoided abbreviation for legacy, device and config
> 
> Do you have any further comments?
> I would like to raise for the vote now as this is in oven for several months now and users need this in 1.3 spec.
> If there are any editorial fixes, I can fix them now with v7 or 
> if they are small, I can fix them during the voting wait period like how we completed AQ fixes.
> Please let me know.


Just back from travel. I remember having comments, will send in a day or
two. I don't think we are talking about editorial things though.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

