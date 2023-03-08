Return-Path: <virtio-dev-return-11523-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642F3C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:44:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A28E3330B0
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:44:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 916C39866F2
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 13:44:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 82D639866EF; Wed,  8 Mar 2023 13:44:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F5239866EE;
	Wed,  8 Mar 2023 13:44:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWH6+XqNfuYybfn8yDAggSuVvRHaUs2xmbWGZUpuTgZBOXk3+pDHJpABOHPo0cZFEo8+crnkiEIrVpnd+tbf9JcvErS8jyCJ6K/AMOJVE/T2Be7e3W1i50VgynWtfoRkckM7s183fZvSW1iuht/0MGvE+brbPlLgy3HV10m0sU76LgYNOxteELs9HJsHsW3frvY9Ge/mrCPlSnMXrlbUN6ah2kQ089uF/mvOqGv8DMKXEpoeG/hchGbB6HIbKBNASH45iBJWb7NzmzHllwesevi5h5BIZ3z8PBFmyaVP5tkwq7EwvqzkYLknaPiXiVF2gTM4hXWxsgeDxfRjDIQLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnEh5MLZeZa3tIluDtz1b3TceEClY2OgUl5hWDhIq6Q=;
 b=b6d8xTpwl+f7EtEZ7brbIvvNEx3YKxEHIyRM3UnvcXRgvcNlE3ep9EK3LQPKiTMzgtUsCWsViIYyVrqlAdYWTDD452cbRICrtBAO7iAbA2Zbxtz6zx+wYs6kK+gN2DlzgWG3oookkbQR2TFJUqUartjJZe6Y1/Ac9nb4wTwUBm2XGXF1qBTHfF+nJUaxw7VKWAO90h+vMofGgpqYjbgIX6ahab5AYG3jXU032hEhLhrbQwuGc2EiJ31ym67cMDE46qpGlZ05avzZTDVkrz6GkOuioyUMc0BHsRi9bBPFaXDIfXl7GwPEXIYfhq8HbEs4E2LIXaFXm4rJJY0q98bDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org,
        virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
        cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com,
        nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
        virtio@lists.oasis-open.org, Zhu Lingshan
 <lingshan.zhu@intel.com>,
        pasic@linux.ibm.com, Shahaf Shuler
 <shahafs@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Max Gurtovoy
 <mgurtovoy@nvidia.com>
In-Reply-To: <ZAiH/d7igeVCt4WE@nanopsycho>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <m27cvszuta.fsf@oracle.com>
 <20230308065526-mutt-send-email-mst@kernel.org>
 <m24jqvz9ep.fsf@oracle.com> <ZAiH/d7igeVCt4WE@nanopsycho>
