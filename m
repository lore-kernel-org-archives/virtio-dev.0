Return-Path: <virtio-dev-return-12762-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8867C77B7F
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:29:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 19AFA4434C
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:29:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECFFB986728
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:29:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D161098671F; Fri, 19 May 2023 06:29:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF1CF986720
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 May 2023 06:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1PCwMJb3N_Sa3ziBVtkZMA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684477779; x=1687069779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxEQW1ucRgp81ZiDs3ttrTqJCNFpDAP5M/JYaGDdeUM=;
        b=URg2gA2JeuTcJYOj39lLY3pFy0zDHJlniqv220zAYB7SjAU5OOvXyywKbqHpi9qzB+
         KZGSkFeG0frq1IIncGqnT8OP3WfUrGlBa0cu08JGn0afo8cQLmfv0/4h+7duEUrxcVCf
         7zVxoblQA9rYX2LAyTHFJk0eOs3eF1k80dwfSFSm1FW+S3y0F8AfCpTHJZRcC3/Z7jBi
         SNJ/abpaRgWtrQPWsr2UbNaJe0kxKARbKK/x/HkQeTOpuwrDAMRNB4LL19pYh9U0AoOc
         6mOF6vm1Jli23JjPwodpUhoWRZGRak/urDfIcbGDdaZBs8l6G+SaselRNc6CRu8KBKeA
         ajhQ==
X-Gm-Message-State: AC+VfDw9w1ELK6uBhoSdnlG0qISbe+CH9pwsmFaKPn0vZtDwYo2yyxiw
	FDlR27BpZJRFQQ0kBjNng4iiby4GJNRgDRvIJaS/kzcasMMNeYW0u7jCoRpKJtuv5NJtzmz/oMz
	nbTRy2jJ1NASVHobTJ8LEVakxnxS6
X-Received: by 2002:a2e:2417:0:b0:2a8:b37c:17f0 with SMTP id k23-20020a2e2417000000b002a8b37c17f0mr308070ljk.4.1684477779088;
        Thu, 18 May 2023 23:29:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RIScVXgxa1JFCstVrvRi4zBtzrUeWmkLiCIbY6e2CZ6f/FoCehD1xTznm6E3ICzxBtOx1MA==
X-Received: by 2002:a2e:2417:0:b0:2a8:b37c:17f0 with SMTP id k23-20020a2e2417000000b002a8b37c17f0mr308061ljk.4.1684477778757;
        Thu, 18 May 2023 23:29:38 -0700 (PDT)
Date: Fri, 19 May 2023 02:29:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230519022854-mutt-send-email-mst@kernel.org>
References: <20230421145434.83774-1-parav@nvidia.com>
 <20230422061011-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D66357FCDAE3B3869DADC679@PH0PR12MB5481.namprd12.prod.outlook.com>
 <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54809734DCE2820CA728AFA0DC6B9@DM8PR12MB5480.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v3 0/2] transport-pci: msix register
 desc improve

On Fri, Apr 28, 2023 at 04:10:21AM +0000, Parav Pandit wrote:
> Hi,
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Parav Pandit
> > Sent: Monday, April 24, 2023 11:15 AM
> 
> > > LGTM.
> > > Given the amount of back and forth, I guess we should vote.
> > >
> > Ok. created github at [1].
> > Will wait for few more days to ask for vote for any other review comments.
> > 
> > [1] https://github.com/oasis-tcs/virtio-spec/issues/169
> 
> Can you please raise the ballot for this?

FWIW the proper format is

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/169

as documented in our README.md


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
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

