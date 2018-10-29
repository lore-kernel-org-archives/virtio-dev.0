Return-Path: virtio-dev-return-4917-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7A04985A5C
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Oct 2018 21:49:03 +0000 (UTC)
Date: Mon, 29 Oct 2018 22:49:00 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20181029214900.hr6r6gkubfmgxr7f@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] Minutes from Virtio BoF at KVM Forum
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

I took some notes during the BoF. Please correct me if I got something
wrong or missed something:

* Participants liked idea of weekly(?) "snapshots"/drafts of the VIRTIO spec
  in PDF format that are also versioned in some way
* If there is interest in a regular VIRTIO call or IRC meeting let MST
  know. There is also a "DPDK-Virtio" call which happens monthly and is
  currently used both to discuss implementation progress and questions
  about Virtio in general. Maybe we could just rename it to "Virtio
  call"?.
* Virtio 1.1 could be released now if someone states that they like it
  as is. Otherwise we will fix some more things and do it in a few
  weeks.
* A question was raised how to get a new feature into the spec. MST
  explained the process. Request a feature bit via a
  patch to the mailing list, create github issue, discuss, ask for
  ballot. 
* someone from OpenSynergy reported that Virtio is used heavily in the
  automotive industry and that there is work being done on virtio-audio
* status update on vDPA by Steve
* status update on failover by Sameeh
* brief discussion about what would be needed to save more pci
  transactions with packed virtqueues for hardware implementations. I
  don't remember many details, agreed to have further discussion on
  mailing list.


regards,
Jens 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

