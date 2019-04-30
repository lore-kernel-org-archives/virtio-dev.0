Return-Path: virtio-dev-return-5705-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A55F5985B8C
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Apr 2019 12:56:03 +0000 (UTC)
Date: Tue, 30 Apr 2019 08:55:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190430084722-mutt-send-email-mst@kernel.org>
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Marco Martinelli - 13Byte srl <marco@13byte.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Apr 29, 2019 at 07:39:17PM +0200, Marco Martinelli - 13Byte srl wrote:
> 
> Il 29/04/19 15:47, Stefan Hajnoczi ha scritto:
> > On Mon, Apr 29, 2019 at 12:22:41AM +0200, Marco Martinelli - 13Byte srl wrote:
> > > Hi everyone,
> > > 
> > > my name is Marco, from Italy. I'm a developer that recently got an interest
> > > in improving the current situation of audio in qemu/kvm.
> > > 
> > > I've been working successfully on multiple patches for Scream
> > > (https://github.com/duncanthrax/scream
> > > <https://github.com/duncanthrax/scream> ), a virtual sound card for
> > > Microsoft Windows, that allow to transfer audio from a Windows VM to a Linux
> > > host. The project initially supported only stereo sound over the network,
> > > but with my patches now it support up to 7.1 surround and it can transfer
> > > the audio samples using shared memory between the VM and the host (based on
> > > IVSHMEM), for lower latency.
> > > 
> > > Now that was a good project, but I want to do more. I dream of an
> > > virtio-audio device that can handle multichannel audio in and out of the VM,
> > > to be used with more guest OSs than just Windows.
> > > 
> > > I know I have a long way to go to reach this goal, but I'm motivated and
> > > willing to learn. I admit I don't have much experience with the qemu source
> > > code or the virtio source code, but I learn fast.
> > > 
> > > My work on Scream was to familiarize with Windows driver development,
> > > VM-to-host communication and low latency audio processing.
> > > My idea is to start with small self-contained projects to familiarize with
> > > the source codes of the various projects and gain the experience I lack,
> > > then moving on the real virtio-audio project.
> > > This way I can both obtain more knowledge on the subjects and help the open
> > > source community that over the years have done so much for many.
> > > 
> > > As we speak I'm reading the VirtIO documentation, where I've found out that
> > > I need to require a new device number for this project (Appendix B.3). So,
> > > here I am.
> > > 
> > > I'm not quite sure if this email is enough to obtain a new number or if I
> > > need to follow some process I'm not aware of. In the meantime I'm using the
> > > device number 65535 as documented in the specifications.
> > > 
> > > Looking around I've seen there is a recent issue on GitHub to reserve a
> > > virtio-audio device id, and a patch was submitter to assign id 25 to audio
> > > devices.
> > Is this the same virtio-audio device type that you want to work on or is
> > this an independent effort from another author?  It seems important to
> > contact the author (if it's not you) to find out the status of their
> > device and see what work can be shared.
> 
> It is not my device, but I don't think there is any work behind this either.
> 
> The number 25 I was referring to comes from this message
> https://lists.oasis-open.org/archives/virtio/201903/msg00074.html
> 
> It seems to me that this number was reserved for a virtio-audio device, but
> not a specific one. Maybe I'm misinterpreting that message.

I think it's this one:

https://projectacrn.org/

given this project started using an ID without talking to anyone (which
almost led to a conflict - it only didn't because Paolo was super
diligent), it's a good idea to ask them whether they will be willing to
be more careful and at least reserve feature bits through the TC before
using them.

If not then we should rename this one to audio device (legacy)
and reserve an ID for 

Could you reach out to them?


> > 
> > > I'm not sure how this works, is that number already assigned and I should
> > > use that or should I get a new one?
> > > 
> > > For last, I have a question to clear the things up for me. It is my
> > > understanding that in this mailing list you discuss about the
> > > specifications, not the actual code. What's the usual process when writing a
> > > new virtio device?
> > > Should I start with writing the code and then document how it works or is it
> > > the opposite? Should I document it and have it approved and then implement
> > > the specifications?
> > > 
> > > I know that this may sound like a stupid question, but please be patient
> > > with me, it's my first time.
> > I suggest posting a draft specification for the new device type before
> > investing too much time in the implementation.
> > 
> > Then work on the code while the spec discussion is ongoing.  This way
> > you won't have to wait too long before implementation but you also won't
> > find that reviewers are asking for large changes after you completed
> > your work.
> I feared that would be the answer.
> As I stated I'm not familiar with most of the technologies involved. I don't
> know if I have the capabilities to write a draft of the specifications
> without first working on some code to clear things up.
> I'll try my best.

There are two other options for contributing which might be
easier for people not comfortable with writing specs:

1. If project acrn guys are willing to work with us
   in the future (meaning not making future interface changes
   without reserving a feature bit through the TC):
   - figure out their virtio-audio device interface, write
     compatible qemu device and guest driver implementations

2. if they are not willing
   - send a small patch just like
	https://lists.oasis-open.org/archives/virtio/201903/msg00074.html
     reserving a new id (+ renaming old one to legacy)
     then start hacking on your own as per option 1




> > Stefan
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