Date: Wed, 08 Mar 2023 13:44:08 +0000
Message-ID: <m21qlzz7br.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::15) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CY8PR10MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: e4128fca-dd43-41cc-487a-08db1fdb342a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gRexRZptGxWV/LJoInOCaWxERYUyNnx2EoN0GSEB2YCySqX3/7dasAv6d/4c4zHHd3sROyUgl28e21/qwj9lXQRtR2JXYfdYG9fehCdPVgxlcQzAwAVxu0qtKOJu7q2lsqn6aOolKoryuosKW4K5DI8ZVctYVy6WbpYSUR3gegMelwScwszfg1z1ep7ymgQsyn0BnPxJamNuePDkEvOG7stKP1ce5roVzm/ftXIdB/jmEqYIAdtRq+/YUjZ4aA4qycEMs21GgV85e5CF39iy76IhH0tR4NNfcOHyQ9paxg0lA1bfdjsnAF/mNdbDgc1FWBRg0JEOHc8pr90GHRAIAlqBV9KDEyyNPLVDnQE0SyXXUzfS2zuT4q3rDGC4bhvXD1qkp6N6MeIZr2UMXqkj6UHxq2PQGjFh77b2ip266DMc4fMUxxEx+7vpDdAw03DUp89g/Vz9VFnoCZi0IVCDz8Pl2+s2DxHmLZdAUkDzwQ/XcWtMIi3PX0DlT5QtBrUg7k6/C47XaU/6XbBNl+9yocfZFn8Zqv2wsbh3kNpHAzwAij2a4IG9ceWbsyWdc4/Oo0VLln5GVxVhKZReu48RdgArqgwzH9EgZdCkrKU0khIsX5jWb86+p/L4m8EJsKl9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199018)(26005)(36756003)(8936002)(7416002)(5660300002)(6506007)(38100700002)(6666004)(6512007)(83380400001)(186003)(2616005)(54906003)(316002)(86362001)(41300700001)(66476007)(66946007)(16799955002)(8676002)(6916009)(4326008)(66556008)(6486002)(478600001)(2906002)(66899018)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hK9HphxLEeEkET/Euj+tCfBNLPGtsJzy+jw1SD9DxSFIdmCedkEorK3auK3Q?=
 =?us-ascii?Q?34ow7SeaHXF8AoK2gFQvPDFwyLtwK6m37yA0xz4r9cbz/Y5fWS9VR7Ycl5jk?=
 =?us-ascii?Q?5nfBIB9WTLTGrnpeKJeUHURJBP9dI/NcryBUaMS5gAgnhVSiP6BsezYUzKyE?=
 =?us-ascii?Q?JCE+ddlTx3OzAZ/2lk6z9OUQ39ad7sffxFTxcTG3k+2eo0qO/Sj2HbQdRFaE?=
 =?us-ascii?Q?omsWptmSpyP7z4JoEs+cG9jpu11OwQSRMvIOGLdfdouByj3ZthlLl4K926iu?=
 =?us-ascii?Q?kycikwli3vhdmd/ejyKo4HgZRk1AlPoX/R6ZbQlABpkhXB8MTkb9SF+T24pF?=
 =?us-ascii?Q?d8R2e5k5FgcboXE/W6Bmh+x4xWjAUky0Xyx1I5Cnuy/5zBvkgjVYjvb/UF0h?=
 =?us-ascii?Q?yaqq5eaO4/na1qRpKEAAy3XaZpEubOtQrjuCiH7JuzxufVsDybIXFEb7a1QC?=
 =?us-ascii?Q?ig5T8F1dreyInNPBDD8o6+gvTxg+S6V6oVqnpPs+rBdpiv1jILKyOzrGK0Fz?=
 =?us-ascii?Q?vRCs05Be355Ss+XS2crqRPQ95yO4rWFkikQudLTpMcqDDfFTAKNZrJ4mykyX?=
 =?us-ascii?Q?LCTqPg9OaF1FNApzSmG4Rft7smafNw1AKXLRIBr4tPiR7QIH0JtNAYixwHu+?=
 =?us-ascii?Q?4FEDlxk10bBVEsJOGcBSJfofdGnSlhkUxZAwQ6kEF8pqYgqeJ2CeG/Z11aAW?=
 =?us-ascii?Q?5wL0Y412g67sPwRPVhf1Dnn9hb4CitCGlWZcB/6glSgBFEOhdp63MjDhIdOQ?=
 =?us-ascii?Q?Cadb8MArUeMeEaY/NbK2gcdJvn5jPfvzZl6a5YfuNAnH+EfgHoH5nwYiECiP?=
 =?us-ascii?Q?+xaANKVRzCFuGxiNT64UqGTKCyfRowr3tio485Ya+azYuxftyrpaNR4xpDBm?=
 =?us-ascii?Q?gxb9VgXe1fp0KEw2D5plpu2O2752PYMZQqFz5Hbkt5OUNSWEv8o5KmQiWXYe?=
 =?us-ascii?Q?8Z7O5bsU9T26ZObMi221mgq+bwm4gqsVMnQu/hUXSnXYzdXhxMRHsa/ZUtps?=
 =?us-ascii?Q?MwLK1ivRPqqMI4SyGLOp2OunEO0I4QH6AGsNL6z02+TsYJr1W/4ePN0n9wwH?=
 =?us-ascii?Q?UPMeU234ULQwmIfvvx2HH+uGWt4I0uESeXsKcpy+bSbGPfQt0NRz7JWP0yfG?=
 =?us-ascii?Q?uGO7XvH4SQoNp5LBurwO+gNNUQQEaLT7jfQIzKH3IkXi1Fc1sEIOEdvDpEsd?=
 =?us-ascii?Q?msKuFCa/viCsgfnG8d5Z3vZS7d/oLLQLiN0YefiSdkbnm4j9TUfZK+Zj2NdE?=
 =?us-ascii?Q?5zljYOCSN5TiB6ol+y4GpVrmGxac+zpMkHR4SzsKAa2QX2ge+H8xD2qVW/Wm?=
 =?us-ascii?Q?Hi/8U3saDQNON0TxCM304W3WqiNd4utuFmNrz30mM17pJIdtXdH2Zh5HwL6O?=
 =?us-ascii?Q?vQ/5Sk5TNgDCRXvPIgLIiXaxbDFCi9qFY9KnOwwoFWKw8AezTyEtMD7zcoh+?=
 =?us-ascii?Q?GJlBAlSSIf2vczJeJuuN+gtJj3DdC+lrQzwiwOtfQh2hAeqKIUauF36LH1+o?=
 =?us-ascii?Q?jKBXvGSSuq/GNzUcEydFN0OOYZTxwT1n8qeRd5N2C0JYp+XuX0aI82l5EpKZ?=
 =?us-ascii?Q?Blu7CsJZkfv4oXJi5RXLxvn2hU5UD+v0XHXHsS07FV8lv5P28TeM8JvemyWJ?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4ocve8BLyrbJx/qFZ44LL34gNhZk9/O43f4bKb6xU6vn0Fc5S/H+d37A3L0uZKefIa85kZZMYXWEM6sC+rCX7bBWZ8GgTsFf4PiBuzPIA+LMFtQ6RZO3qfSsNRvAKi+HX6NthWD2YWtl+jc6J4/jFL/zUOUZfPqpPGtBFomGBOplFf0g3tQEYuJh9H1sd0aeTNva0XkrjgXcGgbX+MGJumQT2pWuSGwaLBcubf2cxtgb1pO+kPhD0jx9DHpSbe+PA5HivJDAuwwriMnhNg8VzuQrS7pA69GWho2QjHKtAcg/lkWcGxuIHU11Rglyv0Y1cyrdQAB0H6KEJdPr5NT69XPInr5YBVWrgdXJP8o6egQHXshwH3nQvdlwqbqlaTsV9qiXooKiX8lfXiP8+eGFHUBXMYZ+3+zBdTlQLTWq5Fwi+F/+B6VcLwIOa/wPlvKM7TTxiJyHXCISR7ZHsfTMmUcidcjxTqq0hqJrx+3q/TsdlnfuOIfK8ItFunZKV9KnNBh1xFgZiZ703fa1j+pZ2yfSNFiHF1dgfWDtNlxdP05ngTIsfjSlETZrnjQ0D9lJyMAPP4DjrVCvQt1w3Ijih38KmTi2B4aGSUv4GUHyZJg/W887jF2sFlQe/p06bfnRQzF6IkdXFaCSsV0yh2RzSP5bx80AQ24/Zp24IRojXS9iRrntm1aufBvglk+I64BxnIU+2YPXBHfWC5Ul4V+hiDD+ijOWb7ruSOKrPNboqZJwtlB7VWI+VP97fA0RKb6kVQTxSNAwAmebV1z+qWuh2D9x1GDyV4ElJHAWhM0kqmgEMn7tPgzabS2Ao9tRFK12G9MuINckWzHRNF2IltQ9Bs2OK9Tnl900ghycsOizAuInUDYP2dnlGWa5i01QBgyhbxcXYXMjkJyalv02t+UD7g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4128fca-dd43-41cc-487a-08db1fdb342a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 13:44:13.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJMXH0lmNOS13rMKHRkQx+y3D3IRV7gOxd5tYcfrMg4nBF90Ty76mbtrMHa27JsOyzXAQwkCSqlg0Sd7hSUJ4sDVYhUxGqXGxJL4A8vrKmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080117
