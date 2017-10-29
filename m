Return-Path: virtio-dev-return-2632-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Sun, 29 Oct 2017 13:52:25 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20171029125225.lx4ezpkbvjjsjv3x@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] Virtio BoF minutes from KVM Forum 2017
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Virtio BoF minutes KVM Forum 2017

Attendees: Amnon Ilan, Maxime Coqueline, Vlad Yasevich, Malcolm Crossley,
	   David Vrabel, Ilya Lesokhin, Cunming Lian, Jens Freimann

Topics: packed ring layout with respect to hardware implementations

References:
https://lists.oasis-open.org/archives/virtio-dev/201702/msg00010.html
https://lists.oasis-open.org/archives/virtio-dev/201709/msg00013.html

Malcolm  Crossley, David Vrabel: 
- keep in mind not to only optimize for network with small frame sizes.
  Storage has much larger sizes
- is there really no cacheline ping pong, because we are overwriting the same
  cache line? 4 descs in one line, once we access two at the same time it will
  cause cache coherency, messages, no?
- interesting quirk, because we flip a bit, but intel doesn't support writing
  single bytes, it will always be a full dword. will that be a problem? 
- interesting to look into NVME protocols, it seems to solve some of the same
  problems hardware-wise
- vmware vmxnet3 has a separate data ring for when they have bigger amounts of
  data. not to copy, but still interesting

Steve: 
- is the _MORE flag from packed ring layout proposal still in use? what is it's meaning?  

Ilya: 
- you might have more completions than descriptors available
- partial descriptor chains are a problem for hardware because you might have
  to read a bunch of conscriptors twice 
- how would you do deal with a big buffer that cointains a large number of
  small packets with respect to completions?
- is one bit for completion enough? right now it means descriptor was actually
  used. how to we signal when it was completed?
- concerned about not being able to do scatter/gatter with the ring layout.
  Network drivers heavily using indirect buffers.  
- for a hardware implementation a completion ring is a very convenient form for
  some use cases, so we want an efficient implementation for them. If we had an
  inline descriptor then a completion ring is just a normal ring and we won't
  need another ring type.
- doesn't like the fact that we need to do a linear scan to find the length of
  a descriptor chain. It would be nice if we could have the length of the chain
  in the first descriptor (i.e. the number of chained descriptors, not the number
  of posted descriptors which can be deduced from the id field)


Vlad: 
- there were discussions about having a bigger descriptor. then we would
  have more space to put things like a vnet header into the descriptor. It would
  also mean less conflicts with accessing the same cache line. (descriptors already
  grew to 16 bytes, do we need more?)
- was playing around with the idea of different ring types for different devices
  e.g. scsi, net. starting with generic information then comes protocol
  specific data. Ilya agrees. length of descriptor would be flexibla by adding a
  descriptor length field.  

How to continue / TODOs:
 - do benchmarking with bigger frame sizes on fast enough NICs
 - turn prototype code into a RFC series (work in progress)
 - more people interested to join monthly meetings

Open questions:
- Do we need an (optional) completion ring?
- Is there a situation where 4 descriptors in a cache line is a problem because
  we access the same cache line, causing cache ping-pong?
- Interrupt suppression requires device to do a memory read after writing out
  descriptors?  Will that be too costly? Let driver write out index?


regards
Jens

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

