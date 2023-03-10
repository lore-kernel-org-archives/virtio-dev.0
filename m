Return-Path: <virtio-dev-return-11597-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C74EC6FD19
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 10:01:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C98FB33576
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 10:01:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1B16986723
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 10:01:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B4C51986718; Fri, 10 Mar 2023 10:01:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F428986719;
	Fri, 10 Mar 2023 10:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="339058951"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="339058951"
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801522912"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="801522912"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiEkcRsry+L3DNKrBwyZBAFOnp3SUiZd8ohMeP62t8LP7417N3fiLe/JlGH0caNgTiGpb/95gNkNpZY6Ww+Vu0yHcu/DS9lE53aytJOCfjk9EUCw8dZaYy/IBP0ACACfzNAfNWfPqvfuwwv6Myhp8d3kYQ/pYa8RvwKApgIkNv9T7Lvi/bkQ+km+FTAkhfNbObFQbAiZXdJwGjSzGGonkjkBbaA1HRBqk8yJGwMlRQCq/bB64QxBwr4xUiyY0SirOLRhUO2FC4HoPITN/4FsBWSNn3T/+p7KfeBecrzPoqrH6aOoSMOxWgWfGjwcAy7JWOFZCl3hl1zvnm8rO2VixA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cpthP5vs+4YgQ+NZqeQnkI/hmn8EQWfTVmoVrSGWxk=;
 b=jMVNgpKic7CBVVYw2yAlB1LjfEFowlO3pVLKtzFzQk+NmB8ww07dIaKVHvGkph3KMD3Pwq5sxVvQWB/iprcAH8eFSNxAJ3BrrgM8OuHIS988+Z3aIuRNDOjvLg3A6UcQXQsXpzHJ72A9fLpBqFF/O/w4I+p4+j12V9yUz58krzNT6h2jxiODShMiX29VGtfGQYTmeHl9EJ+HsWWFF8I8aFhrfe3zBlM5QqlN3ZA4jqT1zniCbikdYcZVG8sRccoWNK50kzujVyV3+5JQbIw3eg1KR9O7x/4RpdAL86V1+BQKmzSeF4Q9IyWMTbdvj/h5geEnFmmlMh7o11chY/M4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Message-ID: <d29e2191-7f71-2791-c848-fe38851537e7@intel.com>
Date: Sat, 11 Mar 2023 02:00:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>,
	<jasowang@redhat.com>, <cohuck@redhat.com>, <sgarzare@redhat.com>,
	<stefanha@redhat.com>, <nrupal.jani@intel.com>, <Piotr.Uminski@intel.com>,
	<hang.yuan@intel.com>, <virtio@lists.oasis-open.org>, <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, "Max
 Gurtovoy" <mgurtovoy@nvidia.com>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <f37a5993-1349-75ac-1928-beafa98fc068@intel.com>
 <20230310041226-mutt-send-email-mst@kernel.org>
