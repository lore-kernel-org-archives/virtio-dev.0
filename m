Return-Path: virtio-dev-return-7617-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 133B7985E71
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Jul 2020 14:42:03 +0000 (UTC)
Date: Fri, 24 Jul 2020 10:41:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200724103627-mutt-send-email-mst@kernel.org>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com>
 <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200717092635.GB128195@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Nikos Dragazis <ndragazis@arrikto.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 17, 2020 at 10:26:35AM +0100, Stefan Hajnoczi wrote:
> > > +The following additional resources exist:
> > > +\begin{description}
> > > +  \item[Doorbells] The driver signals the vhost-user master through doorbells.  The signal does not carry any data, it is purely an event.
> > > +  \item[Notifications] The vhost-user master signals the driver for events besides virtqueue activity and configuration changes by sending notifications.
> > 
> > What is the difference between a doorbell and a notification?
> 
> Doorbells allow the driver to signal the device (i.e. device hardware
> registers that the driver writes to).
> 
> Notifications allow the driver to be signalled by the device (i.e. MSI-X
> interrupts that the driver handles).
> 
> The more abstract "doorbell" and "notification" terms are used instead
> of hardware registers and interrupts because transports other than PCI
> may want to support these features too.

I think notification and doorbell are a bit too generic of a name.

What we have is:
available buffer notifications, used buffer
notifications, configuration change notifications.


So how about XXX notifications for both of these things?
Where XXX explains what is the reason for triggering each
type of notification.

It says "besides virtqueue activity and configuration changes" -
what exactly is there?



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

