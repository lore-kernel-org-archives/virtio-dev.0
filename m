Return-Path: virtio-dev-return-5331-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F2A8985B33
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Jan 2019 08:32:11 +0000 (UTC)
Message-ID: <5C3D9BD8.2020409@intel.com>
Date: Tue, 15 Jan 2019 16:37:44 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com> <1542104867-11143-2-git-send-email-wei.w.wang@intel.com> <20190114134147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190114134147-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v1 1/2] content/virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/15/2019 02:58 AM, Michael S. Tsirkin wrote:
> On Tue, Nov 13, 2018 at 06:27:46PM +0800, Wei Wang wrote:
>
>   
> +\field{num_pages} and \field{actual} are always available.
> +
> +\field{free_page_report_cmd_id} is available if
> +VIRTIO_BALLON_F_FREE_PAGE_HINT negotiated.
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Traditional Memory Balloon Device / Device configuration layout}
> +
> +The device MUST NOT set \field{free_page_report_cmd_id} to a value
> +between \field{VIRTIO_BALLOON_CMD_ID_DONE} and
> +\field{VIRTIO_BALLOON_CMD_ID_MIN} exclusive.
> Exclusive is confusing since you can include one edge or
> both.
>
> Let's write it up positively. So the only legal values are
> VIRTIO_BALLOON_CMD_ID_MIN to VIRTIO_BALLOON_CMD_ID_MAX
> inclusive or VIRTIO_BALLOON_CMD_ID_STOP?

OK, plan to change it:

The device MUST set a legal value to \field{free_page_report_cmd_id}:
a value between \field{VIRTIO_BALLOON_CMD_ID_MIN} and
\field{VIRTIO_BALLOON_CMD_ID_MAX} inclusive,
\field{VIRTIO_BALLOON_CMD_ID_STOP}, or
\field{VIRTIO_BALLOON_CMD_ID_DONE}.



>> +
>>   \subparagraph{Legacy Interface: Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device
>>   configuration layout / Legacy Interface: Device configuration layout}
>>   When using the legacy interface, transitional devices and drivers
>> @@ -4448,8 +4469,20 @@ The device initialization process is outlined below:
>>     \item DRIVER_OK is set: device operation begins.
>>     \item Notify the device about the stats virtqueue buffer.
>>     \end{enumerate}
>> +
>> +\item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is
>> +  negotiated:
>> +  \begin{enumerate}
>> +  \item Identify the free page virtqueue.
>> +  \item Set \field{free_page_report_cmd_id} to
>> +    \field{VIRTIO_BALLOON_CMD_ID_MIN}.
> Does driver does it or the device?
> And does it have to be MIN? Why?
>
> Should not driver *read* the ID instead?

Yes, the device sets the value and the driver reads it. Probably not 
necessarily have to be MIN.
Plan to change:

\item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is
   negotiated:
   \begin{enumerate}
   \item Identify the free page virtqueue.
   \item Set \field{free_page_report_cmd_id} to a legal value.
   \end{enumerate}



>
>> +  \item Register a notifier with an external component (e.g. a live
>> +        migration agent) who will request for the free page reporting
>> +        from the driver.
> Spec only operates in terms of driver and device.
> I don't know what does above mean in these terms
> but please restate it accordingly.
> No notifiers live migration agents and external (to what?) components please.

OK, removed this part.

>> +\item The driver reads \field{free_page_report_cmd_id}: if it is not
>> +  \field{VIRTIO_BALLOON_CMD_ID_STOP},
>> +  \field{VIRTIO_BALLOON_CMD_ID_DONE}, and different from the value it
>> +  read last time, start free page reporting as follows:
>> +  \begin{enumerate}
>> +  \item Write the received \field{free_page_report_cmd_id} to a
>> +    buffer and add it to the free page virtqueue to indicate the start
>> +    of the reporting.
>> +  \item Collect free pages and write each page address into an entry
>> +    of the virtqueue.
> Spec does not define terms such as entry for virtqueue or writing
> into virtqueue.
>
> What you mean is add each page as an input buffer to the
> virtqueue I think?
>
>
> Also are there any alignment assumptions? What does "page" mean here
> generally? A size aligned physically contigious region of free memory?
>

OK, thanks for your suggestions.

Here is the rewording (changed page to memory):

\begin{enumerate}
\item The device updates \field{free_page_report_cmd_id}: if it has
   reached \field{VIRTIO_BALLOON_CMD_ID_MAX}, resets it to
   \field{VIRTIO_BALLOON_CMD_ID_MIN}. Otherwise, increments it by 1.
\item The device sends a configuration change notification to the
   driver.
\item The driver reads \field{free_page_report_cmd_id}: if it is not
   \field{VIRTIO_BALLOON_CMD_ID_STOP},
   \field{VIRTIO_BALLOON_CMD_ID_DONE}, and different from the value it
   read last time, start free page reporting as follows:
   \begin{enumerate}
   \item Write the received \field{free_page_report_cmd_id} to a
     buffer from the free page virtqueue.
   \item Write addresses of guest free memory to buffers from the free
     page virtqueue.
   \item Write \field{VIRTIO_BALLOON_CMD_ID_STOP} to a buffer from the
     free page virtqueue, which signifies that the guest free memory
     reporting is complete.
   \end{enumerate}
     A driver to device notification is sent in the above steps after
     writing a buffer from the free page virtqueue if the notification
     is not suppressed.
\item The device processes available buffers from the virtqueue and
   stops the processing after it reads a buffer which stores
   \field{VIRTIO_BALLOON_CMD_ID_STOP}.
\end{enumerate}

A request to actively stop the free page reporting proceeds as
follows:

\begin{enumerate}
\item The device sets \field{free_page_report_cmd_id} to
   \field{VIRTIO_BALLOON_CMD_ID_STOP}, followed by a configuration
   change notification to the driver if not suppressed.
\item The driver reads \field{free_page_report_cmd_id} and identifies
   that it is \field{VIRTIO_BALLOON_CMD_ID_STOP}, then it stops
   adding buffers to the free page virtqueue.
\item The driver writes \field{VIRTIO_BALLOON_CMD_ID_STOP} into a
   buffer from virtqueue.
\item The device stops processing the available buffers from the
   virtqueue after receiving the buffer that stores
   \field{VIRTIO_BALLOON_CMD_ID_STOP}.
\end{enumerate}

The device can end the free page reporting by setting
\field{free_page_report_cmd_id} to \field{VIRTIO_BALLOON_CMD_ID_DONE},
followed by a configuration notification to the driver.



>> +
>> +The driver SHOULD add the addresses of free pages as input buffers
>> +to the virtqueue.
>> +
>> +The driver SHOULD add the buffer that stores the value of
>> +\field{free_page_report_cmd_id} or \field{VIRTIO_BALLOON_CMD_ID_STOP}
>> +as an output buffer to the virtqueue.
>> +
>> +The driver SHOULD use different buffers to send the the value of
>> +\field{free_page_report_cmd_id} and
>> +\field{VIRTIO_BALLOON_CMD_ID_STOP} to avoid one being overwritten by
>> +another when the device has a delay in reading the command.
>> +
>> +The driver SHOULD release all the collected free pages after receiving
>> +\field{VIRTIO_BALLOON_CMD_ID_DONE}.
>> +
>>   \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
>>   
>>   The virtio SCSI host device groups together one or more virtual
>> -- 
>> 2.7.4

The above looks like implementation related, I also plan to remove them.

Thanks for your comments!

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