From: Zhu Lingshan <lingshan.zhu@intel.com>
In-Reply-To: <20230310041226-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0046.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::15)
 To IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6443:EE_|SJ0PR11MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: b6883cbf-5052-45da-1105-08db214e6189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16bsXIx89ZR28l9qdH5SuOTv6LlgCizZvfJanx3cPhMC8Muv/kxrUDIpGQruEFRgtvZI7kFUss1PhKC67oUYZKRF1XU3vQH6eJSmA10n7myeC5+idfPBqSzLq2leoXR/K2KOUupFxqYvYaKCHw+ly5g9GRxzN/y8nV2u8oPTLT8Q82CLH1fBXJcJxvXOKJAZV66Lm+/aQevSs5NnIQsOd81dQxs7RsRggd+gWTAb+z8geBN9/NFGewNoQHLYYvz2yrJEpR4qTq6nBdwVCScJ+EDrV+b94Tx8yFk+jdtr4WTKHU65PY8K/7xbRBD6Oxroo/GtTywMPnRneUgFBwNSsUgNdpVtyHC3QukjoLJt50cMIjS1w63qhXn7gF8FK6P7jfOx31rtXaxa+FKHvQZhAaFcucgJV51FGyhyf4Kfsxvm7qZTx49EGDs1JFEnw9WTOYWF/3kYQfXiqyf02Q99HLsSiytfF+ZGSAt6XH6ra0AVMswJkDNJRZblzdzKIAKAEXu8gWqDoB3DLbGEevLZQlSKIFGWpZrs8SFmQ0d8VmM9RJP7qzE1JSB1Esrtp+feV6FqHrObuAejb8xvXvnysHSDFygIsC9ZmUEFb04iyKaB9ZLhnInfAWnboX40qKaDn/wB3teb51kxAan2ttCCB1bNJV7pIuxwGuJu9uC8lWJ1iCx2yPm0G6RisUfi1YKefjkHwGiBuA+fHpeZhzmdDv1cdMA4QiA7xz4XTnwA9iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6443.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199018)(66899018)(38100700002)(31686004)(54906003)(36756003)(86362001)(31696002)(82960400001)(186003)(26005)(478600001)(6512007)(53546011)(6506007)(83380400001)(6666004)(2616005)(6916009)(7416002)(316002)(6486002)(5660300002)(66476007)(4326008)(41300700001)(2906002)(8936002)(8676002)(30864003)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9qOGFiUjNjSWZieGdPTW5LQkhxUHNCTkJwNG5FdEVuSDVkWjArLzQ4eWlW?=
 =?utf-8?B?YUE5cytOUUNJdUx1aFFFcndEK0IxTGtVVWo2aVNnQXdxU3RsdCtJaGJySU5x?=
 =?utf-8?B?Sjc5c1ByOHQ2cnREOThaQUhIMnQ4WXNrVWJQNUMrU3JXNTBNeHRUeE5leEdH?=
 =?utf-8?B?MTBQVzhQL0FnQU1GR1UrY1Rzc2QrMElKbVFHbkdGUis5eWZRRTFKSm5ERk5l?=
 =?utf-8?B?eit3OWg5dGJURlFYM3RkaUltS25yMU1EeStwbUNPSEl4ZjNrZXRuVVh0dW5z?=
 =?utf-8?B?SkRZeU1WYTZpZWI3QXhiUTMyWlJBeTR5S1J4RFpmYXd2OTNuRzdDTXVTOEho?=
 =?utf-8?B?a1JjREllTEcyR2NuOFJ5STltbHl3MHpUVklsbW55cVFIdjFvNWRqdWFBckpD?=
 =?utf-8?B?OHZ3Z3lEb1NFUkhFb2ZCa0h0SkJWZDNKRVk2ZVVBb3BsTDRvS0s3emZHSzI5?=
 =?utf-8?B?Zlk3UGMvQTB6V200TzlNZklvdDZkS2JNUkdFZlAzbXNYdjBCQkVnM0Z2SzlW?=
 =?utf-8?B?QXRnNkNTQk1OT1RFRERUZllCbGFESFAxZUNNR1NkNDNCbHAxMWJ3OVVmc1NK?=
 =?utf-8?B?bFBQQjQ3K3NEUlMzUE8rejZuaGoyNHEzNy9GVjFwUm9FdnNtdVlLR01HTXdl?=
 =?utf-8?B?TUtLK1hMRlltV1pvNHc1QjZpcWlzYTJOMWRBb2FwMlVnN0x3UU1oYjQrcnZy?=
 =?utf-8?B?VXNPT0NhczliTWpQcjFQMUc5Tnc3TUZsaGhUZGYwMm1SR2oxc1NJNGxZRHZZ?=
 =?utf-8?B?Rk1NcjRBd3V3SSt6MjZ6aE5XQzRFMzdFSkszaWwxMG9hNHF3emt6czhaazd2?=
 =?utf-8?B?M0tTbXdwVU5XTzBGQUVMTXlTMG1WYzZOT1NnZ0NHTzJKbXJ2UlUvTHNBYjU4?=
 =?utf-8?B?dGNCMnpiZmU3YVoraDVOc0Y4REpQcE5wQzl5dVBBcUozU2ZkUkJQRTZ2dlZr?=
 =?utf-8?B?eFdwUytNZWxDeFQ1WHM2NFFBeG9JQldlWTJJRHhNZDlxQjcyWVdza09HbTF0?=
 =?utf-8?B?cTQ1bForQ2UydEoyeFd4MGxyTFhZTnV6clBrbjJtZGFldXE0RFdZMmhPVWt0?=
 =?utf-8?B?aGRvTkx4V29RRURjVlY3YXBzUXhqakh3M0d4WG52QUVrclVKWWN4VVg2ajB0?=
 =?utf-8?B?QXQ1dVJ2NEw0bkFBM2o5ZVZHQWt1U29tYlJUaG5ZYmRxRUhMTlRVdVl0a0VY?=
 =?utf-8?B?SWhzMVZZajdpbW1OSm9BQmRydkFYY2tmRktVTnNwd3JGYnVxVHEwbkxtZU1D?=
 =?utf-8?B?MG0xdVpuQ0JCd1BPc0VYeHVVNXpndlpmTGlFaVBQOVE4dk1mOEVKbVZqK3A2?=
 =?utf-8?B?blB5YVIrb3RvYm9ScmNMSm0zNmdtcnZNSXpiWXJNK0dMSnFrWGFqZTM1QnlM?=
 =?utf-8?B?ZUo1OGd3dzFOcTUyckptS3FVWTh2QXRrT3hhZm9JazNFOXd3WXU0RkIrOGVP?=
 =?utf-8?B?R0RwblRUdkJpVEJ6M2lzUkdwN1RaYko4U05PSFZEVHE2eXRJZUQ0VjBuaHRS?=
 =?utf-8?B?L1B4TkdnWW5wQ0ExS3pEZ2IrZHFpYU5WbmlueXdUT1JnTHBUamVXK3J1S2w2?=
 =?utf-8?B?TTBHZitCQlBNZEMwYXBhWTdPMkdGTmRFOTBLS0NBT09lUTVreG9qVTY3bXIw?=
 =?utf-8?B?UW5DZm9PejRUdnhITVRzMldkcnRSUE1zTk80M0M4MTVaMmxCZlo4dGFhRity?=
 =?utf-8?B?dkxYbFkxU1lvMTZseU44MTNPbGwrOHJCenNHUTJxa3lzMEdoR29BTUdJQUVl?=
 =?utf-8?B?ZFAwYTYwcE9wM1VFYnlYTGFhaFVtd2EyaHZOOFUwZXdkVFk5YVRrTEE5WVZS?=
 =?utf-8?B?WktBZ2xRWnN1aWVpTzlEYzczQXhPcjk5MXA4Y1Bmd1VvMXRmWDhUMVBYSjBR?=
 =?utf-8?B?MnBxZ05UcnR2bkw1MUNIbVI3QjF6bzA0ODRhVVQya3pIOGQ1ZjdFb1ZYUHZa?=
 =?utf-8?B?TnArNnQ1U2VMcTFmYlpidXgyZkRSRS9HRTM4WDl5RlJnMk1TSmF0OVlndVFB?=
 =?utf-8?B?Y09MQXJQcC9zUit3VEg5VmdnY2k4djdsaldweGFNdzdWODFicWM2ZGZjczFk?=
 =?utf-8?B?dlM1YzMxb081ME13d1Q3UXo1Mktrb1lvaU1Cc2tINHJibFlCdWwzODVXTVNO?=
 =?utf-8?Q?dwg3866F/SURHNtXZhgvrbuUo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6883cbf-5052-45da-1105-08db214e6189
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6443.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 10:01:13.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Zdpqw13KJSf4yzuRRCnd3Dn8+3iDLvGqrDHuYuRsSj+5Khyd+41W8e9WKeL9EjAkfETwL2zCEn1/KbEWaZ5eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5919
X-OriginatorOrg: intel.com
Subject: [virtio-dev] Re: [PATCH v10 09/10] admin: conformance clauses


