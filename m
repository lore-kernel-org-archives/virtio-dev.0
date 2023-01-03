Return-Path: <virtio-comment-return-3664-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 3 Jan 2023 11:19:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230103111801-mutt-send-email-mst@kernel.org>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230103054425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EDF2A7DE69145E93ECDEDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103091842-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2990D83282101967A8CDCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230103104223-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AAC2F0B95074EE0CFA08DCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AAC2F0B95074EE0CFA08DCF49@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v1 00/20] Split device spec to its individual files
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 03, 2023 at 04:04:11PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 3, 2023 10:44 AM
> 
> 
> > > I was writing up reply to other thread at the moment.
> > > But lets continue here since you ask.
> > > I don't have a strong opinion, but I find directories neat.
> > > This is because we have many devices spec files, conformance files and it's
> > expected to grow.
> > > I have transports directory and place code in there.
> > > Since latex spec doesn't have good way to include and refer sub section, we
> > have many files.
> > > 19 devices * 3 spec files + 3 transports * 3 spec files.
> > >
> > > And once spec is in its own directory, things should be self-sufficient.
> > > Only touch points will be in common areas which should be less frequent.
> > > WDYT?
> > 
> > Yea I know. It's just that one of the ways we publish is a directory in a web
> > browser 
> Do you mean browsing https://github.com/oasis-tcs/virtio-spec/ in a web browser?

No, the one at oasis:

https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/tex/

this is technically the authoritative one.


> > and there browsing up and down is annoying.
> > But if you feel strongly we can make the TC decide.
> At least I am less browsing from the web browser.
> The two common cases I came across are, 
> (a) either users read via pdf/html views or 
> (b) developers editing them and find useful to see related things in one directory.
> 
> Lets start with directories and if TC has better suggestion, we can change.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

