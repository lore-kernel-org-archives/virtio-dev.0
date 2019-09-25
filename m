Return-Path: virtio-dev-return-6167-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 924DD985E0E
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Sep 2019 10:15:01 +0000 (UTC)
Date: Wed, 25 Sep 2019 06:14:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190925055102-mutt-send-email-mst@kernel.org>
References: <1569296893-26006-1-git-send-email-yang.huang@intel.com>
 <1569296893-26006-2-git-send-email-yang.huang@intel.com>
 <20190924073457-mutt-send-email-mst@kernel.org>
 <0B92A36466FABC4D99BAF0BDB1FA8BBC41590D15@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0B92A36466FABC4D99BAF0BDB1FA8BBC41590D15@shsmsx102.ccr.corp.intel.com>
Subject: [virtio-dev] Re: [PATCH v5] Add virtio rpmb device specification
To: "Huang, Yang" <yang.huang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "Zhu, Bing" <bing.zhu@intel.com>, "Winkler, Tomas" <tomas.winkler@intel.com>, "Fang, Peter" <peter.fang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 25, 2019 at 02:57:00AM +0000, Huang, Yang wrote:
> 
> > > v4 -> v5:
> > > 1. Add description on the mapping between block_count and virtio buffers.
> > > 2. Update "Driver Requirements: Device Operation".
> > >
> > > v3 -> v4:
> > > 1. Remove multiple RPMB targets.
> > > 2. Remove NVMe RPMB.
> > > 3. typos fix.
> > > 4. Some wording changes for better understanding.
> > > 5. Add conformance.
> > 
> > 
> > OK I posted some minor comments below.
> > 
> > But I think this needs to answer a bigger question: fundamentally how is this
> > device going to work in presence of snapshots and VM migration?
> > 
> > I will post some ideas shortly.
> > 
> 
> I think there should be a one one map of each VM and the device.
> The device may emulate the RPMB to a file.
> If there are N VMs, there should be N RPMB files. The RPMB files are isolated each other.
> 
> (...)
> 
> > > diff --git a/introduction.tex b/introduction.tex index
> > > c96acf9..b304777 100644
> > > --- a/introduction.tex
> > > +++ b/introduction.tex
> > > @@ -60,6 +60,12 @@ \section{Normative References}\label{sec:Normative
> > References}
> > >  	\phantomsection\label{intro:SCSI MMC}\textbf{[SCSI MMC]} &
> > >          SCSI Multimedia Commands,
> > >
> > > \newline\url{http://www.t10.org/cgi-bin/ac.pl?t=f&f=mmc6r00.pdf}\\
> > > +        \phantomsection\label{intro:eMMC}\textbf{[eMMC]} &
> > > +        eMMC Electrical Standard (5.1),
> > > +        \newline\url{https://www.jedec.org/standards-documents/docs/jesd84-
> > b51}\\
> > > +        \phantomsection\label{intro:UFS}\textbf{[UFS]} &
> > > +        UNIVERSAL FLASH STORAGE (UFS), Version 3.0,
> > > +
> > > + \newline\url{https://www.jedec.org/standards-documents/docs/jesd220c
> > > + }\\
> > 
> > I have trouble justifying layout out more than $300 for this.
> > Do we need the latest version? Earlier ones are free.
> > E.g. for eMMC:
> > http://www.jedec.org/sites/default/files/docs/JESD84-B51.pdf
> > 
> > And for UFS:
> > https://www.jedec.org/sites/default/files/docs/JESD220C.pdf
> 
> 
> UFS 2.1, eMMC 4.51, 5.0 are all OK.
> The latest version has published for 3+ years.
> Register JEDEC and then free to download: https://www.jedec.org/user/register
> Please let me know if you still cannot download them. Thanks.

So eMMC 5.1 revision JESD84-B51A at
https://www.jedec.org/standards-documents/docs/jesd84-b51
from Jan 2019 is not freely available.

An earlier version JESD84-B51 from February 2015 at
http://www.jedec.org/sites/default/files/docs/JESD84-B51.pdf
is freely available.

How about we decide on one spec version and refer to that?
E.g. just UFS or just eMMC?


> 
> > You should also mention the code I think: JESD84-B51 and JESD220C since this is
> > how you find them on jedec site - in case they move things around.
> 
> Sure.
> 
> (...)
> 
> > > +\devicenormative{\paragraph}{Device Operation: Request Queue}{Device
> > > +Types / RPMB Device / Device Operation / Device Operation: Request
> > > +Queue}
> > > +
> > > +The device MUST parse the request from the request queue and emulate
> > > +the behaviors described in paragraph
> > > +6.6.22 of \hyperref[intro:eMMC]{eMMC} or 12.4 of
> > \hyperref[intro:UFS]{UFS}:
> > 
> > Either/or? How does user know which one should apply?
> 
> I think anyone is OK. Because the two are compatible with each other in most contents under JEDEC standard.
> But for eMMC, it's easier to understand.
> Keeping only eMMC is also okay. What do you think?


Fine by me.

> 
> > > +
> > > +\begin{description}
> > > +
> > > +\item[VIRTIO_RPMB_REQ_PROGRAM_KEY] If block count has not been set to
> > 1
> > > +   then VIRTIO_RPMB_RES_GENERAL_FAILURE is responded. If the
> > programming of
> > > +   authentication key fails then the returned result is
> > VIRTIO_RPMB_RES_WRITE_FAILURE.
> > > +   If some other error occurs then returned result is
> > VIRTIO_RPMB_RES_GENERAL_FAILURE.
> > > +   The \field{req_resp} value VIRTIO_RPMB_RESP_PROGRAM_KEY
> > corresponds to
> > > +   the key programming request.
> > > +
> > > +   If VIRTIO_RPMB_REQ_RESULT_READ is requested, the device returns the
> > RPMB frame
> > > +   with the response (VIRTIO_RPMB_RESP_PROGRAM_KEY), the calculated
> > MAC and the result.
> > > +
> > > +\item[VIRTIO_RPMB_REQ_GET_WRITE_COUNTE] If the authentication key is
> > > +not yet
> > 
> > COUNTE or COUNTER?
> 
> Will update it.  Thanks.
> 
> 
> > > +   programmed then VIRTIO_RPMB_RES_NO_AUTH_KEY is returned in
> > \field{result}.
> > > +   If block count has not been set to 1 then
> > VIRTIO_RPMB_RES_GENERAL_FAILURE
> > > +   SHOULD be responded.
> > 
> > see below about RFC2119 keywords, here and elsewhere.
> >
> > > +
> > > +   The device returns the RPMB frame with the response
> > (VIRTIO_RPMB_RESP_GET_COUNTER),
> > > +   the writer counter, a copy of the nonce received in the request, the
> > calculated
> > > +   MAC and the result.
> > > +
> > > +\item[VIRTIO_RPMB_REQ_DATA_WRITE] If the authentication key is not yet
> > programmed
> > > +   then VIRTIO_RPMB_RES_NO_AUTH_KEY is returned in \field{result}. If
> > block count
> > > +   is zero or greater than \field{max_wr_cnt} then
> > VIRTIO_RPMB_RES_GENERAL_FAILURE
> > > +   MUST be responded. The device MUST check whether the write counter has
> > expired.
> > > +   If the write counter is expired then sets the \field{result} to
> > > +   VIRTIO_RPMB_RES_WRITE_COUNTER_EXPIRED. If there is an error in the
> > address
> > > +   (out of range) then the \field{result} is set to
> > VIRTIO_RPMB_RES_ADDR_FAILURE.
> > > +   The device MUST calculate the MAC taking authentication key and frame as
> > input,
> > > +   and compares
> > 
> > and compare
> 
> Thanks.
> 
> 
> > > this with the MAC in the request. If the two MAC’s are different
> > > +   then VIRTIO_RPMB_RES_AUTH_FAILURE is returned.
> > > +
> > > +   If the writer counter in the request is different from the one maintained
> > > +   by the device then VIRTIO_RPMB_RES_COUNT_FAILURE is returned in
> > \field{result}.
> > > +   If the MAC and write counter comparisons are successful then the write
> > request
> > > +   is considered to be authenticated. The data from the request are written to
> > the
> > > +   address indicated in the request and the write counter is incremented by 1.
> > > +   If the write fails then the returned result is
> > VIRTIO_RPMB_RES_WRITE_FAILURE.
> > > +   If some other error occurs during the write procedure then the returned
> > result
> > > +   is VIRTIO_RPMB_RES_GENERAL_FAILURE.
> > > +
> > > +   If VIRTIO_RPMB_REQ_RESULT_READ is requested, the device returns the
> > RPMB data
> > > +   frame with the response (VIRTIO_RPMB_RESP_DATA_WRITE), the
> > incremented counter value,
> > > +   the data address, the calculated MAC and the result.
> > > +
> > > +\item[VIRTIO_RPMB_REQ_DATA_READ] If the authentication key is not yet
> > programmed
> > > +   then VIRTIO_RPMB_RES_NO_AUTH_KEY is returned in \field{result}. If
> > block count
> > > +   has not been set to 1 then VIRTIO_RPMB_RES_GENERAL_FAILURE MUST be
> > responded.
> > > +   If there is an error in the address (out of range) then the \field{result} is
> > > +   set to VIRTIO_RPMB_RES_ADDR_FAILURE. If data fetch from addressed
> > location inside
> > > +   device fails then the returned result is VIRTIO_RPMB_RES_READ_FAILURE.
> > If some
> > > +   other error occurs during the read procedure then the returned result is
> > > +   VIRTIO_RPMB_RES_GENERAL_FAILURE.
> > > +
> > > +   The device returns the RPMB frame with the response
> > (VIRTIO_RPMB_RESP_DATA_READ),
> > > +   the block count, a copy of the nonce received in the request, the address,
> > > +   the data, the calculated MAC and the result.
> > > +
> > > +\item[VIRTIO_RPMB_REQ_RESULT_READ] It is used following with
> > > +   VIRTIO_RPMB_REQ_PROGRAM_KEY or VIRTIO_RPMB_REQ_DATA_WRITE
> > request types for
> > > +   returned result in one or multiple RPMB frames. If it's not requested, the
> > device
> > > +   will not return result frame to the driver. If block count has not been set to
> > > +   1 of VIRTIO_RPMB_REQ_RESULT_READ request, then
> > VIRTIO_RPMB_RES_GENERAL_FAILURE
> > > +   SHALL be indicated.
> > 
> > Please copy normative statements to the normative section.
> > And rewrite text outside normative sections avoiding RFC2119 keywords.
> > 
> > E.g.  "device indicates VIRTIO_RPMB_RES_GENERAL_FAILURE" instead of
> > "VIRTIO_RPMB_RES_GENERAL_FAILURE SHALL be indicated".
>  
> But this section is already under normative section:
> \devicenormative{\paragraph}{Device Operation: Request Queue}{Device Types / RPMB Device / Device Operation / Device Operation: Request Queue}
> 
> Actually, all this section is normative.
> Can I change all statements to normative statements?
> E.g. 
> " If block count has not been set to 1 then VIRTIO_RPMB_RES_GENERAL_FAILURE is responded. "  ->
> " If block count has not been set to 1 then VIRTIO_RPMB_RES_GENERAL_FAILURE SHOULD be responded. "
> 


if you put everything in a normative section then you are not writing
enough prose. Pls take a look at how older devices such as the network
device are documented. You write out general description
in a non normative section, then a short list of
requirements in the normative one.

> 
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

