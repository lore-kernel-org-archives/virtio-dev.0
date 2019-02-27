Return-Path: virtio-comment-return-680-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 27 Feb 2019 18:52:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190227185238.GM2602@work-vm>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <20190222115433.7160-4-dgilbert@redhat.com>
 <20190225165014.GE379@stefanha-x1.localdomain>
 <20190225184506.GF2710@work-vm>
 <20190227145652.22286c72.cohuck@redhat.com>
 <20190227170612.GE927@stefanha-x1.localdomain>
 <20190227183728.GL2602@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227183728.GL2602@work-vm>
Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v2 3/3] shared
 memory: Define mmio registers
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sebastien.boeuf@intel.com
Cc: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

In discussions with Sebastien (cc'd) who is actually trying to use the
mmio definition, there's two other changes:

  a) Change ShmId to ShmSel to be consistent with the other MMIO
registers
  b) Make SHMBaseLow & High be read-only by the driver and be set by
the device/VMM - i.e. like the proposed CCW setup, in the MMIO setup
it becomes the VMMs problem to chose the GPA rather than the guests.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

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

