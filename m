Return-Path: <virtio-dev-return-10417-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1352986450
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Jan 2023 16:52:20 +0000 (UTC)
Date: Tue, 3 Jan 2023 11:52:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230103115138-mutt-send-email-mst@kernel.org>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230103054425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EDF2A7DE69145E93ECDEDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103091842-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2990D83282101967A8CDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103104223-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AAC2F0B95074EE0CFA08DCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103111801-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C5DBA7808E4754FCE4FEDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C5DBA7808E4754FCE4FEDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [PATCH v1 00/20] Split device spec to its individual files
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 03, 2023 at 04:41:33PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 3, 2023 11:19 AM
> > 
> > On Tue, Jan 03, 2023 at 04:04:11PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, January 3, 2023 10:44 AM
> > >
> > >
> > > > > I was writing up reply to other thread at the moment.
> > > > > But lets continue here since you ask.
> > > > > I don't have a strong opinion, but I find directories neat.
> > > > > This is because we have many devices spec files, conformance files
> > > > > and it's
> > > > expected to grow.
> > > > > I have transports directory and place code in there.
> > > > > Since latex spec doesn't have good way to include and refer sub
> > > > > section, we
> > > > have many files.
> > > > > 19 devices * 3 spec files + 3 transports * 3 spec files.
> > > > >
> > > > > And once spec is in its own directory, things should be self-sufficient.
> > > > > Only touch points will be in common areas which should be less frequent.
> > > > > WDYT?
> > > >
> > > > Yea I know. It's just that one of the ways we publish is a directory
> > > > in a web browser
> > > Do you mean browsing https://github.com/oasis-tcs/virtio-spec/ in a web
> > browser?
> > 
> > No, the one at oasis:
> > 
> > https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/tex/
> > 
> > this is technically the authoritative one.
> > 
> Ok. I get it.
> Shall we continue with currently proposed directory?


I'll let you decide, either post a new version or propose
a new one. In any case request a vote and I'll start it.

> > 
> > > > and there browsing up and down is annoying.
> > > > But if you feel strongly we can make the TC decide.
> > > At least I am less browsing from the web browser.
> > > The two common cases I came across are,
> > > (a) either users read via pdf/html views or
> > > (b) developers editing them and find useful to see related things in one
> > directory.
> > >
> > > Lets start with directories and if TC has better suggestion, we can change.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

