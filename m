Return-Path: <virtio-comment-return-3746-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 9 Jan 2023 14:14:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230109140825-mutt-send-email-mst@kernel.org>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-2-parav@nvidia.com>
 <20230109083745-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814FCB63E60BE7F5985A15DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54814FCB63E60BE7F5985A15DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v1 01/20] virtio-network: Maintain network device spec in
 separate directory
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 09, 2023 at 02:12:36PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, January 9, 2023 8:43 AM
> > 
> > I found another issue with this. Currently for redline diff generation
> > we use latexpand. Using a flat expanded file has lots of benefits, in
> > particular latexdiff is sometimes fragile as it is, with a flat file
> > one can at least see the input it gets.
> > 
> > We should either stick with \\input or more work is needed on
> > these scripts. Besides, we are already using \\input and I like
> > consistency.
> > 
> > So my preference is \\input for now.
> \\input doesn't support reading from the directory.

I just tested this and it seems to work fine:

\input{sub/file.tex}

what is the issue that you see?

I think I prefer \\input as it's easier to understand.

-- 
MST


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