X-Proofpoint-GUID: vt343djblxoGsvJUnxyko-R86-4ZG5iD
X-Proofpoint-ORIG-GUID: vt343djblxoGsvJUnxyko-R86-4ZG5iD
Subject: [virtio-dev] Re: [virtio] Re: [virtio-comment] [PATCH v10 09/10] admin:
 conformance clauses

Jiri Pirko <jiri@nvidia.com> writes:

> Wed, Mar 08, 2023 at 01:59:10PM CET, david.edmondson@oracle.com wrote:
>>"Michael S. Tsirkin" <mst@redhat.com> writes:
>>
>>> On Tue, Mar 07, 2023 at 11:04:33AM +0000, David Edmondson wrote:
>>>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>>> > +The driver MAY block use of VIRTIO_ADMIN_CMD_LIST_QUERY and
>>>> > +VIRTIO_ADMIN_CMD_LIST_USE by issuing VIRTIO_ADMIN_CMD_LIST_USE
>>>> > +with respective bits cleared in \field{command_specific_data}.
>>>> 
>>>> This runs contrary to the assertion "The list of supported commands MUST
>>>> NOT shrink", given that a driver is told to assume that
>>>> VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE are the only
>>>> commands initially available.
>>>
>>> Commands are still available just disabled, the meaning of
>>> "MUST NOT shrink" is clarified by the following:
>>>
>>> 	> > +after reporting a given command as supported through
>>> 	> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
>>> 	> > +as unsupported.
>>> I will stick an "i.e." there to make it hopefully clearer.
>>
>>This puzzles me.
>>
>>I can see the point of blocking LIST_USE, but not of blocking
>
> What is that point, I'm curious.

I might restrict the commands permitted by a device before handing it
off to some subordinate less trusted code.

>
>>LIST_QUERY. What's the purpose of this?
>
> I think that this might be just for the sake of treating all
> commands equally.
>
>
>>-- 
>>Time is waiting to explain, why refuse?
>>
>>---------------------------------------------------------------------
>>To unsubscribe from this mail list, you must leave the OASIS TC that 
>>generates this mail.  Follow this link to all your TCs in OASIS at:
>>https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 
>>
-- 
I used to get mad at my school, the teachers who taught me weren't cool.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

