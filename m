Return-Path: virtio-return-3042-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1522168507-58698-1-git-send-email-mst@redhat.com>
 <94d79449-4d96-82b5-f046-f5bf6c47a7bb@linux.vnet.ibm.com>
 <20180329012805-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 02:11:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180329012805-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e2d7b3fe-2fa7-888a-6dcc-947fe50f6349@linux.vnet.ibm.com>
Subject: Re: [virtio] on spec clarifications
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/29/2018 12:30 AM, Michael S. Tsirkin wrote:
> Halil, 
> in the past you mentioned that you see some parts of the specification
> as unclear.
> 
> Will you have the time to look into this and send patches, or even just
> open github issues?
> 
> I'd like us to start looking at wrapping up the next spec version.
> 

There are a couple of I would have preferred done differently. Yet
my estimate regarding the pain/gain ratio for fixing most of the things
I dislike tells me: careful much pain and little gain. I'm a terrible
writer, and that does not make things easier.

I intend cook up some patches for the smaller things (the notifications
terminology, and AFAIR there was some stuff I noticed while reviewing packed)
this week. 

I was also pondering about the structure and what guarantees does
the specification provide for the correct implementations (e.g. interoperability
with any other correct implementation). I'm not sure I'm willing to
to muster the effort to try to improve these aspects. If I will probably
start with an RFC summarizing the issues and some ideas on what can be done.
Anyway I don't see this block as something that should delay the next
release.

Regards,
Halil




---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

