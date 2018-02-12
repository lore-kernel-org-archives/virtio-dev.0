Return-Path: virtio-return-2884-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 12 Feb 2018 14:03:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212140321.38725bda.cohuck@redhat.com>
In-Reply-To: <20180209220411-mutt-send-email-mst@kernel.org>
References: <1518206354-29610-1-git-send-email-pasic@linux.vnet.ibm.com>
	<20180209220411-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH 0/2] two versioning related changes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 9 Feb 2018 22:43:23 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 09, 2018 at 08:59:12PM +0100, Halil Pasic wrote:
> > Regarding patch #1 please see also:
> > https://lists.oasis-open.org/archives/virtio/201802/msg00018.html  
> 
> Fine by me. Can you please open an issue to track it?
> This makes it easier for me to start voting.
> 
> If you would rather use github issues,
> that'd be great. There seem to be easy tools
> to work with their API, e.g.
> http://search.cpan.org/~fayland/Net-GitHub-0.93/lib/Net/GitHub/V3/Issues.pm
> 
> We need to come up with a schema to keep the following info in github:
> - what is the issue title/short description
> - which version fixes the issue?
> - what is the proposed spec change?
> 
> and then send a script that can get an issue # and
> print that, similar to virtio-jira.pl in virtio-admin.

I'd vote (heh) to just use jira for now. Especially as I'd like to get
the big batch of the packed ring updates out of the way before we start
to tweak our tooling...

> 
> Help with that is very welcome but if you'd rather not you
> can just use jira for now.
> Pls remember to set fixed in to 1.1 and environment to
> reporter name and email (yourself).
> 
> 
> > Halil Pasic (2):
> >   ccw: be more precise the semantic of revision 1
> >   introduction: simplify the designation of legacy
> > 
> >  content.tex      |    2 +-
> >  introduction.tex |    4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)  


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

