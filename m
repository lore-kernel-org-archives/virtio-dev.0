Return-Path: <mst@redhat.com>
Date: Wed, 20 Apr 2022 11:33:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH] fixupdiff: escape ^ caret
Message-ID: <20220420100135-mutt-send-email-mst@kernel.org>
References: <20220419163024.134007-1-mst@redhat.com>
 <87wnfj7w0v.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87wnfj7w0v.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 20, 2022 at 02:57:04PM +0200, Cornelia Huck wrote:
> On Tue, Apr 19 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > Since commit:
> >
> > commit 1e30753d53d222fbe955f0643583d756105d557e
> > Author: Jan Kiszka <jan.kiszka@siemens.com>
> > Date:   Fri Oct 11 13:43:41 2019 +0200
> >
> >     Fix ^= in example code
> >
> >     Trying to escaping ^ here only leaves the backslash in the output.
> >
> >     Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > we have plain ^ inside listing. Escape it with \ but only
> > if not already escaped (as output of diff with old source will be).
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  fixupdiff.pl | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Thanks, pushed as an editorial update.

Sounds good! OK let me compile this all, upload and we can
get the ball rolling with the 1st vote.

-- 
MST