On 3/10/23 17:13, Michael S. Tsirkin wrote:
> On Fri, Mar 10, 2023 at 05:10:48PM +0800, Zhu, Lingshan wrote:
>>
>> On 3/2/2023 9:05 PM, Michael S. Tsirkin wrote:
>>> Add conformance clauses for admin commands and admin virtqueues.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>    admin.tex | 216 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 215 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/admin.tex b/admin.tex
>>> index 1172054..6c4f79c 100644
>>> --- a/admin.tex
>>> +++ b/admin.tex
>>> @@ -251,6 +251,145 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>>>    supporting multiple group types, the list of supported commands
>>>    might differ between different group types.
>>> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>>> +
>>> +The device MUST validate \field{opcode}, \field{group_type} and
>>> +\field{group_member_id}, and if any of these has an invalid or
>>> +unsupported value, set \field{status} to
>>> +VIRTIO_ADMIN_STATUS_EINVAL and set \field{status_qualifier}
>>> +accordingly:
>>> +\begin{itemize}
>>> +\item if \field{group_type} is invalid, \field{status_qualifier}
>>> +	MUST be set to VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP;
>>> +\item otherwise, if \field{opcode} is invalid,
>>> +	\field{status_qualifier} MUST be set to
>>> +	VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE;
>>> +\item otherwise, if \field{group_member_id} is used by the
>>> +	specific command and is invalid, \field{status_qualifier} MUST be
>>> +	set to VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER.
>>> +\end{itemize}
>>> +
>>> +If a command completes successfully, the device MUST set
>>> +\field{status} to VIRTIO_ADMIN_STATUS_OK.
>>> +
>>> +If a command fails, the device MUST set
>>> +\field{status} to a value different from VIRTIO_ADMIN_STATUS_OK.
>>> +
>>> +If \field{status} is set to VIRTIO_ADMIN_STATUS_EINVAL, the
>>> +device state MUST NOT change, that is the command MUST NOT have
>>> +any side effects on the device, in particular the device MUST not
>>> +enter an error state as a result of this command.
>>> +
>>> +If a command fails, the device state generally SHOULD NOT change,
>>> +as far as possible.
>>> +
>>> +The device MAY enforce additional restrictions and dependencies on
>>> +opcodes used by the driver and MAY fail the command
>>> +VIRTIO_ADMIN_CMD_LIST_USE with \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
>>> +and \field{status_qualifier} set to VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD
>>> +if the list of commands used violate internal device dependencies.
>>> +
>>> +If the device supports multiple group types, commands for each group
>>> +type MUST operate independently of each other, in particular,
>>> +the device MAY return different results for VIRTIO_ADMIN_CMD_LIST_QUERY
>>> +for different group types.
>>> +
>>> +After reset, if the device supports a given group type
>>> +and before receiving VIRTIO_ADMIN_CMD_LIST_USE for this group type
>>> +the device MUST assume
>>> +that the list of legal commands used by the driver consists of
>>> +the two commands VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
>>> +
>>> +After completing VIRTIO_ADMIN_CMD_LIST_USE successfully,
>>> +the device MUST set the list of legal commands used by the driver
>>> +to the one supplied in \field{command_specific_data}.
>>> +
>>> +The device MUST set the list of legal commands used by the driver
>>> +to the one supplied in VIRTIO_ADMIN_CMD_LIST_USE.
>>> +
>>> +The device MUST validate commands against the list used by
>>> +the driver and MUST fail any commands not in the list with
>>> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
>>> +and \field{status_qualifier} set to
>>> +VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE.
>>> +
>>> +The list of supported commands MUST NOT shrink (but MAY expand):
>>> +after reporting a given command as supported through
>>> +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
>>> +as unsupported.  Further, after a given set of commands has been
>> Can the driver re-negotiate the command list through QUERY/USE
>> in flight rather than upon a reset? If not, shall forbid this explicitly?
>>> +used (via a successful VIRTIO_ADMIN_CMD_LIST_USE), then after a
>>> +device or system reset the device SHOULD complete successfully
>>> +any following calls to VIRTIO_ADMIN_CMD_LIST_USE with the same
>>> +list of commands; if this command VIRTIO_ADMIN_CMD_LIST_USE fails
>> I think this requires the device to remember what it had offered even
>> after a power-cycled reset,
> It just says always return the same.
>
>> shall we say: The device should always offer all
>> supported
>> commands in the list?
> I don't see what will it mean.
For example, a device can support more commands(even can be vendor 
specific commands) through a firmware upgrade,
then after a reset, it should report more supported commands in the list 
through QEURY,
so maybe not a good idea to report the same command set. The device 
should report all supported commands
after a reset.
>
>> Thanks,
>> Zhu Lingshan
>>> +after a device or system reset, the device MUST not fail it
>>> +solely because of the command list used.  Failure to do so would
>>> +interfere with resuming from suspend and error recovery.
>>> +
>>> +When processing a command with the SR-IOV group type,
>>> +if the device does not have an SR-IOV Extended Capability or
>>> +if \field{VF Enable} is clear
>>> +then the device MUST fail all commands with
>>> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
>>> +\field{status_qualifier} set to
>>> +VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP;
>>> +otherwise, if \field{group_member_id} is not
>>> +between $1$ and \field{NumVFs} inclusive,
>>> +the device MUST fail all commands with
>>> +\field{status} set to VIRTIO_ADMIN_STATUS_EINVAL and
>>> +\field{status_qualifier} set to
>>> +VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER;
>>> +\field{NumVFs}, \field{VF Migration Capable}  and
>>> +\field{VF Enable} refer to registers within the SR-IOV Extended
>>> +Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
>>> +
>>> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Device groups / Group administration commands}
>>> +
>>> +The driver MAY discover whether device supports a specific group type
>>> +by issuing VIRTIO_ADMIN_CMD_LIST_QUERY with the matching
>>> +\field{group_type}.
>>> +
>>> +The driver MUST issue VIRTIO_ADMIN_CMD_LIST_USE
>>> +and wait for it to be completed with status
>>> +VIRTIO_ADMIN_STATUS_OK before issuing any commands
>>> +(except for the initial VIRTIO_ADMIN_CMD_LIST_QUERY
>>> +and VIRTIO_ADMIN_CMD_LIST_USE).
>>> +
>>> +The driver SHOULD NOT set bits in device_admin_cmds
>>> +if it is not familiar with how the command opcode
>>> +is used, as dependencies between command opcodes might exist.
>>> +
>>> +The driver MUST NOT request (via VIRTIO_ADMIN_CMD_LIST_USE)
>>> +the use of any commands not previously reported as
>>> +supported for the same group type by VIRTIO_ADMIN_CMD_LIST_QUERY.
>>> +
>>> +The driver MUST NOT use any commands for a given group type
>>> +before sending VIRTIO_ADMIN_CMD_LIST_USE with the correct
>>> +list of command opcodes and group type.
>>> +
>>> +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
>>> +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
>>> +with respective bits cleared in \field{command_specific_data}.
>>> +
>>> +The driver MUST handle a command error with a reserved \field{status}
>>> +value in the same way as \field{status} set to VIRTIO_ADMIN_STATUS_EINVAL
>>> +(except possibly for different error reporting/diagnostic messages).
>>> +
>>> +The driver MUST handle a command error with a reserved
>>> +\field{status_qualifier} value in the same way as
>>> +\field{status_qualifier} set to
>>> +VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND (except possibly for
>>> +different error reporting/diagnostic messages).
>>> +
>>> +When sending commands with the SR-IOV group type,
>>> +the driver specify a value for \field{group_member_id}
>>> +between $1$ and \field{NumVFs} inclusive,
>>> +the driver MUST also make sure that as long as any such command
>>> +is outstanding, \field{VF Migration Capable} is clear and
>>> +\field{VF Enable} is set;
>>> +\field{NumVFs}, \field{VF Migration Capable}  and
>>> +\field{VF Enable} refer to registers within the SR-IOV Extended
>>> +Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
>>> +
>>>    \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>>>    An administration virtqueue of an owner device is used to submit
>>> @@ -323,4 +462,79 @@ \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Devic
>>>    of the specification are designed, new fields can be added to the
>>>    tail of a structure, with the driver/device using the full
>>>    structure without concern for versioning.
>>> ->>>>>>> 0edc690... admin: introduce virtio admin virtqueues
>>> +
>>> +\devicenormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
>>> +
>>> +The device MUST support device-readable and device-writeable buffers
>>> +shorter than described in this specification, by
>>> +\begin{enumerate}
>>> +\item acting as if any data that would be read outside the
>>> +device-readable buffers is set to zero, and
>>> +\item discarding data that would be written outside the
>>> +specified device-writeable buffers.
>>> +\end{enumerate}
>>> +
>>> +The device MUST support device-readable and device-writeable buffers
>>> +longer than described in this specification, by
>>> +\begin{enumerate}
>>> +\item ignoring any data in device-readable buffers outside
>>> +the expected length, and
>>> +\item only writing the expected structure to the device-writeable
>>> +buffers, ignoring any extra buffers, and reporting the
>>> +actual length of data written, in bytes,
>>> +as buffer used length.
>>> +\end{enumerate}
>>> +
>>> +The device SHOULD initialize the device-writeable buffer
>>> +up to the length of the structure described by this specification or
>>> +the length of the buffer supplied by the driver (even if the buffer is
>>> +all set to zero), whichever is shorter.
>>> +
>>> +The device MUST NOT fail a command solely because the buffers
>>> +provided are shorter or longer than described in this
>>> +specification.
>>> +
>>> +The device MUST initialize the device-writeable part of
>>> +\field{struct virtio_admin_cmd} that is a multiple of 64 bit in
>>> +size.
>>> +
>>> +The device MUST initialize \field{status} in \field{struct
>>> +virtio_admin_cmd}.
>>> +
>>> +The device MUST process commands on a given administration virtqueue
>>> +in the order in which they are queued.
>>> +
>>> +If multiple administration virtqueues have been configured,
>>> +device MAY process commands on distinct virtqueues with
>>> +no order constraints.
>>> +
>>> +\drivernormative{\paragraph}{Group administration commands}{Basic Facilities of a Virtio Device / Administration virtqueues}
>>> +
>>> +The driver MAY supply device-readable or device-writeable parts
>>> +of \field{struct virtio_admin_cmd} that are longer than described in
>>> +this specification.
>>> +
>>> +The driver SHOULD supply device-readable part of
>>> +\field{struct virtio_admin_cmd} that is at least as
>>> +large as the structure described by this specification
>>> +(even if the structure is all set to zero).
>>> +
>>> +The driver MUST supply both device-readable or device-writeable parts
>>> +of \field{struct virtio_admin_cmd} that are a multiple of 64 bit
>>> +in length.
>>> +
>>> +The device MUST supply both device-readable or device-writeable parts
>>> +of \field{struct virtio_admin_cmd} that are larger than zero in
>>> +length. However, \field{command_specific_data} and
>>> +\field{command_specific_result} MAY be zero in length, unless
>>> +specified otherwise for the command.
>>> +
>>> +The driver MUST NOT assume that the device will initialize the whole
>>> +device-writeable part of \field{struct virtio_admin_cmd} as described in the specification; instead,
>>> +the driver MUST act as if the structure
>>> +outside the part of the buffer used by the device
>>> +is set to zero.
>>> +
>>> +If multiple administration virtqueues have been configured,
>>> +the driver MUST ensure ordering for commands
>>> +placed on different administration virtqueues.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

