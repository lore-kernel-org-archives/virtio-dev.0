Return-Path: <virtio-dev-return-13330-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A181EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 15:17:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 23CB42B053
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 15:17:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0542D9864BB
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 15:17:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E0CF8986488; Mon, 10 Jul 2023 15:17:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9B4F98648C
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jul 2023 15:17:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tyyw1GNdNO-bEcmrCKow1g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689002231; x=1691594231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z55BMcYS8hz3ZW7mYQF6xdlBFFkLe2GaxljPUVSzymY=;
        b=AmYUN//UuXkl8P4cUSy/A5bfpNF80TcJvDmEgi+IDuQurtM/R3YoSvTtCthDBIrxV1
         7tgeHwkz/SzxoNFJfzZqIwZi0vvP96jAccLAcbr+LeOGMMU5iM/AQUGmj3HJefJ1bspV
         h9wt8bXAHWX7iTYazNYR+Wx7NTmtBIwGbPIqSC3LnQtMaHUBdDdxvPXhkHSFIDLnRSQF
         wiFzYQtkFgoTa3MfHKYepSEgTvur5AWjN8+DoqaLCFGn92bj//v0a74FZ5fDKl3JVBmB
         LEcNcPnNqzQJcPq/iqP9xpcj3YXJDaRClv2P756mxDgkF8Y1bpdbBq2KZR5v/PCxNs41
         R5SQ==
X-Gm-Message-State: ABy/qLY4P0pp/gl6Ul7Na32E7tkDlfbe/+IG2n+3nRYNSFnrjlFGjQ8X
	7rPUAORJKtROT0vukZy+YYx/nrz0ljPoX8pLmohM++jSzmVIAKpg9EwQ4ZixY2xsDOz2bAjPMvH
	6RGXMS7jZpNhnflSzC0qZxcirE+RO
X-Received: by 2002:a1c:f713:0:b0:3fb:adc0:609b with SMTP id v19-20020a1cf713000000b003fbadc0609bmr12288308wmh.13.1689002230953;
        Mon, 10 Jul 2023 08:17:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwtR53qQjuNDDFqnbcXt/KvYqA+xqWNDFGnDHOFwfqR6crldUmPVZ0M2Jz1eRCuz080ZZAgw==
X-Received: by 2002:a1c:f713:0:b0:3fb:adc0:609b with SMTP id v19-20020a1cf713000000b003fbadc0609bmr12288277wmh.13.1689002230497;
        Mon, 10 Jul 2023 08:17:10 -0700 (PDT)
Date: Mon, 10 Jul 2023 11:17:06 -0400
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
Message-ID: <20230710110511-mutt-send-email-mst@kernel.org>
References: <20230707153019.147039-1-parav@nvidia.com>
 <20230709093550-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813BA69D6474462F413BD8DC30A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813BA69D6474462F413BD8DC30A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] [PATCH v13] admin: Add group member legacy register
 access commands

On Mon, Jul 10, 2023 at 01:05:34PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, July 9, 2023 9:47 AM
> 
> 
> > > +If within \field{struct virtio_admin_cmd_legacy_notify_info_result}
> > > +returned by VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO, the \field{flags}
> > > +value for a specific \field{struct virtio_pci_legacy_notify_info}
> > > +entry is 0x0, the driver MUST ignore this entry and all the following
> > > +\field{entries}. 
> 
> Please see above, it appears to me that it covers what you asked for, no?
> What is missing?

Oh, my bad. I agree. following stresses this a bit more:


is 0x0, then the driver MUST ignore this entry as well as all
the following \field{entries} until the end of the structure.


> > The driver MUST additionally validate, for each
> > > +entry, that \begin{itemize} \item the \field{flags} is either 0x0,
> > > +0x1 or 0x2 \item the \field{bar} corresponds to a valid BAR of either
> > > +the owner or the member device, depending on the \field{flags} \item
> > > +the \field{offset} is 2-byte aligned and corresponds to an address
> > > +within the BAR specified by the \field{bar} on \field{flags}
> > > +\end{itemize}, any entry which does not meet these constraints MUST
> > > +be ignored by the driver.
> > 
> > Wait a second.
> > - end of list not documented - we want conformance statements
> > - for end of list I am guessing other fields do not matter
> > - entries after end of list also do not matter?
> 
> I reread the above driver conformance statement.
> It already indicates what you asked.

So the above two do not contradict. They kind of seem to since 1st
one says ignore second says validate, until you look closely
and see that the result of validation is to ignore.
I suggest we clarify it's other entries not each entry:

	MUST ignore this entry and all the following \field{entries}.

	Additionally, for all other entries, the driver MUST validate
	that \begin{itemize} \item the \field{flags} is either
	0x1 or 0x2  ....


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

