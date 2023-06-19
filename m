Return-Path: <virtio-dev-return-12977-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87774EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:33:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EA4B8C6109
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:33:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E24B6986429
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:33:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D516F9863B0; Mon, 19 Jun 2023 17:33:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD0D49863A6
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 17:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: v2qGC5_4Mh2p9IvQVyo6qQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687195991; x=1689787991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8skxta9Z5M93F23t1nFncrCwPJc3ehSV0rJ+zuHUCUE=;
        b=RLBM7F2EcYoEKKaKUF1+AWu42UFsCp+s9sdSwL2I2gMwLzjrpIbj2g/3uBDg3jdUkC
         CUKgCpSYlcYsuwwgeFmh7jRLqd2TGgxeXJ79PL77zEWLm60M5AN829aXKd2bGr6ITH9k
         Zrdh7R5hAWG2PzisJmieysIebks0p9M3YrlXMcPPIo5LhR31FOvc97topb0grQX56J1Q
         yp0oVDwpgwIxC4jKHGRqH8R5IIY5Ryn1eZ0eL5R5TajtY2Fyl/ZE2QLqBlBbSPdI18C/
         WitvhKz7a7ok13JAmKmxTpai+Vd7ijgEBfWVzxnanRy6b+ap1Ez6hAHRCkDMrRJXh+N/
         jENg==
X-Gm-Message-State: AC+VfDy9vDO5+bzD9UDim+WLf0hqcL7p4+ZXwlFq/NxVrGy6Or2BAW+9
	Vp0qElO4a6gJTeWF7sIkiNn9z9AWPY0QEHGFcNeXu2zu7ZoV7AjI9O33Sg62IACi3vyAvCUVY5V
	qKefvV4fQ3bcRSmNeCuOMXo8G4YWQ
X-Received: by 2002:a7b:c454:0:b0:3f7:5e08:7a04 with SMTP id l20-20020a7bc454000000b003f75e087a04mr8597879wmi.25.1687195991360;
        Mon, 19 Jun 2023 10:33:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6C4sK3P1Y7P+PK6JOKEuGNY+XRSjHuptIXsDAKhITATz3tZJFZ7FXVEf4RiqJSjtawYpgz3Q==
X-Received: by 2002:a7b:c454:0:b0:3f7:5e08:7a04 with SMTP id l20-20020a7bc454000000b003f75e087a04mr8597857wmi.25.1687195990992;
        Mon, 19 Jun 2023 10:33:10 -0700 (PDT)
Date: Mon, 19 Jun 2023 13:33:07 -0400
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
Message-ID: <20230619132640-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-4-parav@nvidia.com>
 <20230619121724-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EE01C25B4C170E498177DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619123757-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816B14CE2DA659837D1C09DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619130440-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AE9F8C823289DD17C7B2DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AE9F8C823289DD17C7B2DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v6 3/4] admin: Add group member legacy
 register access commands

On Mon, Jun 19, 2023 at 05:21:20PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: Monday, June 19, 2023 1:11 PM
> 
> > > The "legacy interface of member device" is a vague term. As implementer,
> > reader I don't understand what that means.
> > > The commands clearly communicate the scope.
> > 
> > Add this as an example then.
> >
> I don't know what this means. 
> The section speaks for itself.
> We currently have,
> 
> Section 2.12.1 as "Group administration commands".
> Under this I added,
> 2.12.1.1 -> Legacy interface: legacy configuration access commands"
> 
> Above is no different than 
> "3.1.2 Legacy Interface: Device Initialization"
> 
> Tomorrow,
> 2.12.1.2 -> features config commands
> 2.12.1.3 -> 
>  
> > > > If you want to also have a type specific text, be my guest
> > > > "specifically, for an SRIOV type" ....
> > > >
> > > SRIOV in generic section doesn't make sense. It is covered in the pci transport
> > section.
> > 
> > When it's convenient to you you argue that it's clearer, when it's not you want it
> > generic.  Just mention it quickly and link to the specific text in the new section.
> >
> If you reviewer makes point "it is suggestion".
> If patch proposer makes a point its "argue" is not good way to discuss.
> So can you please avoid quoting "arguing".

To argue
	verb: give reasons or cite evidence in support of an idea,
	action, or theory, typically with the aim of persuading others to share
	one's view.

> 
> It is not my convenience.
> In the spec transport specific parts are not added.
> Hence, I said SR-IOV in generic to be avoided. It is better kept in the pci transport section.
> 
> > If you are intent on
> > spreading this all over the spec we'll need to rethink the whole approach.
> > 
> Where is this spread all over?
> In v5 it was self contained mainly in pci transport section.
> You asked to split to generic and pci.
> Fine, I split to two.

OK I see, I guess I wasn't clear. I was talking about as much as possible
using terms "owner" "member" "commands" "member_id" and so on,
such that the commands apply as generally as possible.
From that POV this needs a bit more work I think we can make more
things generic.

But I am looking for a way to keep this stuff as self contained
as possible. I don't much care whether the new tex is
under pci and admin command section just lists commands and links there,
or it is under admin and then pci section links there.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

