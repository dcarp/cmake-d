/*
*   Full GTK, GDK, Pango, ect... bindings
*
*   Tedious work done by John Demme (me@teqdruid.com)
*       h2d used as well.
*
*   LGPL License from original header files probably applies.
*
*   Known issue:
*       Crashes at gtk_main if linked in.  I'm not sure why.  Solution:
        Use as header file. Do not compile, and do not link into program.
*/

module minwin.gtk;

version(build) pragma(nolink);

// Included as part of MinWin since the LGPL says the use of header
// files is unrestricted. The LGPL does not apply to any other part of
// MinWin except for this file (and even there John isn't sure if it
// applies since it is a port of header files). The original gtk.d is
// available from www.dsource.org

extern (C) {

    alias int ptrdiff_t;
    alias uint size_t;
    alias int wchar_t;

    alias byte gint8;
    alias ubyte guint8;
    alias short gint16;
    alias ushort guint16;

    alias int gint32;
    alias uint guint32;

    alias long gint64;
    alias ulong guint64;
    alias int gssize;
    alias uint gsize;
    alias _GStaticMutex GStaticMutex;
    alias void _GMutex;

    struct _GStaticMutex {
    _GMutex *runtime_mutex;
    union static_mutex_union  {
    char pad[24];
    double dummy_double;
    void *dummy_pointer;
    int dummy_long;
    }
    static_mutex_union static_mutex;
    }
    alias _GSystemThread GSystemThread;

    union _GSystemThread {
    char data[4];
    double dummy_double;
    void *dummy_pointer;
    int dummy_long;
    }
    alias int GPid;

    alias char gchar;
    alias short gshort;
    alias int glong;
    alias int gint;
    alias gint gboolean;

    alias ubyte guchar;
    alias ushort gushort;
    alias uint gulong;
    alias uint guint;

    alias float gfloat;
    alias double gdouble;
    alias void* gpointer;
    alias  void *gconstpointer;

    alias gint (*GCompareFunc) (gpointer a,
                            gpointer b);
    alias gint (*GCompareDataFunc) (gpointer a,
                            gpointer b,
                            gpointer user_data);
    alias gboolean (*GEqualFunc) (gpointer a,
                            gpointer b);
    alias void (*GDestroyNotify) (gpointer data);
    alias void (*GFunc) (gpointer data,
                            gpointer user_data);
    alias guint (*GHashFunc) (gpointer key);
    alias void (*GHFunc) (gpointer key,
                            gpointer value,
                            gpointer user_data);
    alias void (*GFreeFunc) (gpointer data);

    alias _GDoubleIEEE754 GDoubleIEEE754;

    alias _GFloatIEEE754 GFloatIEEE754;

    union _GFloatIEEE754 {
    gfloat v_float;
    struct mpn_struct  {
    guint mantissa;
    guint biased_exponent;
    guint sign;
    }
    }
    union _GDoubleIEEE754 {
    gdouble v_double;
    struct mpn_struct  {
    guint mantissa_low;
    guint mantissa_high;
    guint biased_exponent;
    guint sign;
    }
    }
    alias _GTimeVal GTimeVal;


    struct _GTimeVal {
    glong tv_sec;
    glong tv_usec;
    }

    alias _GArray GArray;

    alias _GByteArray GByteArray;

    alias _GPtrArray GPtrArray;


    struct _GArray {
    gchar *data;
    guint len;
    }

    struct _GByteArray {
    guint8 *data;
    guint len;
    }

    struct _GPtrArray {
    gpointer *pdata;
    guint len;
    }
    GArray* g_array_new (gboolean zero_terminated,
                    gboolean clear_,
                    guint element_size);
    GArray* g_array_sized_new (gboolean zero_terminated,
                    gboolean clear_,
                    guint element_size,
                    guint reserved_size);
    gchar* g_array_free (GArray *array,
                    gboolean free_segment);
    GArray* g_array_append_vals (GArray *array,
                    gpointer data,
                    guint len);
    GArray* g_array_prepend_vals (GArray *array,
                    gpointer data,
                    guint len);
    GArray* g_array_insert_vals (GArray *array,
                    guint index_,
                    gpointer data,
                    guint len);
    GArray* g_array_set_size (GArray *array,
                    guint length);
    GArray* g_array_remove_index (GArray *array,
                    guint index_);
    GArray* g_array_remove_index_fast (GArray *array,
                    guint index_);
    GArray* g_array_remove_range (GArray *array,
                    guint index_,
                    guint length);
    void g_array_sort (GArray *array,
                    GCompareFunc compare_func);
    void g_array_sort_with_data (GArray *array,
                    GCompareDataFunc compare_func,
                    gpointer user_data);






    GPtrArray* g_ptr_array_new ();
    GPtrArray* g_ptr_array_sized_new (guint reserved_size);
    gpointer* g_ptr_array_free (GPtrArray *array,
                        gboolean free_seg);
    void g_ptr_array_set_size (GPtrArray *array,
                        gint length);
    gpointer g_ptr_array_remove_index (GPtrArray *array,
                        guint index_);
    gpointer g_ptr_array_remove_index_fast (GPtrArray *array,
                        guint index_);
    gboolean g_ptr_array_remove (GPtrArray *array,
                        gpointer data);
    gboolean g_ptr_array_remove_fast (GPtrArray *array,
                        gpointer data);
    void g_ptr_array_remove_range (GPtrArray *array,
                        guint index_,
                        guint length);
    void g_ptr_array_add (GPtrArray *array,
                        gpointer data);
    void g_ptr_array_sort (GPtrArray *array,
                        GCompareFunc compare_func);
    void g_ptr_array_sort_with_data (GPtrArray *array,
                        GCompareDataFunc compare_func,
                        gpointer user_data);
    void g_ptr_array_foreach (GPtrArray *array,
                        GFunc func,
                        gpointer user_data);






    GByteArray* g_byte_array_new ();
    GByteArray* g_byte_array_sized_new (guint reserved_size);
    guint8* g_byte_array_free (GByteArray *array,
                        gboolean free_segment);
    GByteArray* g_byte_array_append (GByteArray *array,
                        guint8 *data,
                        guint len);
    GByteArray* g_byte_array_prepend (GByteArray *array,
                        guint8 *data,
                        guint len);
    GByteArray* g_byte_array_set_size (GByteArray *array,
                        guint length);
    GByteArray* g_byte_array_remove_index (GByteArray *array,
                        guint index_);
    GByteArray* g_byte_array_remove_index_fast (GByteArray *array,
                        guint index_);
    GByteArray* g_byte_array_remove_range (GByteArray *array,
                        guint index_,
                        guint length);
    void g_byte_array_sort (GByteArray *array,
                        GCompareFunc compare_func);
    void g_byte_array_sort_with_data (GByteArray *array,
                        GCompareDataFunc compare_func,
                        gpointer user_data);

    alias guint32 GQuark;

    GQuark g_quark_try_string ( gchar *string);
    GQuark g_quark_from_static_string ( gchar *string);
    GQuark g_quark_from_string ( gchar *string);
    gchar* g_quark_to_string (GQuark quark) ;

    alias _GError GError;

    struct _GError {
    GQuark domain;
    gint code;
    gchar *message;
    }

    GError* g_error_new (GQuark domain,
                    gint code,
                    gchar *format,
                    ...) ;

    GError* g_error_new_literal (GQuark domain,
                    gint code,
                    gchar *message);

    void g_error_free (GError *error);
    GError* g_error_copy ( GError *error);

    gboolean g_error_matches ( GError *error,
                    GQuark domain,
                    gint code);




    void g_set_error (GError **err,
                    GQuark domain,
                    gint code,
                    gchar *format,
                    ...) ;



    void g_propagate_error (GError **dest,
                    GError *src);


    void g_clear_error (GError **err);






    gint g_atomic_int_exchange_and_add (gint *atomic,
                            gint val);
    void g_atomic_int_add (gint *atomic,
                            gint val);
    gboolean g_atomic_int_compare_and_exchange (gint *atomic,
                            gint oldval,
                            gint newval);
    gboolean g_atomic_pointer_compare_and_exchange (gpointer *atomic,
                            gpointer oldval,
                            gpointer newval);







    GQuark g_thread_error_quark ();


    enum GThreadError {
    G_THREAD_ERROR_AGAIN
    };


    alias gpointer (*GThreadFunc) (gpointer data);

    enum GThreadPriority {
    G_THREAD_PRIORITY_LOW,
    G_THREAD_PRIORITY_NORMAL,
    G_THREAD_PRIORITY_HIGH,
    G_THREAD_PRIORITY_URGENT
    };


    alias _GThread GThread;

    struct _GThread {

    GThreadFunc func;
    gpointer data;
    gboolean joinable;
    GThreadPriority priority;
    }

    alias _GMutex GMutex;

    alias _GCond GCond;
    alias void _GCond;

    alias _GPrivate GPrivate;
    alias void _GPrivate;

    alias _GStaticPrivate GStaticPrivate;


    alias _GThreadFunctions GThreadFunctions;

    struct _GThreadFunctions {
    GMutex* (*mutex_new) ();
    void (*mutex_lock) (GMutex *mutex);
    gboolean (*mutex_trylock) (GMutex *mutex);
    void (*mutex_unlock) (GMutex *mutex);
    void (*mutex_free) (GMutex *mutex);
    GCond* (*cond_new) ();
    void (*cond_signal) (GCond *cond);
    void (*cond_broadcast) (GCond *cond);
    void (*cond_wait) (GCond *cond,
                    GMutex *mutex);
    gboolean (*cond_timed_wait) (GCond *cond,
                    GMutex *mutex,
                    GTimeVal *end_time);
    void (*cond_free) (GCond *cond);
    gpointer (*private_get) (GPrivate *private_key);
    void (*private_set) (GPrivate *private_key,
                    gpointer data);
    void (*thread_create) (GThreadFunc func,
                    gpointer data,
                    gulong stack_size,
                    gboolean joinable,
                    gboolean bound,
                    GThreadPriority priority,
                    gpointer thread,
                    GError **error);
    void (*thread_yield) ();
    void (*thread_join) (gpointer thread);
    void (*thread_exit) ();
    void (*thread_set_priority)(gpointer thread,
                    GThreadPriority priority);
    void (*thread_self) (gpointer thread);
    gboolean (*thread_equal) (gpointer thread1,
                    gpointer thread2);
    }

    GThreadFunctions g_thread_functions_for_glib_use;
    gboolean g_thread_use_default_impl;
    gboolean g_threads_got_initialized;





    void g_thread_init (GThreadFunctions *vtable);
    void g_thread_init_with_errorcheck_mutexes (GThreadFunctions* vtable);
    GMutex* g_static_mutex_get_mutex_impl (GMutex **mutex);
    GThread* g_thread_create_full (GThreadFunc func,
                    gpointer data,
                    gulong stack_size,
                    gboolean joinable,
                    gboolean bound,
                    GThreadPriority priority,
                    GError **error);
    GThread* g_thread_self ();
    void g_thread_exit (gpointer retval);
    gpointer g_thread_join (GThread *thread);

    void g_thread_set_priority (GThread *thread,
                    GThreadPriority priority);
    void g_static_mutex_init (GStaticMutex *mutex);
    void g_static_mutex_free (GStaticMutex *mutex);

    struct _GStaticPrivate {

    guint index;
    }

    void g_static_private_init (GStaticPrivate *private_key);
    gpointer g_static_private_get (GStaticPrivate *private_key);
    void g_static_private_set (GStaticPrivate *private_key,
                        gpointer data,
                        GDestroyNotify notify);
    void g_static_private_free (GStaticPrivate *private_key);

    alias _GStaticRecMutex GStaticRecMutex;

    struct _GStaticRecMutex {

    GStaticMutex mutex;
    guint depth;
    GSystemThread owner;
    }


    void g_static_rec_mutex_init (GStaticRecMutex *mutex);
    void g_static_rec_mutex_lock (GStaticRecMutex *mutex);
    gboolean g_static_rec_mutex_trylock (GStaticRecMutex *mutex);
    void g_static_rec_mutex_unlock (GStaticRecMutex *mutex);
    void g_static_rec_mutex_lock_full (GStaticRecMutex *mutex,
                        guint depth);
    guint g_static_rec_mutex_unlock_full (GStaticRecMutex *mutex);
    void g_static_rec_mutex_free (GStaticRecMutex *mutex);

    alias _GStaticRWLock GStaticRWLock;

    struct _GStaticRWLock {

    GStaticMutex mutex;
    GCond *read_cond;
    GCond *write_cond;
    guint read_counter;
    gboolean have_writer;
    guint want_to_read;
    guint want_to_write;
    }



    void g_static_rw_lock_init (GStaticRWLock* lock);
    void g_static_rw_lock_reader_lock (GStaticRWLock* lock);
    gboolean g_static_rw_lock_reader_trylock (GStaticRWLock* lock);
    void g_static_rw_lock_reader_unlock (GStaticRWLock* lock);
    void g_static_rw_lock_writer_lock (GStaticRWLock* lock);
    gboolean g_static_rw_lock_writer_trylock (GStaticRWLock* lock);
    void g_static_rw_lock_writer_unlock (GStaticRWLock* lock);
    void g_static_rw_lock_free (GStaticRWLock* lock);

    enum GOnceStatus {
    G_ONCE_STATUS_NOTCALLED,
    G_ONCE_STATUS_PROGRESS,
    G_ONCE_STATUS_READY
    };


    alias _GOnce GOnce;

    struct _GOnce {
    GOnceStatus status;
    gpointer retval;
    }



    gpointer g_once_impl (GOnce *once, GThreadFunc func, gpointer arg);
    void glib_dummy_decl ();




    alias _GAsyncQueue GAsyncQueue;
    alias void _GAsyncQueue;




    GAsyncQueue* g_async_queue_new ();





    void g_async_queue_lock (GAsyncQueue *queue);
    void g_async_queue_unlock (GAsyncQueue *queue);


    void g_async_queue_ref (GAsyncQueue *queue);
    void g_async_queue_unref (GAsyncQueue *queue);


    void g_async_queue_ref_unlocked (GAsyncQueue *queue);
    void g_async_queue_unref_and_unlock (GAsyncQueue *queue);



    void g_async_queue_push (GAsyncQueue *queue,
                            gpointer data);
    void g_async_queue_push_unlocked (GAsyncQueue *queue,
                            gpointer data);



    gpointer g_async_queue_pop (GAsyncQueue *queue);
    gpointer g_async_queue_pop_unlocked (GAsyncQueue *queue);


    gpointer g_async_queue_try_pop (GAsyncQueue *queue);
    gpointer g_async_queue_try_pop_unlocked (GAsyncQueue *queue);



    gpointer g_async_queue_timed_pop (GAsyncQueue *queue,
                            GTimeVal *end_time);
    gpointer g_async_queue_timed_pop_unlocked (GAsyncQueue *queue,
                            GTimeVal *end_time);







    gint g_async_queue_length (GAsyncQueue *queue);
    gint g_async_queue_length_unlocked (GAsyncQueue *queue);




    void g_on_error_query ( gchar *prg_name);
    void g_on_error_stack_trace ( gchar *prg_name);



    alias _GAllocator GAllocator;
    alias void _GAllocator;

    alias _GMemChunk GMemChunk;
    alias void _GMemChunk;

    alias _GMemVTable GMemVTable;

    gpointer g_malloc (gulong n_bytes);
    gpointer g_malloc0 (gulong n_bytes);
    gpointer g_realloc (gpointer mem,
                gulong n_bytes);
    void g_free (gpointer mem);
    gpointer g_try_malloc (gulong n_bytes);
    gpointer g_try_realloc (gpointer mem,
                gulong n_bytes);
    struct _GMemVTable {
    gpointer (*malloc) (gsize n_bytes);
    gpointer (*realloc) (gpointer mem,
                gsize n_bytes);
    void (*free) (gpointer mem);

    gpointer (*calloc) (gsize n_blocks,
                gsize n_block_bytes);
    gpointer (*try_malloc) (gsize n_bytes);
    gpointer (*try_realloc) (gpointer mem,
                gsize n_bytes);
    }
    void g_mem_set_vtable (GMemVTable *vtable);
    gboolean g_mem_is_system_malloc ();



    GMemVTable *glib_mem_profiler_table;
    void g_mem_profile ();
    GMemChunk* g_mem_chunk_new ( gchar *name,
                    gint atom_size,
                    gulong area_size,
                    gint type);
    void g_mem_chunk_destroy (GMemChunk *mem_chunk);
    gpointer g_mem_chunk_alloc (GMemChunk *mem_chunk);
    gpointer g_mem_chunk_alloc0 (GMemChunk *mem_chunk);
    void g_mem_chunk_free (GMemChunk *mem_chunk,
                    gpointer mem);
    void g_mem_chunk_clean (GMemChunk *mem_chunk);
    void g_mem_chunk_reset (GMemChunk *mem_chunk);
    void g_mem_chunk_print (GMemChunk *mem_chunk);
    void g_mem_chunk_info ();
    void g_blow_chunks ();




    GAllocator* g_allocator_new ( gchar *name,
                guint n_preallocs);
    void g_allocator_free (GAllocator *allocator);











    alias _GList GList;


    struct _GList {
    gpointer data;
    GList *next;
    GList *prev;
    }



    void g_list_push_allocator (GAllocator *allocator);
    void g_list_pop_allocator ();
    GList* g_list_alloc ();
    void g_list_free (GList *list);
    void g_list_free_1 (GList *list);
    GList* g_list_append (GList *list,
                    gpointer data);
    GList* g_list_prepend (GList *list,
                    gpointer data);
    GList* g_list_insert (GList *list,
                    gpointer data,
                    gint position);
    GList* g_list_insert_sorted (GList *list,
                    gpointer data,
                    GCompareFunc func);
    GList* g_list_insert_before (GList *list,
                    GList *sibling,
                    gpointer data);
    GList* g_list_concat (GList *list1,
                    GList *list2);
    GList* g_list_remove (GList *list,
                    gpointer data);
    GList* g_list_remove_all (GList *list,
                    gpointer data);
    GList* g_list_remove_link (GList *list,
                    GList *llink);
    GList* g_list_delete_link (GList *list,
                    GList *link_);
    GList* g_list_reverse (GList *list);
    GList* g_list_copy (GList *list);
    GList* g_list_nth (GList *list,
                    guint n);
    GList* g_list_nth_prev (GList *list,
                    guint n);
    GList* g_list_find (GList *list,
                    gpointer data);
    GList* g_list_find_custom (GList *list,
                    gpointer data,
                    GCompareFunc func);
    gint g_list_position (GList *list,
                    GList *llink);
    gint g_list_index (GList *list,
                    gpointer data);
    GList* g_list_last (GList *list);
    GList* g_list_first (GList *list);
    guint g_list_length (GList *list);
    void g_list_foreach (GList *list,
                    GFunc func,
                    gpointer user_data);
    GList* g_list_sort (GList *list,
                    GCompareFunc compare_func);
    GList* g_list_sort_with_data (GList *list,
                    GCompareDataFunc compare_func,
                    gpointer user_data);
    gpointer g_list_nth_data (GList *list,
                    guint n);








    alias _GCache GCache;
    alias void _GCache;


    alias gpointer (*GCacheNewFunc) (gpointer key);
    alias gpointer (*GCacheDupFunc) (gpointer value);
    alias void (*GCacheDestroyFunc) (gpointer value);



    GCache* g_cache_new (GCacheNewFunc value_new_func,
                    GCacheDestroyFunc value_destroy_func,
                    GCacheDupFunc key_dup_func,
                    GCacheDestroyFunc key_destroy_func,
                    GHashFunc hash_key_func,
                    GHashFunc hash_value_func,
                    GEqualFunc key_equal_func);
    void g_cache_destroy (GCache *cache);
    gpointer g_cache_insert (GCache *cache,
                    gpointer key);
    void g_cache_remove (GCache *cache,
                    gpointer value);
    void g_cache_key_foreach (GCache *cache,
                    GHFunc func,
                    gpointer user_data);
    void g_cache_value_foreach (GCache *cache,
                    GHFunc func,
                    gpointer user_data);




    alias _GCompletion GCompletion;


    alias gchar* (*GCompletionFunc) (gpointer);




    alias gint (*GCompletionStrncmpFunc) (gchar *s1,
                        gchar *s2,
                        gsize n);

    struct _GCompletion {
    GList* items;
    GCompletionFunc func;

    gchar* prefix;
    GList* cache;
    GCompletionStrncmpFunc strncmp_func;
    }

    GCompletion* g_completion_new (GCompletionFunc func);
    void g_completion_add_items (GCompletion* cmp,
                        GList* items);
    void g_completion_remove_items (GCompletion* cmp,
                        GList* items);
    void g_completion_clear_items (GCompletion* cmp);
    GList* g_completion_complete (GCompletion* cmp,
                        gchar* prefix,
                        gchar** new_prefix);
    GList* g_completion_complete_utf8 (GCompletion *cmp,
                        gchar* prefix,
                        gchar** new_prefix);
    void g_completion_set_compare (GCompletion *cmp,
                        GCompletionStrncmpFunc strncmp_func);
    void g_completion_free (GCompletion* cmp);






    enum GConvertError {
    G_CONVERT_ERROR_NO_CONVERSION,
    G_CONVERT_ERROR_ILLEGAL_SEQUENCE,
    G_CONVERT_ERROR_FAILED,
    G_CONVERT_ERROR_PARTIAL_INPUT,
    G_CONVERT_ERROR_BAD_URI,
    G_CONVERT_ERROR_NOT_ABSOLUTE_PATH
    };



    GQuark g_convert_error_quark ();



    alias _GIConv *GIConv;
    alias void _GIConv;


    GIConv g_iconv_open ( gchar *to_codeset,
                gchar *from_codeset);
    size_t g_iconv (GIConv converter,
            gchar **inbuf,
            gsize *inbytes_left,
            gchar **outbuf,
            gsize *outbytes_left);
    gint g_iconv_close (GIConv converter);


    gchar* g_convert ( gchar *str,
                    gssize len,
                    gchar *to_codeset,
                    gchar *from_codeset,
                    gsize *bytes_read,
                    gsize *bytes_written,
                    GError **error);
    gchar* g_convert_with_iconv ( gchar *str,
                    gssize len,
                    GIConv converter,
                    gsize *bytes_read,
                    gsize *bytes_written,
                    GError **error);
    gchar* g_convert_with_fallback ( gchar *str,
                    gssize len,
                    gchar *to_codeset,
                    gchar *from_codeset,
                    gchar *fallback,
                    gsize *bytes_read,
                    gsize *bytes_written,
                    GError **error);




    gchar* g_locale_to_utf8 ( gchar *opsysstring,
                gssize len,
                gsize *bytes_read,
                gsize *bytes_written,
                GError **error);
    gchar* g_locale_from_utf8 ( gchar *utf8string,
                gssize len,
                gsize *bytes_read,
                gsize *bytes_written,
                GError **error);




    gchar* g_filename_to_utf8 ( gchar *opsysstring,
                gssize len,
                gsize *bytes_read,
                gsize *bytes_written,
                GError **error);
    gchar* g_filename_from_utf8 ( gchar *utf8string,
                gssize len,
                gsize *bytes_read,
                gsize *bytes_written,
                GError **error);

    gchar *g_filename_from_uri ( gchar *uri,
                gchar **hostname,
                GError **error);

    gchar *g_filename_to_uri ( gchar *filename,
                gchar *hostname,
                GError **error);





    alias _GData GData;
    alias void _GData;


    alias void (*GDataForeachFunc) (GQuark key_id,
                            gpointer data,
                            gpointer user_data);



    void g_datalist_init (GData **datalist);
    void g_datalist_clear (GData **datalist);
    gpointer g_datalist_id_get_data (GData **datalist,
                        GQuark key_id);
    void g_datalist_id_set_data_full (GData **datalist,
                        GQuark key_id,
                        gpointer data,
                        GDestroyNotify destroy_func);
    gpointer g_datalist_id_remove_no_notify (GData **datalist,
                        GQuark key_id);
    void g_datalist_foreach (GData **datalist,
                        GDataForeachFunc func,
                        gpointer user_data);
    void g_dataset_destroy (gpointer dataset_location);
    gpointer g_dataset_id_get_data (gpointer dataset_location,
                        GQuark key_id);
    void g_dataset_id_set_data_full (gpointer dataset_location,
                        GQuark key_id,
                        gpointer data,
                        GDestroyNotify destroy_func);
    gpointer g_dataset_id_remove_no_notify (gpointer dataset_location,
                        GQuark key_id);
    void g_dataset_foreach (gpointer dataset_location,
                        GDataForeachFunc func,
                        gpointer user_data);


    alias gint32 GTime;
    alias guint16 GDateYear;
    alias guint8 GDateDay;
    alias _GDate GDate;




    enum GDateDMY {
    G_DATE_DAY = 0,
    G_DATE_MONTH = 1,
    G_DATE_YEAR = 2
    };



    enum GDateWeekday {
    G_DATE_BAD_WEEKDAY = 0,
    G_DATE_MONDAY = 1,
    G_DATE_TUESDAY = 2,
    G_DATE_WEDNESDAY = 3,
    G_DATE_THURSDAY = 4,
    G_DATE_FRIDAY = 5,
    G_DATE_SATURDAY = 6,
    G_DATE_SUNDAY = 7
    };

    enum GDateMonth {
    G_DATE_BAD_MONTH = 0,
    G_DATE_JANUARY = 1,
    G_DATE_FEBRUARY = 2,
    G_DATE_MARCH = 3,
    G_DATE_APRIL = 4,
    G_DATE_MAY = 5,
    G_DATE_JUNE = 6,
    G_DATE_JULY = 7,
    G_DATE_AUGUST = 8,
    G_DATE_SEPTEMBER = 9,
    G_DATE_OCTOBER = 10,
    G_DATE_NOVEMBER = 11,
    G_DATE_DECEMBER = 12
    };

    struct _GDate {
    guint julian_days;





    guint julian;
    guint dmy;


    guint day;
    guint month;
    guint year;
    }





    GDate* g_date_new ();
    GDate* g_date_new_dmy (GDateDay day,
                        GDateMonth month,
                        GDateYear year);
    GDate* g_date_new_julian (guint32 julian_day);
    void g_date_free (GDate *date);






    gboolean g_date_valid ( GDate *date);
    gboolean g_date_valid_day (GDateDay day) ;
    gboolean g_date_valid_month (GDateMonth month) ;
    gboolean g_date_valid_year (GDateYear year) ;
    gboolean g_date_valid_weekday (GDateWeekday weekday) ;
    gboolean g_date_valid_julian (guint32 julian_date) ;
    gboolean g_date_valid_dmy (GDateDay day,
                        GDateMonth month,
                        GDateYear year) ;

    GDateWeekday g_date_get_weekday ( GDate *date);
    GDateMonth g_date_get_month ( GDate *date);
    GDateYear g_date_get_year ( GDate *date);
    GDateDay g_date_get_day ( GDate *date);
    guint32 g_date_get_julian ( GDate *date);
    guint g_date_get_day_of_year ( GDate *date);






    guint g_date_get_monday_week_of_year ( GDate *date);
    guint g_date_get_sunday_week_of_year ( GDate *date);





    void g_date_clear (GDate *date,
                        guint n_dates);





    void g_date_set_parse (GDate *date,
                        gchar *str);
    void g_date_set_time (GDate *date,
                        GTime time_);
    void g_date_set_month (GDate *date,
                        GDateMonth month);
    void g_date_set_day (GDate *date,
                        GDateDay day);
    void g_date_set_year (GDate *date,
                        GDateYear year);
    void g_date_set_dmy (GDate *date,
                        GDateDay day,
                        GDateMonth month,
                        GDateYear y);
    void g_date_set_julian (GDate *date,
                        guint32 julian_date);
    gboolean g_date_is_first_of_month ( GDate *date);
    gboolean g_date_is_last_of_month ( GDate *date);


    void g_date_add_days (GDate *date,
                        guint n_days);
    void g_date_subtract_days (GDate *date,
                        guint n_days);


    void g_date_add_months (GDate *date,
                        guint n_months);
    void g_date_subtract_months (GDate *date,
                        guint n_months);


    void g_date_add_years (GDate *date,
                        guint n_years);
    void g_date_subtract_years (GDate *date,
                        guint n_years);
    gboolean g_date_is_leap_year (GDateYear year) ;
    guint8 g_date_get_days_in_month (GDateMonth month,
                        GDateYear year) ;
    guint8 g_date_get_monday_weeks_in_year (GDateYear year) ;
    guint8 g_date_get_sunday_weeks_in_year (GDateYear year) ;



    gint g_date_days_between ( GDate *date1,
                        GDate *date2);


    gint g_date_compare ( GDate *lhs,
                        GDate *rhs);
    void g_date_to_struct_tm ( GDate *date,
                        void* tm);

    void g_date_clamp (GDate *date,
                        GDate *min_date,
                        GDate *max_date);


    void g_date_order (GDate *date1, GDate *date2);




    gsize g_date_strftime (gchar *s,
                        gsize slen,
                        gchar *format,
                        GDate *date);



    alias _GDir GDir;
    alias void _GDir;


    GDir * g_dir_open ( gchar *path,
                        guint flags,
                        GError **error);
    gchar *g_dir_read_name (GDir *dir);
    void g_dir_rewind (GDir *dir);
    void g_dir_close (GDir *dir);







    enum GFileError {
    G_FILE_ERROR_EXIST,
    G_FILE_ERROR_ISDIR,
    G_FILE_ERROR_ACCES,
    G_FILE_ERROR_NAMETOOLONG,
    G_FILE_ERROR_NOENT,
    G_FILE_ERROR_NOTDIR,
    G_FILE_ERROR_NXIO,
    G_FILE_ERROR_NODEV,
    G_FILE_ERROR_ROFS,
    G_FILE_ERROR_TXTBSY,
    G_FILE_ERROR_FAULT,
    G_FILE_ERROR_LOOP,
    G_FILE_ERROR_NOSPC,
    G_FILE_ERROR_NOMEM,
    G_FILE_ERROR_MFILE,
    G_FILE_ERROR_NFILE,
    G_FILE_ERROR_BADF,
    G_FILE_ERROR_INVAL,
    G_FILE_ERROR_PIPE,
    G_FILE_ERROR_AGAIN,
    G_FILE_ERROR_INTR,
    G_FILE_ERROR_IO,
    G_FILE_ERROR_PERM,
    G_FILE_ERROR_FAILED
    };






    enum GFileTest {
    G_FILE_TEST_IS_REGULAR = 1 << 0,
    G_FILE_TEST_IS_SYMLINK = 1 << 1,
    G_FILE_TEST_IS_DIR = 1 << 2,
    G_FILE_TEST_IS_EXECUTABLE = 1 << 3,
    G_FILE_TEST_EXISTS = 1 << 4
    };


    GQuark g_file_error_quark ();

    GFileError g_file_error_from_errno (gint err_no);

    gboolean g_file_test ( gchar *filename,
                GFileTest test);
    gboolean g_file_get_contents ( gchar *filename,
                gchar **contents,
                gsize *length,
                GError **error);
    gchar *g_file_read_link ( gchar *filename,
                GError **error);


    gint g_mkstemp (gchar *tmpl);


    gint g_file_open_tmp ( gchar *tmpl,
                gchar **name_used,
                GError **error);

    gchar *g_build_path ( gchar *separator,
                gchar *first_element,
                ...);
    gchar *g_build_filename ( gchar *first_element,
                ...);




    alias _GHashTable GHashTable;
    alias void _GHashTable;


    alias gboolean (*GHRFunc) (gpointer key,
                gpointer value,
                gpointer user_data);



    GHashTable* g_hash_table_new (GHashFunc hash_func,
                        GEqualFunc key_equal_func);
    GHashTable* g_hash_table_new_full (GHashFunc hash_func,
                        GEqualFunc key_equal_func,
                        GDestroyNotify key_destroy_func,
                        GDestroyNotify value_destroy_func);
    void g_hash_table_destroy (GHashTable *hash_table);
    void g_hash_table_insert (GHashTable *hash_table,
                        gpointer key,
                        gpointer value);
    void g_hash_table_replace (GHashTable *hash_table,
                        gpointer key,
                        gpointer value);
    gboolean g_hash_table_remove (GHashTable *hash_table,
                        gpointer key);
    gboolean g_hash_table_steal (GHashTable *hash_table,
                        gpointer key);
    gpointer g_hash_table_lookup (GHashTable *hash_table,
                        gpointer key);
    gboolean g_hash_table_lookup_extended (GHashTable *hash_table,
                        gpointer lookup_key,
                        gpointer *orig_key,
                        gpointer *value);
    void g_hash_table_foreach (GHashTable *hash_table,
                        GHFunc func,
                        gpointer user_data);
    gpointer g_hash_table_find (GHashTable *hash_table,
                        GHRFunc predicate,
                        gpointer user_data);
    guint g_hash_table_foreach_remove (GHashTable *hash_table,
                        GHRFunc func,
                        gpointer user_data);
    guint g_hash_table_foreach_steal (GHashTable *hash_table,
                        GHRFunc func,
                        gpointer user_data);
    guint g_hash_table_size (GHashTable *hash_table);
    gboolean g_str_equal (gpointer v,
            gpointer v2);
    guint g_str_hash (gpointer v);

    gboolean g_int_equal (gpointer v,
            gpointer v2);
    guint g_int_hash (gpointer v);







    guint g_direct_hash (gpointer v) ;
    gboolean g_direct_equal (gpointer v,
                gpointer v2) ;






    alias _GHook GHook;

    alias _GHookList GHookList;


    alias gint (*GHookCompareFunc) (GHook *new_hook,
                            GHook *sibling);
    alias gboolean (*GHookFindFunc) (GHook *hook,
                            gpointer data);
    alias void (*GHookMarshaller) (GHook *hook,
                            gpointer marshal_data);
    alias gboolean (*GHookCheckMarshaller) (GHook *hook,
                            gpointer marshal_data);
    alias void (*GHookFunc) (gpointer data);
    alias gboolean (*GHookCheckFunc) (gpointer data);
    alias void (*GHookFinalizeFunc) (GHookList *hook_list,
                            GHook *hook);
    enum GHookFlagMask {
    G_HOOK_FLAG_ACTIVE = 1 << 0,
    G_HOOK_FLAG_IN_CALL = 1 << 1,
    G_HOOK_FLAG_MASK = 0x0f
    };





    struct _GHookList {
    gulong seq_id;
    guint hook_size;
    guint is_setup;
    GHook *hooks;
    GMemChunk *hook_memchunk;
    GHookFinalizeFunc finalize_hook;
    gpointer dummy[2];
    }
    struct _GHook {
    gpointer data;
    GHook *next;
    GHook *prev;
    guint ref_count;
    gulong hook_id;
    guint flags;
    gpointer func;
    GDestroyNotify destroy;
    }
    void g_hook_list_init (GHookList *hook_list,
                        guint hook_size);
    void g_hook_list_clear (GHookList *hook_list);
    GHook* g_hook_alloc (GHookList *hook_list);
    void g_hook_free (GHookList *hook_list,
                        GHook *hook);
    void g_hook_ref (GHookList *hook_list,
                        GHook *hook);
    void g_hook_unref (GHookList *hook_list,
                        GHook *hook);
    gboolean g_hook_destroy (GHookList *hook_list,
                        gulong hook_id);
    void g_hook_destroy_link (GHookList *hook_list,
                        GHook *hook);
    void g_hook_prepend (GHookList *hook_list,
                        GHook *hook);
    void g_hook_insert_before (GHookList *hook_list,
                        GHook *sibling,
                        GHook *hook);
    void g_hook_insert_sorted (GHookList *hook_list,
                        GHook *hook,
                        GHookCompareFunc func);
    GHook* g_hook_get (GHookList *hook_list,
                        gulong hook_id);
    GHook* g_hook_find (GHookList *hook_list,
                        gboolean need_valids,
                        GHookFindFunc func,
                        gpointer data);
    GHook* g_hook_find_data (GHookList *hook_list,
                        gboolean need_valids,
                        gpointer data);
    GHook* g_hook_find_func (GHookList *hook_list,
                        gboolean need_valids,
                        gpointer func);
    GHook* g_hook_find_func_data (GHookList *hook_list,
                        gboolean need_valids,
                        gpointer func,
                        gpointer data);

    GHook* g_hook_first_valid (GHookList *hook_list,
                        gboolean may_be_in_call);



    GHook* g_hook_next_valid (GHookList *hook_list,
                        GHook *hook,
                        gboolean may_be_in_call);

    gint g_hook_compare_ids (GHook *new_hook,
                        GHook *sibling);





    void g_hook_list_invoke (GHookList *hook_list,
                        gboolean may_recurse);



    void g_hook_list_invoke_check (GHookList *hook_list,
                        gboolean may_recurse);


    void g_hook_list_marshal (GHookList *hook_list,
                        gboolean may_recurse,
                        GHookMarshaller marshaller,
                        gpointer marshal_data);
    void g_hook_list_marshal_check (GHookList *hook_list,
                        gboolean may_recurse,
                        GHookCheckMarshaller marshaller,
                        gpointer marshal_data);




    alias _GSList GSList;


    struct _GSList {
    gpointer data;
    GSList *next;
    }



    void g_slist_push_allocator (GAllocator *allocator);
    void g_slist_pop_allocator ();
    GSList* g_slist_alloc ();
    void g_slist_free (GSList *list);
    void g_slist_free_1 (GSList *list);
    GSList* g_slist_append (GSList *list,
                    gpointer data);
    GSList* g_slist_prepend (GSList *list,
                    gpointer data);
    GSList* g_slist_insert (GSList *list,
                    gpointer data,
                    gint position);
    GSList* g_slist_insert_sorted (GSList *list,
                    gpointer data,
                    GCompareFunc func);
    GSList* g_slist_insert_before (GSList *slist,
                    GSList *sibling,
                    gpointer data);
    GSList* g_slist_concat (GSList *list1,
                    GSList *list2);
    GSList* g_slist_remove (GSList *list,
                    gpointer data);
    GSList* g_slist_remove_all (GSList *list,
                    gpointer data);
    GSList* g_slist_remove_link (GSList *list,
                    GSList *link_);
    GSList* g_slist_delete_link (GSList *list,
                    GSList *link_);
    GSList* g_slist_reverse (GSList *list);
    GSList* g_slist_copy (GSList *list);
    GSList* g_slist_nth (GSList *list,
                    guint n);
    GSList* g_slist_find (GSList *list,
                    gpointer data);
    GSList* g_slist_find_custom (GSList *list,
                    gpointer data,
                    GCompareFunc func);
    gint g_slist_position (GSList *list,
                    GSList *llink);
    gint g_slist_index (GSList *list,
                    gpointer data);
    GSList* g_slist_last (GSList *list);
    guint g_slist_length (GSList *list);
    void g_slist_foreach (GSList *list,
                    GFunc func,
                    gpointer user_data);
    GSList* g_slist_sort (GSList *list,
                    GCompareFunc compare_func);
    GSList* g_slist_sort_with_data (GSList *list,
                    GCompareDataFunc compare_func,
                    gpointer user_data);
    gpointer g_slist_nth_data (GSList *list,
                    guint n);







    alias _GMainContext GMainContext;
    alias void _GMainContext;

    alias _GMainLoop GMainLoop;
    alias void _GMainLoop;

    alias _GSource GSource;

    alias _GSourceCallbackFuncs GSourceCallbackFuncs;

    alias _GSourceFuncs GSourceFuncs;


    alias gboolean (*GSourceFunc) (gpointer data);
    alias void (*GChildWatchFunc) (GPid pid,
                    gint status,
                    gpointer data);
    struct _GSource {

    gpointer callback_data;
    GSourceCallbackFuncs *callback_funcs;

    GSourceFuncs *source_funcs;
    guint ref_count;

    GMainContext *context;

    gint priority;
    guint flags;
    guint source_id;

    GSList *poll_fds;

    GSource *prev;
    GSource *next;

    gpointer reserved1;
    gpointer reserved2;
    }

    struct _GSourceCallbackFuncs {
    void (*ref) (gpointer cb_data);
    void (*unref) (gpointer cb_data);
    void (*get) (gpointer cb_data,
            GSource *source,
            GSourceFunc *func,
            gpointer *data);
    }

    alias void (*GSourceDummyMarshal) ();

    struct _GSourceFuncs {
    gboolean (*prepare) (GSource *source,
                gint *timeout_);
    gboolean (*check) (GSource *source);
    gboolean (*dispatch) (GSource *source,
                GSourceFunc callback,
                gpointer user_data);
    void (*finalize) (GSource *source);


    GSourceFunc closure_callback;
    GSourceDummyMarshal closure_marshal;
    }
    alias _GPollFD GPollFD;

    alias gint (*GPollFunc) (GPollFD *ufds,
                    guint nfsd,
                    gint timeout_);

    struct _GPollFD {
    gint fd;
    gushort events;
    gushort revents;
    }
    GMainContext *g_main_context_new ();
    void g_main_context_ref (GMainContext *context);
    void g_main_context_unref (GMainContext *context);
    GMainContext *g_main_context_default ();

    gboolean g_main_context_iteration (GMainContext *context,
                        gboolean may_block);
    gboolean g_main_context_pending (GMainContext *context);



    GSource *g_main_context_find_source_by_id (GMainContext *context,
                                guint source_id);
    GSource *g_main_context_find_source_by_user_data (GMainContext *context,
                                gpointer user_data);
    GSource *g_main_context_find_source_by_funcs_user_data (GMainContext *context,
                                GSourceFuncs *funcs,
                                gpointer user_data);



    void g_main_context_wakeup (GMainContext *context);
    gboolean g_main_context_acquire (GMainContext *context);
    void g_main_context_release (GMainContext *context);
    gboolean g_main_context_wait (GMainContext *context,
                    GCond *cond,
                    GMutex *mutex);

    gboolean g_main_context_prepare (GMainContext *context,
                    gint *priority);
    gint g_main_context_query (GMainContext *context,
                    gint max_priority,
                    gint *timeout_,
                    GPollFD *fds,
                    gint n_fds);
    gint g_main_context_check (GMainContext *context,
                    gint max_priority,
                    GPollFD *fds,
                    gint n_fds);
    void g_main_context_dispatch (GMainContext *context);

    void g_main_context_set_poll_func (GMainContext *context,
                        GPollFunc func);
    GPollFunc g_main_context_get_poll_func (GMainContext *context);



    void g_main_context_add_poll (GMainContext *context,
                    GPollFD *fd,
                    gint priority);
    void g_main_context_remove_poll (GMainContext *context,
                    GPollFD *fd);

    int g_main_depth ();



    GMainLoop *g_main_loop_new (GMainContext *context,
                    gboolean is_running);
    void g_main_loop_run (GMainLoop *loop);
    void g_main_loop_quit (GMainLoop *loop);
    GMainLoop *g_main_loop_ref (GMainLoop *loop);
    void g_main_loop_unref (GMainLoop *loop);
    gboolean g_main_loop_is_running (GMainLoop *loop);
    GMainContext *g_main_loop_get_context (GMainLoop *loop);



    GSource *g_source_new (GSourceFuncs *source_funcs);
    GSource *g_source_ref (GSource *source);
    void g_source_unref (GSource *source);

    guint g_source_attach (GSource *source,
                    GMainContext *context);
    void g_source_destroy (GSource *source);

    void g_source_set_priority (GSource *source,
                    gint priority);
    gint g_source_get_priority (GSource *source);
    void g_source_set_can_recurse (GSource *source,
                    gboolean can_recurse);
    gboolean g_source_get_can_recurse (GSource *source);
    guint g_source_get_id (GSource *source);

    GMainContext *g_source_get_context (GSource *source);

    void g_source_set_callback (GSource *source,
                    GSourceFunc func,
                    gpointer data,
                    GDestroyNotify notify);



    void g_source_set_callback_indirect (GSource *source,
                    gpointer callback_data,
                    GSourceCallbackFuncs *callback_funcs);

    void g_source_add_poll (GSource *source,
                    GPollFD *fd);
    void g_source_remove_poll (GSource *source,
                    GPollFD *fd);

    void g_source_get_current_time (GSource *source,
                    GTimeVal *timeval);







    GSource *g_idle_source_new ();
    GSource *g_child_watch_source_new (GPid pid);
    GSource *g_timeout_source_new (guint interval);



    void g_get_current_time (GTimeVal *result);
    gboolean g_source_remove (guint tag);
    gboolean g_source_remove_by_user_data (gpointer user_data);
    gboolean g_source_remove_by_funcs_user_data (GSourceFuncs *funcs,
                        gpointer user_data);


    guint g_timeout_add_full (gint priority,
                    guint interval,
                    GSourceFunc Function,
                    gpointer data,
                    GDestroyNotify notify);
    guint g_timeout_add (guint interval,
                    GSourceFunc Function,
                    gpointer data);
    guint g_child_watch_add_full (gint priority,
                    GPid pid,
                    GChildWatchFunc Function,
                    gpointer data,
                    GDestroyNotify notify);
    guint g_child_watch_add (GPid pid,
                    GChildWatchFunc Function,
                    gpointer data);
    guint g_idle_add (GSourceFunc Function,
                    gpointer data);
    guint g_idle_add_full (gint priority,
                    GSourceFunc Function,
                    gpointer data,
                    GDestroyNotify notify);
    gboolean g_idle_remove_by_data (gpointer data);


    GSourceFuncs g_timeout_funcs;
    GSourceFuncs g_child_watch_funcs;
    GSourceFuncs g_idle_funcs;




    alias guint32 gunichar;
    alias guint16 gunichar2;




    enum GUnicodeType {
    G_UNICODE_CONTROL,
    G_UNICODE_FORMAT,
    G_UNICODE_UNASSIGNED,
    G_UNICODE_PRIVATE_USE,
    G_UNICODE_SURROGATE,
    G_UNICODE_LOWERCASE_LETTER,
    G_UNICODE_MODIFIER_LETTER,
    G_UNICODE_OTHER_LETTER,
    G_UNICODE_TITLECASE_LETTER,
    G_UNICODE_UPPERCASE_LETTER,
    G_UNICODE_COMBINING_MARK,
    G_UNICODE_ENCLOSING_MARK,
    G_UNICODE_NON_SPACING_MARK,
    G_UNICODE_DECIMAL_NUMBER,
    G_UNICODE_LETTER_NUMBER,
    G_UNICODE_OTHER_NUMBER,
    G_UNICODE_CONNECT_PUNCTUATION,
    G_UNICODE_DASH_PUNCTUATION,
    G_UNICODE_CLOSE_PUNCTUATION,
    G_UNICODE_FINAL_PUNCTUATION,
    G_UNICODE_INITIAL_PUNCTUATION,
    G_UNICODE_OTHER_PUNCTUATION,
    G_UNICODE_OPEN_PUNCTUATION,
    G_UNICODE_CURRENCY_SYMBOL,
    G_UNICODE_MODIFIER_SYMBOL,
    G_UNICODE_MATH_SYMBOL,
    G_UNICODE_OTHER_SYMBOL,
    G_UNICODE_LINE_SEPARATOR,
    G_UNICODE_PARAGRAPH_SEPARATOR,
    G_UNICODE_SPACE_SEPARATOR
    };





    enum GUnicodeBreakType {
    G_UNICODE_BREAK_MANDATORY,
    G_UNICODE_BREAK_CARRIAGE_RETURN,
    G_UNICODE_BREAK_LINE_FEED,
    G_UNICODE_BREAK_COMBINING_MARK,
    G_UNICODE_BREAK_SURROGATE,
    G_UNICODE_BREAK_ZERO_WIDTH_SPACE,
    G_UNICODE_BREAK_INSEPARABLE,
    G_UNICODE_BREAK_NON_BREAKING_GLUE,
    G_UNICODE_BREAK_CONTINGENT,
    G_UNICODE_BREAK_SPACE,
    G_UNICODE_BREAK_AFTER,
    G_UNICODE_BREAK_BEFORE,
    G_UNICODE_BREAK_BEFORE_AND_AFTER,
    G_UNICODE_BREAK_HYPHEN,
    G_UNICODE_BREAK_NON_STARTER,
    G_UNICODE_BREAK_OPEN_PUNCTUATION,
    G_UNICODE_BREAK_CLOSE_PUNCTUATION,
    G_UNICODE_BREAK_QUOTATION,
    G_UNICODE_BREAK_EXCLAMATION,
    G_UNICODE_BREAK_IDEOGRAPHIC,
    G_UNICODE_BREAK_NUMERIC,
    G_UNICODE_BREAK_INFIX_SEPARATOR,
    G_UNICODE_BREAK_SYMBOL,
    G_UNICODE_BREAK_ALPHABETIC,
    G_UNICODE_BREAK_PREFIX,
    G_UNICODE_BREAK_POSTFIX,
    G_UNICODE_BREAK_COMPLEX_CONTEXT,
    G_UNICODE_BREAK_AMBIGUOUS,
    G_UNICODE_BREAK_UNKNOWN,
    G_UNICODE_BREAK_NEXT_LINE,
    G_UNICODE_BREAK_WORD_JOINER
    };








    gboolean g_get_charset ( char **charset);



    gboolean g_unichar_isalnum (gunichar c) ;
    gboolean g_unichar_isalpha (gunichar c) ;
    gboolean g_unichar_iscntrl (gunichar c) ;
    gboolean g_unichar_isdigit (gunichar c) ;
    gboolean g_unichar_isgraph (gunichar c) ;
    gboolean g_unichar_islower (gunichar c) ;
    gboolean g_unichar_isprint (gunichar c) ;
    gboolean g_unichar_ispunct (gunichar c) ;
    gboolean g_unichar_isspace (gunichar c) ;
    gboolean g_unichar_isupper (gunichar c) ;
    gboolean g_unichar_isxdigit (gunichar c) ;
    gboolean g_unichar_istitle (gunichar c) ;
    gboolean g_unichar_isdefined (gunichar c) ;
    gboolean g_unichar_iswide (gunichar c) ;



    gunichar g_unichar_toupper (gunichar c) ;
    gunichar g_unichar_tolower (gunichar c) ;
    gunichar g_unichar_totitle (gunichar c) ;



    gint g_unichar_digit_value (gunichar c) ;

    gint g_unichar_xdigit_value (gunichar c) ;


    GUnicodeType g_unichar_type (gunichar c) ;


    GUnicodeBreakType g_unichar_break_type (gunichar c) ;





    void g_unicode_canonical_ordering (gunichar *string,
                    gsize len);




    gunichar *g_unicode_canonical_decomposition (gunichar ch,
                        gsize *result_len);



    gchar * g_utf8_skip;



    gunichar g_utf8_get_char ( gchar *p);
    gunichar g_utf8_get_char_validated ( gchar *p,
                    gssize max_len);

    gchar* g_utf8_offset_to_pointer ( gchar *str,
                    glong offset);
    glong g_utf8_pointer_to_offset ( gchar *str,
                    gchar *pos);
    gchar* g_utf8_prev_char ( gchar *p);
    gchar* g_utf8_find_next_char ( gchar *p,
                    gchar *end);
    gchar* g_utf8_find_prev_char ( gchar *str,
                    gchar *p);

    glong g_utf8_strlen ( gchar *p,
            gssize max);


    gchar* g_utf8_strncpy (gchar *dest,
                gchar *src,
            gsize n);



    gchar* g_utf8_strchr ( gchar *p,
            gssize len,
            gunichar c);
    gchar* g_utf8_strrchr ( gchar *p,
            gssize len,
            gunichar c);
    gchar* g_utf8_strreverse ( gchar *str,
                gssize len);

    gunichar2 *g_utf8_to_utf16 ( gchar *str,
                    glong len,
                    glong *items_read,
                    glong *items_written,
                    GError **error);
    gunichar * g_utf8_to_ucs4 ( gchar *str,
                    glong len,
                    glong *items_read,
                    glong *items_written,
                    GError **error);
    gunichar * g_utf8_to_ucs4_fast ( gchar *str,
                    glong len,
                    glong *items_written);
    gunichar * g_utf16_to_ucs4 ( gunichar2 *str,
                    glong len,
                    glong *items_read,
                    glong *items_written,
                    GError **error);
    gchar* g_utf16_to_utf8 ( gunichar2 *str,
                    glong len,
                    glong *items_read,
                    glong *items_written,
                    GError **error);
    gunichar2 *g_ucs4_to_utf16 ( gunichar *str,
                    glong len,
                    glong *items_read,
                    glong *items_written,
                    GError **error);
    gchar* g_ucs4_to_utf8 ( gunichar *str,
                    glong len,
                    glong *items_read,
                    glong *items_written,
                    GError **error);





    gint g_unichar_to_utf8 (gunichar c,
                gchar *outbuf);





    gboolean g_utf8_validate ( gchar *str,
                gssize max_len,
                gchar **end);


    gboolean g_unichar_validate (gunichar ch);

    gchar *g_utf8_strup ( gchar *str,
            gssize len);
    gchar *g_utf8_strdown ( gchar *str,
            gssize len);
    gchar *g_utf8_casefold ( gchar *str,
                gssize len);

    enum GNormalizeMode {
    G_NORMALIZE_DEFAULT,
    G_NORMALIZE_NFD = G_NORMALIZE_DEFAULT,
    G_NORMALIZE_DEFAULT_COMPOSE,
    G_NORMALIZE_NFC = G_NORMALIZE_DEFAULT_COMPOSE,
    G_NORMALIZE_ALL,
    G_NORMALIZE_NFKD = G_NORMALIZE_ALL,
    G_NORMALIZE_ALL_COMPOSE,
    G_NORMALIZE_NFKC = G_NORMALIZE_ALL_COMPOSE
    };


    gchar *g_utf8_normalize ( gchar *str,
                gssize len,
                GNormalizeMode mode);

    gint g_utf8_collate ( gchar *str1,
                gchar *str2);
    gchar *g_utf8_collate_key ( gchar *str,
                gssize len);

    gboolean g_unichar_get_mirror_char (gunichar ch,
                    gunichar *mirrored_ch);


    //alias __builtin_va_list __gnuc_va_list;
    alias void* va_list;


    gchar* g_get_user_name ();
    gchar* g_get_real_name ();
    gchar* g_get_home_dir ();
    gchar* g_get_tmp_dir ();
    gchar* g_get_prgname ();
    void g_set_prgname ( gchar *prgname);
    gchar* g_get_application_name ();
    void g_set_application_name ( gchar *application_name);


    alias _GDebugKey GDebugKey;

    struct _GDebugKey {
    gchar *key;
    guint value;
    }



    guint g_parse_debug_string ( gchar *string,
                        GDebugKey *keys,
                        guint nkeys);

    gint g_snprintf (gchar *string,
                        gulong n,
                        gchar  *format,
                        ...) ;
    gint g_vsnprintf (gchar *string,
                        gulong n,
                        gchar  *format,
                        va_list args);


    gboolean g_path_is_absolute ( gchar *file_name);


    gchar* g_path_skip_root ( gchar *file_name);







    gchar* g_basename ( gchar *file_name);





    gchar* g_get_current_dir ();
    gchar* g_path_get_basename ( gchar *file_name);
    gchar* g_path_get_dirname ( gchar *file_name);



    void g_nullify_pointer (gpointer *nullify_location);



    gchar* g_getenv ( gchar *variable);
    gboolean g_setenv ( gchar *variable,
                        gchar *value,
                        gboolean overwrite);
    void g_unsetenv ( gchar *variable);






    alias void (*GVoidFunc) ();
    void g_atexit (GVoidFunc func);


    gchar* g_find_program_in_path ( gchar *program);



    gint g_bit_nth_lsf (gulong mask,
                    gint nth_bit);
    gint g_bit_nth_msf (gulong mask,
                    gint nth_bit);
    guint g_bit_storage (gulong number);




    alias _GTrashStack GTrashStack;

    struct _GTrashStack {
    GTrashStack *next;
    }

    void g_trash_stack_push (GTrashStack **stack_p,
                            gpointer data_p);
    gpointer g_trash_stack_pop (GTrashStack **stack_p);
    gpointer g_trash_stack_peek (GTrashStack **stack_p);
    guint g_trash_stack_height (GTrashStack **stack_p);
    guint glib_major_version;
    guint glib_minor_version;
    guint glib_micro_version;
    guint glib_interface_age;
    guint glib_binary_age;











    alias _GString GString;

    alias _GStringChunk GStringChunk;
    alias void _GStringChunk;

    struct _GString {
    gchar *str;
    gsize len;
    gsize allocated_len;
    }



    GStringChunk* g_string_chunk_new (gsize size);
    void g_string_chunk_free (GStringChunk *chunk);
    gchar* g_string_chunk_insert (GStringChunk *chunk,
                        gchar *string);
    gchar* g_string_chunk_insert_len (GStringChunk *chunk,
                        gchar *string,
                        gssize len);
    gchar* g_string_chunk_insert_ (GStringChunk *chunk,
                        gchar *string);




    GString* g_string_new ( gchar *init);
    GString* g_string_new_len ( gchar *init,
                        gssize len);
    GString* g_string_sized_new (gsize dfl_size);
    gchar* g_string_free (GString *string,
                        gboolean free_segment);
    gboolean g_string_equal ( GString *v,
                        GString *v2);
    guint g_string_hash ( GString *str);
    GString* g_string_assign (GString *string,
                        gchar *rval);
    GString* g_string_truncate (GString *string,
                        gsize len);
    GString* g_string_set_size (GString *string,
                        gsize len);
    GString* g_string_insert_len (GString *string,
                        gssize pos,
                        gchar *val,
                        gssize len);
    GString* g_string_append (GString *string,
                        gchar *val);
    GString* g_string_append_len (GString *string,
                        gchar *val,
                        gssize len);
    GString* g_string_append_c (GString *string,
                        gchar c);
    GString* g_string_append_unichar (GString *string,
                        gunichar wc);
    GString* g_string_prepend (GString *string,
                        gchar *val);
    GString* g_string_prepend_c (GString *string,
                        gchar c);
    GString* g_string_prepend_unichar (GString *string,
                        gunichar wc);
    GString* g_string_prepend_len (GString *string,
                        gchar *val,
                        gssize len);
    GString* g_string_insert (GString *string,
                        gssize pos,
                        gchar *val);
    GString* g_string_insert_c (GString *string,
                        gssize pos,
                        gchar c);
    GString* g_string_insert_unichar (GString *string,
                        gssize pos,
                        gunichar wc);
    GString* g_string_erase (GString *string,
                        gssize pos,
                        gssize len);
    GString* g_string_ascii_down (GString *string);
    GString* g_string_ascii_up (GString *string);
    void g_string_printf (GString *string,
                        gchar *format,
                        ...) ;
    void g_string_append_printf (GString *string,
                        gchar *format,
                        ...) ;
    GString* g_string_down (GString *string);
    GString* g_string_up (GString *string);














    alias _GIOChannel GIOChannel;

    alias _GIOFuncs GIOFuncs;


    enum GIOError {
    G_IO_ERROR_NONE,
    G_IO_ERROR_AGAIN,
    G_IO_ERROR_INVAL,
    G_IO_ERROR_UNKNOWN
    };




    enum GIOChannelError {

    G_IO_CHANNEL_ERROR_FBIG,
    G_IO_CHANNEL_ERROR_INVAL,
    G_IO_CHANNEL_ERROR_IO,
    G_IO_CHANNEL_ERROR_ISDIR,
    G_IO_CHANNEL_ERROR_NOSPC,
    G_IO_CHANNEL_ERROR_NXIO,
    G_IO_CHANNEL_ERROR_OVERFLOW,
    G_IO_CHANNEL_ERROR_PIPE,

    G_IO_CHANNEL_ERROR_FAILED
    };


    enum GIOStatus {
    G_IO_STATUS_ERROR,
    G_IO_STATUS_NORMAL,
    G_IO_STATUS_EOF,
    G_IO_STATUS_AGAIN
    };


    enum GSeekType {
    G_SEEK_CUR,
    G_SEEK_SET,
    G_SEEK_END
    };


    enum GIOCondition {
    G_IO_IN =1,
    G_IO_OUT =4,
    G_IO_PRI =2,
    G_IO_ERR =8,
    G_IO_HUP =16,
    G_IO_NVAL =32
    };


    enum GIOFlags {
    G_IO_FLAG_APPEND = 1 << 0,
    G_IO_FLAG_NONBLOCK = 1 << 1,
    G_IO_FLAG_IS_READABLE = 1 << 2,
    G_IO_FLAG_IS_WRITEABLE = 1 << 3,
    G_IO_FLAG_IS_SEEKABLE = 1 << 4,
    G_IO_FLAG_MASK = (1 << 5) - 1,
    G_IO_FLAG_GET_MASK = G_IO_FLAG_MASK,
    G_IO_FLAG_SET_MASK = G_IO_FLAG_APPEND | G_IO_FLAG_NONBLOCK
    };


    struct _GIOChannel {

    guint ref_count;
    GIOFuncs *funcs;

    gchar *encoding;
    GIConv read_cd;
    GIConv write_cd;
    gchar *line_term;
    guint line_term_len;

    gsize buf_size;
    GString *read_buf;
    GString *encoded_read_buf;
    GString *write_buf;
    gchar partial_write_buf[6];



    guint use_buffer;
    guint do_encode;
    guint close_on_unref;
    guint is_readable;
    guint is_writeable;
    guint is_seekable;

    gpointer reserved1;
    gpointer reserved2;
    }

    alias gboolean (*GIOFunc) (GIOChannel *source,
                GIOCondition condition,
                gpointer data);
    struct _GIOFuncs {
    GIOStatus (*io_read) (GIOChannel *channel,
                    gchar *buf,
                    gsize count,
                    gsize *bytes_read,
                    GError **err);
    GIOStatus (*io_write) (GIOChannel *channel,
                    gchar *buf,
                    gsize count,
                    gsize *bytes_written,
                    GError **err);
    GIOStatus (*io_seek) (GIOChannel *channel,
                    gint64 offset,
                    GSeekType type,
                    GError **err);
    GIOStatus (*io_close) (GIOChannel *channel,
                    GError **err);
    GSource* (*io_create_watch) (GIOChannel *channel,
                    GIOCondition condition);
    void (*io_free) (GIOChannel *channel);
    GIOStatus (*io_set_flags) (GIOChannel *channel,
                    GIOFlags flags,
                    GError **err);
    GIOFlags (*io_get_flags) (GIOChannel *channel);
    }

    void g_io_channel_init (GIOChannel *channel);
    void g_io_channel_ref (GIOChannel *channel);
    void g_io_channel_unref (GIOChannel *channel);


    GIOError g_io_channel_read (GIOChannel *channel,
                    gchar *buf,
                    gsize count,
                    gsize *bytes_read);
    GIOError g_io_channel_write (GIOChannel *channel,
                    gchar *buf,
                    gsize count,
                    gsize *bytes_written);
    GIOError g_io_channel_seek (GIOChannel *channel,
                    gint64 offset,
                    GSeekType type);
    void g_io_channel_close (GIOChannel *channel);


    GIOStatus g_io_channel_shutdown (GIOChannel *channel,
                    gboolean flush,
                    GError **err);
    guint g_io_add_watch_full (GIOChannel *channel,
                    gint priority,
                    GIOCondition condition,
                    GIOFunc func,
                    gpointer user_data,
                    GDestroyNotify notify);
    GSource * g_io_create_watch (GIOChannel *channel,
                    GIOCondition condition);
    guint g_io_add_watch (GIOChannel *channel,
                    GIOCondition condition,
                    GIOFunc func,
                    gpointer user_data);




    void g_io_channel_set_buffer_size (GIOChannel *channel,
                                gsize size);
    gsize g_io_channel_get_buffer_size (GIOChannel *channel);
    GIOCondition g_io_channel_get_buffer_condition (GIOChannel *channel);
    GIOStatus g_io_channel_set_flags (GIOChannel *channel,
                                GIOFlags flags,
                                GError **error);
    GIOFlags g_io_channel_get_flags (GIOChannel *channel);
    void g_io_channel_set_line_term (GIOChannel *channel,
                                gchar *line_term,
                                gint length);
    gchar* g_io_channel_get_line_term (GIOChannel *channel,
                                gint *length);
    void g_io_channel_set_buffered (GIOChannel *channel,
                                gboolean buffered);
    gboolean g_io_channel_get_buffered (GIOChannel *channel);
    GIOStatus g_io_channel_set_encoding (GIOChannel *channel,
                                gchar *encoding,
                                GError **error);
    gchar* g_io_channel_get_encoding (GIOChannel *channel);
    void g_io_channel_set_close_on_unref (GIOChannel *channel,
                                gboolean do_close);
    gboolean g_io_channel_get_close_on_unref (GIOChannel *channel);


    GIOStatus g_io_channel_flush (GIOChannel *channel,
                        GError **error);
    GIOStatus g_io_channel_read_line (GIOChannel *channel,
                        gchar **str_return,
                        gsize *length,
                        gsize *terminator_pos,
                        GError **error);
    GIOStatus g_io_channel_read_line_string (GIOChannel *channel,
                        GString *buffer,
                        gsize *terminator_pos,
                        GError **error);
    GIOStatus g_io_channel_read_to_end (GIOChannel *channel,
                        gchar **str_return,
                        gsize *length,
                        GError **error);
    GIOStatus g_io_channel_read_chars (GIOChannel *channel,
                        gchar *buf,
                        gsize count,
                        gsize *bytes_read,
                        GError **error);
    GIOStatus g_io_channel_read_unichar (GIOChannel *channel,
                        gunichar *thechar,
                        GError **error);
    GIOStatus g_io_channel_write_chars (GIOChannel *channel,
                        gchar *buf,
                        gssize count,
                        gsize *bytes_written,
                        GError **error);
    GIOStatus g_io_channel_write_unichar (GIOChannel *channel,
                        gunichar thechar,
                        GError **error);
    GIOStatus g_io_channel_seek_position (GIOChannel *channel,
                        gint64 offset,
                        GSeekType type,
                        GError **error);
    GIOChannel* g_io_channel_new_file ( gchar *filename,
                        gchar *mode,
                        GError **error);



    GQuark g_io_channel_error_quark ();
    GIOChannelError g_io_channel_error_from_errno (gint en);
    GIOChannel* g_io_channel_unix_new (int fd);
    gint g_io_channel_unix_get_fd (GIOChannel *channel);



    GSourceFuncs g_io_watch_funcs;






    enum GMarkupError {
    G_MARKUP_ERROR_BAD_UTF8,
    G_MARKUP_ERROR_EMPTY,
    G_MARKUP_ERROR_PARSE,



    G_MARKUP_ERROR_UNKNOWN_ELEMENT,
    G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
    G_MARKUP_ERROR_INVALID_CONTENT
    };




    GQuark g_markup_error_quark ();

    enum GMarkupParseFlags {

    G_MARKUP_DO_NOT_USE_THIS_UNSUPPORTED_FLAG = 1 << 0

    };


    alias _GMarkupParseContext GMarkupParseContext;
    alias void _GMarkupParseContext;

    alias _GMarkupParser GMarkupParser;


    struct _GMarkupParser {

    void (*start_element) (GMarkupParseContext *context,
                gchar *element_name,
                gchar **attribute_names,
                gchar **attribute_values,
                gpointer user_data,
                GError **error);


    void (*end_element) (GMarkupParseContext *context,
                gchar *element_name,
                gpointer user_data,
                GError **error);



    void (*text) (GMarkupParseContext *context,
                gchar *text,
                gsize text_len,
                gpointer user_data,
                GError **error);






    void (*passthrough) (GMarkupParseContext *context,
                gchar *passthrough_text,
                gsize text_len,
                gpointer user_data,
                GError **error);




    void (*error) (GMarkupParseContext *context,
                GError *error,
                gpointer user_data);
    }

    GMarkupParseContext *g_markup_parse_context_new ( GMarkupParser *parser,
                            GMarkupParseFlags flags,
                            gpointer user_data,
                            GDestroyNotify user_data_dnotify);
    void g_markup_parse_context_free (GMarkupParseContext *context);
    gboolean g_markup_parse_context_parse (GMarkupParseContext *context,
                            gchar *text,
                            gssize text_len,
                            GError **error);

    gboolean g_markup_parse_context_end_parse (GMarkupParseContext *context,
                            GError **error);
    gchar *g_markup_parse_context_get_element (GMarkupParseContext *context);


    void g_markup_parse_context_get_position (GMarkupParseContext *context,
                                gint *line_number,
                                gint *char_number);


    gchar* g_markup_escape_text ( gchar *text,
                gssize length);

    gchar *g_markup_printf_escaped ( char *format,
                    ...) ;
    gchar *g_markup_vprintf_escaped ( char *format,
                    va_list args);










    gsize g_printf_string_upper_bound ( gchar* format,
                    va_list args);
    enum GLogLevelFlags {

    G_LOG_FLAG_RECURSION = 1 << 0,
    G_LOG_FLAG_FATAL = 1 << 1,


    G_LOG_LEVEL_ERROR = 1 << 2,
    G_LOG_LEVEL_CRITICAL = 1 << 3,
    G_LOG_LEVEL_WARNING = 1 << 4,
    G_LOG_LEVEL_MESSAGE = 1 << 5,
    G_LOG_LEVEL_INFO = 1 << 6,
    G_LOG_LEVEL_DEBUG = 1 << 7,

    G_LOG_LEVEL_MASK = ~(G_LOG_FLAG_RECURSION | G_LOG_FLAG_FATAL)
    };





    alias void (*GLogFunc) (gchar *log_domain,
                            GLogLevelFlags log_level,
                            gchar *message,
                            gpointer user_data);



    guint g_log_set_handler ( gchar *log_domain,
                        GLogLevelFlags log_levels,
                        GLogFunc log_func,
                        gpointer user_data);
    void g_log_remove_handler ( gchar *log_domain,
                        guint handler_id);
    void g_log_default_handler ( gchar *log_domain,
                        GLogLevelFlags log_level,
                        gchar *message,
                        gpointer unused_data);
    void g_log ( gchar *log_domain,
                        GLogLevelFlags log_level,
                        gchar *format,
                        ...) ;
    void g_logv ( gchar *log_domain,
                        GLogLevelFlags log_level,
                        gchar *format,
                        va_list args);
    GLogLevelFlags g_log_set_fatal_mask ( gchar *log_domain,
                        GLogLevelFlags fatal_mask);
    GLogLevelFlags g_log_set_always_fatal (GLogLevelFlags fatal_mask);


    void _g_log_fallback_handler ( gchar *log_domain,
                    GLogLevelFlags log_level,
                    gchar *message,
                    gpointer unused_data);
    alias void (*GPrintFunc) (gchar *string);
    void g_print ( gchar *format,
                        ...) ;
    GPrintFunc g_set_print_handler (GPrintFunc func);
    void g_printerr ( gchar *format,
                        ...) ;
    GPrintFunc g_set_printerr_handler (GPrintFunc func);



    alias _GNode GNode;



    enum GTraverseFlags {
    G_TRAVERSE_LEAFS = 1 << 0,
    G_TRAVERSE_NON_LEAFS = 1 << 1,
    G_TRAVERSE_ALL = G_TRAVERSE_LEAFS | G_TRAVERSE_NON_LEAFS,
    G_TRAVERSE_MASK = 0x03
    };



    enum GTraverseType {
    G_IN_ORDER,
    G_PRE_ORDER,
    G_POST_ORDER,
    G_LEVEL_ORDER
    };


    alias gboolean (*GNodeTraverseFunc) (GNode *node,
                            gpointer data);
    alias void (*GNodeForeachFunc) (GNode *node,
                            gpointer data);
    alias gpointer (*GCopyFunc) (gpointer src,
                            gpointer data);



    struct _GNode {
    gpointer data;
    GNode *next;
    GNode *prev;
    GNode *parent;
    GNode *children;
    }






    void g_node_push_allocator (GAllocator *allocator);
    void g_node_pop_allocator ();
    GNode* g_node_new (gpointer data);
    void g_node_destroy (GNode *root);
    void g_node_unlink (GNode *node);
    GNode* g_node_copy_deep (GNode *node,
                    GCopyFunc copy_func,
                    gpointer data);
    GNode* g_node_copy (GNode *node);
    GNode* g_node_insert (GNode *parent,
                    gint position,
                    GNode *node);
    GNode* g_node_insert_before (GNode *parent,
                    GNode *sibling,
                    GNode *node);
    GNode* g_node_insert_after (GNode *parent,
                    GNode *sibling,
                    GNode *node);
    GNode* g_node_prepend (GNode *parent,
                    GNode *node);
    guint g_node_n_nodes (GNode *root,
                    GTraverseFlags flags);
    GNode* g_node_get_root (GNode *node);
    gboolean g_node_is_ancestor (GNode *node,
                    GNode *descendant);
    guint g_node_depth (GNode *node);
    GNode* g_node_find (GNode *root,
                    GTraverseType order,
                    GTraverseFlags flags,
                    gpointer data);
    void g_node_traverse (GNode *root,
                    GTraverseType order,
                    GTraverseFlags flags,
                    gint max_depth,
                    GNodeTraverseFunc func,
                    gpointer data);






    guint g_node_max_height (GNode *root);

    void g_node_children_foreach (GNode *node,
                    GTraverseFlags flags,
                    GNodeForeachFunc func,
                    gpointer data);
    void g_node_reverse_children (GNode *node);
    guint g_node_n_children (GNode *node);
    GNode* g_node_nth_child (GNode *node,
                    guint n);
    GNode* g_node_last_child (GNode *node);
    GNode* g_node_find_child (GNode *node,
                    GTraverseFlags flags,
                    gpointer data);
    gint g_node_child_position (GNode *node,
                    GNode *child);
    gint g_node_child_index (GNode *node,
                    gpointer data);

    GNode* g_node_first_sibling (GNode *node);
    GNode* g_node_last_sibling (GNode *node);




    alias _GPatternSpec GPatternSpec;
    alias void _GPatternSpec;


    GPatternSpec* g_pattern_spec_new ( gchar *pattern);
    void g_pattern_spec_free (GPatternSpec *pspec);
    gboolean g_pattern_spec_equal (GPatternSpec *pspec1,
                        GPatternSpec *pspec2);
    gboolean g_pattern_match (GPatternSpec *pspec,
                        guint string_length,
                        gchar *string,
                        gchar *string_reversed);
    gboolean g_pattern_match_string (GPatternSpec *pspec,
                        gchar *string);
    gboolean g_pattern_match_simple ( gchar *pattern,
                        gchar *string);



    guint g_spaced_primes_closest (guint num) ;




    void g_qsort_with_data (gpointer pbase,
                gint total_elems,
                gsize size,
                GCompareDataFunc compare_func,
                gpointer user_data);





    alias _GQueue GQueue;


    struct _GQueue {
    GList *head;
    GList *tail;
    guint length;
    }



    GQueue* g_queue_new ();
    void g_queue_free (GQueue *queue);
    gboolean g_queue_is_empty (GQueue *queue);
    guint g_queue_get_length (GQueue *queue);
    void g_queue_reverse (GQueue *queue);
    GQueue * g_queue_copy (GQueue *queue);
    void g_queue_foreach (GQueue *queue,
                    GFunc func,
                    gpointer user_data);
    GList * g_queue_find (GQueue *queue,
                    gpointer data);
    GList * g_queue_find_custom (GQueue *queue,
                    gpointer data,
                    GCompareFunc func);
    void g_queue_sort (GQueue *queue,
                    GCompareDataFunc compare_func,
                    gpointer user_data);

    void g_queue_push_head (GQueue *queue,
                    gpointer data);
    void g_queue_push_tail (GQueue *queue,
                    gpointer data);
    void g_queue_push_nth (GQueue *queue,
                    gpointer data,
                    gint n);
    gpointer g_queue_pop_head (GQueue *queue);
    gpointer g_queue_pop_tail (GQueue *queue);
    gpointer g_queue_pop_nth (GQueue *queue,
                    guint n);
    gpointer g_queue_peek_head (GQueue *queue);
    gpointer g_queue_peek_tail (GQueue *queue);
    gpointer g_queue_peek_nth (GQueue *queue,
                    guint n);
    gint g_queue_index (GQueue *queue,
                    gpointer data);
    void g_queue_remove (GQueue *queue,
                    gpointer data);
    void g_queue_remove_all (GQueue *queue,
                    gpointer data);
    void g_queue_insert_before (GQueue *queue,
                    GList *sibling,
                    gpointer data);
    void g_queue_insert_after (GQueue *queue,
                    GList *sibling,
                    gpointer data);
    void g_queue_insert_sorted (GQueue *queue,
                    gpointer data,
                    GCompareDataFunc func,
                    gpointer user_data);

    void g_queue_push_head_link (GQueue *queue,
                    GList *link_);
    void g_queue_push_tail_link (GQueue *queue,
                    GList *link_);
    void g_queue_push_nth_link (GQueue *queue,
                    gint n,
                    GList *link_);
    GList* g_queue_pop_head_link (GQueue *queue);
    GList* g_queue_pop_tail_link (GQueue *queue);
    GList* g_queue_pop_nth_link (GQueue *queue,
                    guint n);
    GList* g_queue_peek_head_link (GQueue *queue);
    GList* g_queue_peek_tail_link (GQueue *queue);
    GList* g_queue_peek_nth_link (GQueue *queue,
                    guint n);
    gint g_queue_link_index (GQueue *queue,
                    GList *link_);
    void g_queue_unlink (GQueue *queue,
                    GList *link_);
    void g_queue_delete_link (GQueue *queue,
                    GList *link_);




    alias _GRand GRand;
    alias void _GRand;

    GRand* g_rand_new_with_seed (guint32 seed);
    GRand* g_rand_new_with_seed_array ( guint32 *seed,
                    guint seed_length);
    GRand* g_rand_new ();
    void g_rand_free (GRand *rand_);
    GRand* g_rand_copy (GRand *rand_);
    void g_rand_set_seed (GRand *rand_,
                guint32 seed);
    void g_rand_set_seed_array (GRand *rand_,
                    guint32 *seed,
                guint seed_length);



    guint32 g_rand_int (GRand *rand_);
    gint32 g_rand_int_range (GRand *rand_,
                gint32 begin,
                gint32 end);
    gdouble g_rand_double (GRand *rand_);
    gdouble g_rand_double_range (GRand *rand_,
                gdouble begin,
                gdouble end);
    void g_random_set_seed (guint32 seed);



    guint32 g_random_int ();
    gint32 g_random_int_range (gint32 begin,
                gint32 end);
    gdouble g_random_double ();
    gdouble g_random_double_range (gdouble begin,
                gdouble end);





    alias _GRelation GRelation;
    alias void _GRelation;

    alias _GTuples GTuples;


    struct _GTuples {
    guint len;
    }
    GRelation* g_relation_new (gint fields);
    void g_relation_destroy (GRelation *relation);
    void g_relation_index (GRelation *relation,
                gint field,
                GHashFunc hash_func,
                GEqualFunc key_equal_func);
    void g_relation_insert (GRelation *relation,
                ...);
    gint g_relation_delete (GRelation *relation,
                gpointer key,
                gint field);
    GTuples* g_relation_select (GRelation *relation,
                gpointer key,
                gint field);
    gint g_relation_count (GRelation *relation,
                gpointer key,
                gint field);
    gboolean g_relation_exists (GRelation *relation,
                ...);
    void g_relation_print (GRelation *relation);

    void g_tuples_destroy (GTuples *tuples);
    gpointer g_tuples_index (GTuples *tuples,
                gint index_,
                gint field);




    alias _GScanner GScanner;

    alias _GScannerConfig GScannerConfig;

    alias _GTokenValue GTokenValue;


    alias void (*GScannerMsgFunc) (GScanner *scanner,
                            gchar *message,
                            gboolean error);
    enum GErrorType {
    G_ERR_UNKNOWN,
    G_ERR_UNEXP_EOF,
    G_ERR_UNEXP_EOF_IN_STRING,
    G_ERR_UNEXP_EOF_IN_COMMENT,
    G_ERR_NON_DIGIT_IN_CONST,
    G_ERR_DIGIT_RADIX,
    G_ERR_FLOAT_RADIX,
    G_ERR_FLOAT_MALFORMED
    };



    enum GTokenType
    {
    G_TOKEN_EOF = 0,

    G_TOKEN_LEFT_PAREN = '(',
    G_TOKEN_RIGHT_PAREN = ')',
    G_TOKEN_LEFT_CURLY = '{',
    G_TOKEN_RIGHT_CURLY = '}',
    G_TOKEN_LEFT_BRACE = '[',
    G_TOKEN_RIGHT_BRACE = ']',
    G_TOKEN_EQUAL_SIGN = '=',
    G_TOKEN_COMMA = ',',

    G_TOKEN_NONE = 256,

    G_TOKEN_ERROR,

    G_TOKEN_CHAR,
    G_TOKEN_BINARY,
    G_TOKEN_OCTAL,
    G_TOKEN_INT,
    G_TOKEN_HEX,
    G_TOKEN_FLOAT,
    G_TOKEN_STRING,

    G_TOKEN_SYMBOL,
    G_TOKEN_IDENTIFIER,
    G_TOKEN_IDENTIFIER_NULL,

    G_TOKEN_COMMENT_SINGLE,
    G_TOKEN_COMMENT_MULTI,
    G_TOKEN_LAST
    }

    union _GTokenValue {
    gpointer v_symbol;
    gchar *v_identifier;
    gulong v_binary;
    gulong v_octal;
    gulong v_int;
    guint64 v_int64;
    gdouble v_float;
    gulong v_hex;
    gchar *v_string;
    gchar *v_comment;
    guchar v_char;
    guint v_error;
    }

    struct _GScannerConfig {


    gchar *cset_skip_characters;
    gchar *cset_identifier_first;
    gchar *cset_identifier_nth;
    gchar *cpair_comment_single;



    guint case_sensitive;




    guint skip_comment_multi;
    guint skip_comment_single;
    guint scan_comment_multi;
    guint scan_identifier;
    guint scan_identifier_1char;
    guint scan_identifier_NULL;
    guint scan_symbols;
    guint scan_binary;
    guint scan_octal;
    guint scan_float;
    guint scan_hex;
    guint scan_hex_dollar;
    guint scan_string_sq;
    guint scan_string_dq;
    guint numbers_2_int;
    guint int_2_float;
    guint identifier_2_string;
    guint char_2_token;
    guint symbol_2_token;
    guint scope_0_fallback;
    guint store_int64;
    guint padding_dummy;
    }

    struct _GScanner {

    gpointer user_data;
    guint max_parse_errors;


    guint parse_errors;


    gchar *input_name;


    GData *qdata;


    GScannerConfig *config;


    GTokenType token;
    GTokenValue value;
    guint line;
    guint position;


    GTokenType next_token;
    GTokenValue next_value;
    guint next_line;
    guint next_position;


    GHashTable *symbol_table;
    gint input_fd;
    gchar *text;
    gchar *text_end;
    gchar *buffer;
    guint scope_id;


    GScannerMsgFunc msg_handler;
    }

    GScanner* g_scanner_new ( GScannerConfig *config_templ);
    void g_scanner_destroy (GScanner *scanner);
    void g_scanner_input_file (GScanner *scanner,
                            gint input_fd);
    void g_scanner_sync_file_offset (GScanner *scanner);
    void g_scanner_input_text (GScanner *scanner,
                            gchar *text,
                            guint text_len);
    GTokenType g_scanner_get_next_token (GScanner *scanner);
    GTokenType g_scanner_peek_next_token (GScanner *scanner);
    GTokenType g_scanner_cur_token (GScanner *scanner);
    GTokenValue g_scanner_cur_value (GScanner *scanner);
    guint g_scanner_cur_line (GScanner *scanner);
    guint g_scanner_cur_position (GScanner *scanner);
    gboolean g_scanner_eof (GScanner *scanner);
    guint g_scanner_set_scope (GScanner *scanner,
                            guint scope_id);
    void g_scanner_scope_add_symbol (GScanner *scanner,
                            guint scope_id,
                            gchar *symbol,
                            gpointer value);
    void g_scanner_scope_remove_symbol (GScanner *scanner,
                            guint scope_id,
                            gchar *symbol);
    gpointer g_scanner_scope_lookup_symbol (GScanner *scanner,
                            guint scope_id,
                            gchar *symbol);
    void g_scanner_scope_foreach_symbol (GScanner *scanner,
                            guint scope_id,
                            GHFunc func,
                            gpointer user_data);
    gpointer g_scanner_lookup_symbol (GScanner *scanner,
                            gchar *symbol);
    void g_scanner_unexp_token (GScanner *scanner,
                            GTokenType expected_token,
                            gchar *identifier_spec,
                            gchar *symbol_spec,
                            gchar *symbol_name,
                            gchar *message,
                            gint is_error);
    void g_scanner_error (GScanner *scanner,
                            gchar *format,
                            ...) ;
    void g_scanner_warn (GScanner *scanner,
                            gchar *format,
                            ...) ;





    enum GShellError {

    G_SHELL_ERROR_BAD_QUOTING,

    G_SHELL_ERROR_EMPTY_STRING,
    G_SHELL_ERROR_FAILED
    };


    GQuark g_shell_error_quark ();

    gchar* g_shell_quote ( gchar *unquoted_string);
    gchar* g_shell_unquote ( gchar *quoted_string,
                GError **error);
    gboolean g_shell_parse_argv ( gchar *command_line,
                gint *argcp,
                gchar ***argvp,
                GError **error);








    enum GSpawnError {
    G_SPAWN_ERROR_FORK,
    G_SPAWN_ERROR_READ,
    G_SPAWN_ERROR_CHDIR,
    G_SPAWN_ERROR_ACCES,
    G_SPAWN_ERROR_PERM,
    G_SPAWN_ERROR_2BIG,
    G_SPAWN_ERROR_NOEXEC,
    G_SPAWN_ERROR_NAMETOOLONG,
    G_SPAWN_ERROR_NOENT,
    G_SPAWN_ERROR_NOMEM,
    G_SPAWN_ERROR_NOTDIR,
    G_SPAWN_ERROR_LOOP,
    G_SPAWN_ERROR_TXTBUSY,
    G_SPAWN_ERROR_IO,
    G_SPAWN_ERROR_NFILE,
    G_SPAWN_ERROR_MFILE,
    G_SPAWN_ERROR_INVAL,
    G_SPAWN_ERROR_ISDIR,
    G_SPAWN_ERROR_LIBBAD,
    G_SPAWN_ERROR_FAILED


    };


    alias void (* GSpawnChildSetupFunc) (gpointer user_data);

    enum GSpawnFlags {
    G_SPAWN_LEAVE_DESCRIPTORS_OPEN = 1 << 0,
    G_SPAWN_DO_NOT_REAP_CHILD = 1 << 1,

    G_SPAWN_SEARCH_PATH = 1 << 2,

    G_SPAWN_STDOUT_TO_DEV_NULL = 1 << 3,
    G_SPAWN_STDERR_TO_DEV_NULL = 1 << 4,
    G_SPAWN_CHILD_INHERITS_STDIN = 1 << 5,
    G_SPAWN_FILE_AND_ARGV_ZERO = 1 << 6
    };


    GQuark g_spawn_error_quark ();

    gboolean g_spawn_async ( gchar *working_directory,
                gchar **argv,
                gchar **envp,
                GSpawnFlags flags,
                GSpawnChildSetupFunc child_setup,
                gpointer user_data,
                GPid *child_pid,
                GError **error);





    gboolean g_spawn_async_with_pipes ( gchar *working_directory,
                    gchar **argv,
                    gchar **envp,
                    GSpawnFlags flags,
                    GSpawnChildSetupFunc child_setup,
                    gpointer user_data,
                    GPid *child_pid,
                    gint *standard_input,
                    gint *standard_output,
                    gint *standard_error,
                    GError **error);






    gboolean g_spawn_sync ( gchar *working_directory,
                gchar **argv,
                gchar **envp,
                GSpawnFlags flags,
                GSpawnChildSetupFunc child_setup,
                gpointer user_data,
                gchar **standard_output,
                gchar **standard_error,
                gint *exit_status,
                GError **error);

    gboolean g_spawn_command_line_sync ( gchar *command_line,
                    gchar **standard_output,
                    gchar **standard_error,
                    gint *exit_status,
                    GError **error);
    gboolean g_spawn_command_line_async ( gchar *command_line,
                    GError **error);

    void g_spawn_close_pid (GPid pid);






    enum GAsciiType {
    G_ASCII_ALNUM = 1 << 0,
    G_ASCII_ALPHA = 1 << 1,
    G_ASCII_CNTRL = 1 << 2,
    G_ASCII_DIGIT = 1 << 3,
    G_ASCII_GRAPH = 1 << 4,
    G_ASCII_LOWER = 1 << 5,
    G_ASCII_PRINT = 1 << 6,
    G_ASCII_PUNCT = 1 << 7,
    G_ASCII_SPACE = 1 << 8,
    G_ASCII_UPPER = 1 << 9,
    G_ASCII_XDIGIT = 1 << 10
    };


    guint16 * g_ascii_table;
    gchar g_ascii_tolower (gchar c) ;
    gchar g_ascii_toupper (gchar c) ;

    gint g_ascii_digit_value (gchar c) ;
    gint g_ascii_xdigit_value (gchar c) ;





    gchar* g_strdelimit (gchar *string,
                        gchar *delimiters,
                        gchar new_delimiter);
    gchar* g_strcanon (gchar *string,
                        gchar *valid_chars,
                        gchar substitutor);
    gchar* g_strerror (gint errnum) ;
    gchar* g_strsignal (gint signum) ;
    gchar* g_strreverse (gchar *string);
    gsize g_strlcpy (gchar *dest,
                        gchar *src,
                        gsize dest_size);
    gsize g_strlcat (gchar *dest,
                        gchar *src,
                        gsize dest_size);
    gchar * g_strstr_len ( gchar *haystack,
                        gssize haystack_len,
                        gchar *needle);
    gchar * g_strrstr ( gchar *haystack,
                        gchar *needle);
    gchar * g_strrstr_len ( gchar *haystack,
                        gssize haystack_len,
                        gchar *needle);

    gboolean g_str_has_suffix ( gchar *str,
                        gchar *suffix);
    gboolean g_str_has_prefix ( gchar *str,
                        gchar *prefix);



    gdouble g_strtod ( gchar *nptr,
                        gchar **endptr);
    gdouble g_ascii_strtod ( gchar *nptr,
                        gchar **endptr);
    guint64 g_ascii_strtoull ( gchar *nptr,
                        gchar **endptr,
                        guint base);




    gchar * g_ascii_dtostr (gchar *buffer,
                        gint buf_len,
                        gdouble d);
    gchar * g_ascii_formatd (gchar *buffer,
                        gint buf_len,
                        gchar *format,
                        gdouble d);


    gchar* g_strchug (gchar *string);

    gchar* g_strchomp (gchar *string);



    gint g_ascii_strcasecmp ( gchar *s1,
                        gchar *s2);
    gint g_ascii_strncasecmp ( gchar *s1,
                        gchar *s2,
                        gsize n);
    gchar* g_ascii_strdown ( gchar *str,
                        gssize len);
    gchar* g_ascii_strup ( gchar *str,
                        gssize len);
    gint g_strcasecmp ( gchar *s1,
                        gchar *s2);
    gint g_strncasecmp ( gchar *s1,
                        gchar *s2,
                        guint n);
    gchar* g_strdown (gchar *string);
    gchar* g_strup (gchar *string);






    gchar* g_strdup ( gchar *str);
    gchar* g_strdup_printf ( gchar *format,
                        ...) ;
    gchar* g_strdup_vprintf ( gchar *format,
                        va_list args);
    gchar* g_strndup ( gchar *str,
                        gsize n);
    gchar* g_strnfill (gsize length,
                        gchar fill_char);
    gchar* g_strconcat ( gchar *string1,
                        ...);
    gchar* g_strjoin ( gchar *separator,
                        ...);




    gchar* g_strcompress ( gchar *source);
    gchar* g_strescape ( gchar *source,
                        gchar *exceptions);

    gpointer g_memdup (gpointer mem,
                        guint byte_size);
    gchar** g_strsplit ( gchar *string,
                        gchar *delimiter,
                        gint max_tokens);
    gchar ** g_strsplit_set ( gchar *string,
                        gchar *delimiters,
                        gint max_tokens);
    gchar* g_strjoinv ( gchar *separator,
                        gchar **str_array);
    void g_strfreev (gchar **str_array);
    gchar** g_strdupv (gchar **str_array);

    gchar* g_stpcpy (gchar *dest,
                        char *src);

    gchar *g_strip_context ( gchar *msgid,
                        gchar *msgval);






    alias _GThreadPool GThreadPool;







    struct _GThreadPool {
    GFunc func;
    gpointer user_data;
    gboolean exclusive;
    }






    GThreadPool* g_thread_pool_new (GFunc func,
                        gpointer user_data,
                        gint max_threads,
                        gboolean exclusive,
                        GError **error);





    void g_thread_pool_push (GThreadPool *pool,
                        gpointer data,
                        GError **error);




    void g_thread_pool_set_max_threads (GThreadPool *pool,
                        gint max_threads,
                        GError **error);
    gint g_thread_pool_get_max_threads (GThreadPool *pool);



    guint g_thread_pool_get_num_threads (GThreadPool *pool);


    guint g_thread_pool_unprocessed (GThreadPool *pool);





    void g_thread_pool_free (GThreadPool *pool,
                        gboolean immediate,
                        gboolean wait);



    void g_thread_pool_set_max_unused_threads (gint max_threads);
    gint g_thread_pool_get_max_unused_threads ();
    guint g_thread_pool_get_num_unused_threads ();


    void g_thread_pool_stop_unused_threads ();

    alias _GTimer GTimer;
    alias void _GTimer;

    GTimer* g_timer_new ();
    void g_timer_destroy (GTimer *timer);
    void g_timer_start (GTimer *timer);
    void g_timer_stop (GTimer *timer);
    void g_timer_reset (GTimer *timer);
    void g_timer_continue (GTimer *timer);
    gdouble g_timer_elapsed (GTimer *timer,
                gulong *microseconds);

    void g_usleep (gulong microseconds);

    void g_time_val_add (GTimeVal *time_,
                glong microseconds);




    alias _GTree GTree;
    alias void _GTree;


    alias gboolean (*GTraverseFunc) (gpointer key,
                    gpointer value,
                    gpointer data);



    GTree* g_tree_new (GCompareFunc key_compare_func);
    GTree* g_tree_new_with_data (GCompareDataFunc key_compare_func,
                    gpointer key_compare_data);
    GTree* g_tree_new_full (GCompareDataFunc key_compare_func,
                    gpointer key_compare_data,
                    GDestroyNotify key_destroy_func,
                    GDestroyNotify value_destroy_func);
    void g_tree_destroy (GTree *tree);
    void g_tree_insert (GTree *tree,
                    gpointer key,
                    gpointer value);
    void g_tree_replace (GTree *tree,
                    gpointer key,
                    gpointer value);
    void g_tree_remove (GTree *tree,
                    gpointer key);
    void g_tree_steal (GTree *tree,
                    gpointer key);
    gpointer g_tree_lookup (GTree *tree,
                    gpointer key);
    gboolean g_tree_lookup_extended (GTree *tree,
                    gpointer lookup_key,
                    gpointer *orig_key,
                    gpointer *value);
    void g_tree_foreach (GTree *tree,
                    GTraverseFunc func,
                    gpointer user_data);


    void g_tree_traverse (GTree *tree,
                    GTraverseFunc traverse_func,
                    GTraverseType traverse_type,
                    gpointer user_data);


    gpointer g_tree_search (GTree *tree,
                    GCompareFunc search_func,
                    gpointer user_data);
    gint g_tree_height (GTree *tree);
    gint g_tree_nnodes (GTree *tree);






    alias _PangoCoverage PangoCoverage;
    alias void _PangoCoverage;


    enum PangoCoverageLevel {
    PANGO_COVERAGE_NONE,
    PANGO_COVERAGE_FALLBACK,
    PANGO_COVERAGE_APPROXIMATE,
    PANGO_COVERAGE_EXACT
    };


    PangoCoverage * pango_coverage_new ();
    PangoCoverage * pango_coverage_ref (PangoCoverage *coverage);
    void pango_coverage_unref (PangoCoverage *coverage);
    PangoCoverage * pango_coverage_copy (PangoCoverage *coverage);
    PangoCoverageLevel pango_coverage_get (PangoCoverage *coverage,
                        int index_);
    void pango_coverage_set (PangoCoverage *coverage,
                        int index_,
                        PangoCoverageLevel level);
    void pango_coverage_max (PangoCoverage *coverage,
                        PangoCoverage *other);

    void pango_coverage_to_bytes (PangoCoverage *coverage,
                        guchar **bytes,
                        int *n_bytes);
    PangoCoverage *pango_coverage_from_bytes (guchar *bytes,
                        int n_bytes);



    alias gulong GType;



    alias _GValue GValue;

    union _GTypeCValue ;
    alias _GTypeCValue GTypeCValue;

    alias _GTypePlugin GTypePlugin;
    alias void _GTypePlugin;

    alias _GTypeClass GTypeClass;

    alias _GTypeInterface GTypeInterface;

    alias _GTypeInstance GTypeInstance;

    alias _GTypeInfo GTypeInfo;

    alias _GTypeFundamentalInfo GTypeFundamentalInfo;

    alias _GInterfaceInfo GInterfaceInfo;

    alias _GTypeValueTable GTypeValueTable;

    alias _GTypeQuery GTypeQuery;





    struct _GTypeClass {

    GType g_type;
    }
    struct _GTypeInstance {

    GTypeClass *g_class;
    }
    struct _GTypeInterface {

    GType g_type;
    GType g_instance_type;
    }
    struct _GTypeQuery {
    GType type;
    gchar *type_name;
    guint class_size;
    guint instance_size;
    }
    enum GTypeDebugFlags {
    G_TYPE_DEBUG_NONE = 0,
    G_TYPE_DEBUG_OBJECTS = 1 << 0,
    G_TYPE_DEBUG_SIGNALS = 1 << 1,
    G_TYPE_DEBUG_MASK = 0x03
    };




    void g_type_init ();
    void g_type_init_with_debug_flags (GTypeDebugFlags debug_flags);
    gchar* g_type_name (GType type);
    GQuark g_type_qname (GType type);
    GType g_type_from_name ( gchar *name);
    GType g_type_parent (GType type);
    guint g_type_depth (GType type);
    GType g_type_next_base (GType leaf_type,
                            GType root_type);
    gboolean g_type_is_a (GType type,
                            GType is_a_type);
    gpointer g_type_class_ref (GType type);
    gpointer g_type_class_peek (GType type);
    gpointer g_type_class_peek_static (GType type);
    void g_type_class_unref (gpointer g_class);
    gpointer g_type_class_peek_parent (gpointer g_class);
    gpointer g_type_interface_peek (gpointer instanc_class,
                            GType iface_type);
    gpointer g_type_interface_peek_parent (gpointer g_iface);

    gpointer g_type_default_interface_ref (GType g_type);
    gpointer g_type_default_interface_peek (GType g_type);
    void g_type_default_interface_unref (gpointer g_iface);


    GType* g_type_children (GType type,
                            guint *n_children);
    GType* g_type_interfaces (GType type,
                            guint *n_interfaces);


    void g_type_set_qdata (GType type,
                            GQuark quark,
                            gpointer data);
    gpointer g_type_get_qdata (GType type,
                            GQuark quark);
    void g_type_query (GType type,
                            GTypeQuery *query);



    alias void (*GBaseInitFunc) (gpointer g_class);
    alias void (*GBaseFinalizeFunc) (gpointer g_class);
    alias void (*GClassInitFunc) (gpointer g_class,
                        gpointer class_data);
    alias void (*GClassFinalizeFunc) (gpointer g_class,
                        gpointer class_data);
    alias void (*GInstanceInitFunc) (GTypeInstance *instanc,
                        gpointer g_class);
    alias void (*GInterfaceInitFunc) (gpointer g_iface,
                        gpointer iface_data);
    alias void (*GInterfaceFinalizeFunc) (gpointer g_iface,
                        gpointer iface_data);
    alias gboolean (*GTypeClassCacheFunc) (gpointer cache_data,
                        GTypeClass *g_class);
    alias void (*GTypeInterfaceCheckFunc) (gpointer func_data,
                        gpointer g_iface);
    enum GTypeFundamentalFlags {
    G_TYPE_FLAG_CLASSED = (1 << 0),
    G_TYPE_FLAG_INSTANTIATABLE = (1 << 1),
    G_TYPE_FLAG_DERIVABLE = (1 << 2),
    G_TYPE_FLAG_DEEP_DERIVABLE = (1 << 3)
    };

    enum GTypeFlags {
    G_TYPE_FLAG_ABSTRACT = (1 << 4),
    G_TYPE_FLAG_VALUE_ABSTRACT = (1 << 5)
    };

    struct _GTypeInfo {

    guint16 class_size;

    GBaseInitFunc base_init;
    GBaseFinalizeFunc base_finalize;


    GClassInitFunc class_init;
    GClassFinalizeFunc class_finalize;
    gpointer class_data;


    guint16 instance_size;
    guint16 n_preallocs;
    GInstanceInitFunc instance_init;


    GTypeValueTable *value_table;
    }
    struct _GTypeFundamentalInfo {
    GTypeFundamentalFlags type_flags;
    }
    struct _GInterfaceInfo {
    GInterfaceInitFunc interface_init;
    GInterfaceFinalizeFunc interface_finalize;
    gpointer interface_data;
    }
    struct _GTypeValueTable {
    void (*value_init) (GValue *value);
    void (*value_free) (GValue *value);
    void (*value_copy) (GValue *src_value,
                    GValue *dest_value);

    gpointer (*value_peek_pointer) (GValue *value);
    gchar *collect_format;
    gchar* (*collect_value) (GValue *value,
                    guint n_collect_values,
                    GTypeCValue *collect_values,
                    guint collect_flags);
    gchar *lcopy_format;
    gchar* (*lcopy_value) (GValue *value,
                    guint n_collect_values,
                    GTypeCValue *collect_values,
                    guint collect_flags);
    }
    GType g_type_register_static (GType parent_type,
                        gchar *type_name,
                        GTypeInfo *info,
                        GTypeFlags flags);
    GType g_type_register_dynamic (GType parent_type,
                        gchar *type_name,
                        GTypePlugin *plugin,
                        GTypeFlags flags);
    GType g_type_register_fundamental (GType type_id,
                        gchar *type_name,
                        GTypeInfo *info,
                        GTypeFundamentalInfo *finfo,
                        GTypeFlags flags);
    void g_type_add_interface_static (GType instance_type,
                        GType interface_type,
                        GInterfaceInfo *info);
    void g_type_add_interface_dynamic (GType instance_type,
                        GType interface_type,
                        GTypePlugin *plugin);
    void g_type_interface_add_prerequisite (GType interface_type,
                        GType prerequisite_type);
    GType*g_type_interface_prerequisites (GType interface_type,
                        guint *n_prerequisites);
    void g_type_class_add_private (gpointer g_class,
                        gsize private_size);
    gpointer g_type_instance_get_private (GTypeInstance *insance,
                        GType private_type);
    GTypePlugin* g_type_get_plugin (GType type);
    GTypePlugin* g_type_interface_get_plugin (GType instance_type,
                            GType interface_type);
    GType g_type_fundamental_next ();
    GType g_type_fundamental (GType type_id);
    GTypeInstance* g_type_create_instance (GType type);
    void g_type_free_instance (GTypeInstance *insance);

    void g_type_add_class_cache_func (gpointer cache_data,
                            GTypeClassCacheFunc cache_func);
    void g_type_remove_class_cache_func (gpointer cache_data,
                            GTypeClassCacheFunc cache_func);
    void g_type_class_unref_uncached (gpointer g_class);

    void g_type_add_interface_check (gpointer check_data,
                            GTypeInterfaceCheckFunc check_func);
    void g_type_remove_interface_check (gpointer check_data,
                            GTypeInterfaceCheckFunc chec_func);

    GTypeValueTable* g_type_value_table_peek (GType type);



    gboolean g_type_check_instance (GTypeInstance *instanc);
    GTypeInstance* g_type_check_instance_cast (GTypeInstance *instanc,
                            GType iface_type);
    gboolean g_type_check_instance_is_a (GTypeInstance *instanc,
                            GType iface_type);
    GTypeClass* g_type_check_class_cast (GTypeClass *g_class,
                            GType is_a_type);
    gboolean g_type_check_class_is_a (GTypeClass *g_class,
                            GType is_a_type);
    gboolean g_type_check_is_value_type (GType type);
    gboolean g_type_check_value (GValue *value);
    gboolean g_type_check_value_holds (GValue *value,
                            GType type);
    gboolean g_type_test_flags (GType type,
                            guint flags);



    gchar* g_type_name_from_instance (GTypeInstance *instanc);
    gchar* g_type_name_from_class (GTypeClass *g_class);
    GTypeDebugFlags _g_type_debug_flags;











    alias gpointer (*GBoxedCopyFunc) (gpointer boxed);
    alias void (*GBoxedFreeFunc) (gpointer boxed);



    gpointer g_boxed_copy (GType boxed_type,
                            gpointer src_boxed);
    void g_boxed_free (GType boxed_type,
                            gpointer boxed);
    void g_value_set_boxed (GValue *value,
                            gpointer v_boxed);
    void g_value_set_static_boxed (GValue *value,
                            gpointer v_boxed);
    gpointer g_value_get_boxed ( GValue *value);
    gpointer g_value_dup_boxed ( GValue *value);



    GType g_boxed_type_register_static ( gchar *name,
                            GBoxedCopyFunc boxed_copy,
                            GBoxedFreeFunc boxed_free);
    void g_value_take_boxed (GValue *value,
                    gpointer v_boxed);

    void g_value_set_boxed_take_ownership (GValue *value,
                            gpointer v_boxed);

    GType g_closure_get_type () ;
    GType g_value_get_type () ;
    GType g_value_array_get_type () ;
    GType g_strv_get_type () ;
    GType g_gstring_get_type () ;

    alias gchar** GStrv;




    alias _GEnumClass GEnumClass;

    alias _GFlagsClass GFlagsClass;

    alias _GEnumValue GEnumValue;

    alias _GFlagsValue GFlagsValue;

    struct _GEnumClass {
    GTypeClass g_type_class;


    gint minimum;
    gint maximum;
    guint n_values;
    GEnumValue *values;
    }
    struct _GFlagsClass {
    GTypeClass g_type_class;


    guint mask;
    guint n_values;
    GFlagsValue *values;
    }
    struct _GEnumValue {
    gint value;
    gchar *value_name;
    gchar *value_nick;
    }
    struct _GFlagsValue {
    guint value;
    gchar *value_name;
    gchar *value_nick;
    }



    GEnumValue* g_enum_get_value (GEnumClass *enum_class,
                            gint value);
    GEnumValue* g_enum_get_value_by_name (GEnumClass *enum_class,
                            gchar *name);
    GEnumValue* g_enum_get_value_by_nick (GEnumClass *enum_class,
                            gchar *nick);
    GFlagsValue* g_flags_get_first_value (GFlagsClass *flags_class,
                            guint value);
    GFlagsValue* g_flags_get_value_by_name (GFlagsClass *flags_class,
                            gchar *name);
    GFlagsValue* g_flags_get_value_by_nick (GFlagsClass *flags_class,
                            gchar *nick);
    void g_value_set_enum (GValue *value,
                            gint v_enum);
    gint g_value_get_enum ( GValue *value);
    void g_value_set_flags (GValue *value,
                            guint v_flags);
    guint g_value_get_flags ( GValue *value);







    GType g_enum_register_static ( gchar *name,
                    GEnumValue *_static_values);
    GType g_flags_register_static ( gchar *name,
                    GFlagsValue *_static_values);



    void g_enum_complete_type_info (GType g_enum_type,
                    GTypeInfo *info,
                    GEnumValue *_values);
    void g_flags_complete_type_info (GType g_flags_type,
                    GTypeInfo *info,
                    GFlagsValue *_values);




    alias void (*GValueTransform) ( GValue *src_value,
                    GValue *dest_value);
    struct _GValue {

    GType g_type;


    union data_union  {
    gint v_int;
    guint v_uint;
    glong v_long;
    gulong v_ulong;
    gint64 v_int64;
    guint64 v_uint64;
    gfloat v_float;
    gdouble v_double;
    gpointer v_pointer;
    }
    data_union data[2];
    }



    GValue* g_value_init (GValue *value,
                        GType g_type);
    void g_value_copy ( GValue *src_value,
                        GValue *dest_value);
    GValue* g_value_reset (GValue *value);
    void g_value_unset (GValue *value);
    void g_value_set_instance (GValue *value,
                        gpointer instanc);



    gboolean g_value_fits_pointer ( GValue *value);
    gpointer g_value_peek_pointer ( GValue *value);



    gboolean g_value_type_compatible (GType src_type,
                        GType dest_type);
    gboolean g_value_type_transformable (GType src_type,
                        GType dest_type);
    gboolean g_value_transform ( GValue *src_value,
                        GValue *dest_value);
    void g_value_register_transform_func (GType src_type,
                        GType dest_type,
                        GValueTransform transform_func);






    enum GParamFlags {
    G_PARAM_READABLE = 1 << 0,
    G_PARAM_WRITABLE = 1 << 1,
    G_PARAM_CONSTRUCT = 1 << 2,
    G_PARAM_CONSTRUCT_ONLY = 1 << 3,
    G_PARAM_LAX_VALIDATION = 1 << 4,
    G_PARAM_PRIVATE = 1 << 5
    };








    alias _GParamSpec GParamSpec;

    alias _GParamSpecClass GParamSpecClass;

    alias _GParameter GParameter;

    alias _GParamSpecPool GParamSpecPool;
    alias void _GParamSpecPool;

    struct _GParamSpec {
    GTypeInstance g_type_instance;

    gchar *name;
    GParamFlags flags;
    GType value_type;
    GType owner_type;


    gchar *_nick;
    gchar *_blurb;
    GData *qdata;
    guint ref_count;
    guint param_id;
    }
    struct _GParamSpecClass {
    GTypeClass g_type_class;

    GType value_type;

    void (*finalize) (GParamSpec *pspec);


    void (*value_set_default) (GParamSpec *pspec,
                        GValue *value);
    gboolean (*value_validate) (GParamSpec *pspec,
                        GValue *value);
    gint (*values_cmp) (GParamSpec *pspec,
                        GValue *value1,
                        GValue *value2);

    gpointer dummy[4];
    }
    struct _GParameter {
    gchar *name;
    GValue value;
    }



    GParamSpec* g_param_spec_ref (GParamSpec *pspec);
    void g_param_spec_unref (GParamSpec *pspec);
    void g_param_spec_sink (GParamSpec *pspec);
    gpointer g_param_spec_get_qdata (GParamSpec *pspec,
                            GQuark quark);
    void g_param_spec_set_qdata (GParamSpec *pspec,
                            GQuark quark,
                            gpointer data);
    void g_param_spec_set_qdata_full (GParamSpec *pspec,
                            GQuark quark,
                            gpointer data,
                            GDestroyNotify destroy);
    gpointer g_param_spec_steal_qdata (GParamSpec *pspec,
                            GQuark quark);
    GParamSpec* g_param_spec_get_redirect_target (GParamSpec *pspec);

    void g_param_value_set_default (GParamSpec *pspec,
                            GValue *value);
    gboolean g_param_value_defaults (GParamSpec *pspec,
                            GValue *value);
    gboolean g_param_value_validate (GParamSpec *pspec,
                            GValue *value);
    gboolean g_param_value_convert (GParamSpec *pspec,
                            GValue *src_value,
                            GValue *dest_value,
                            gboolean strict_validation);
    gint g_param_values_cmp (GParamSpec *pspec,
                            GValue *value1,
                            GValue *value2);
    gchar* g_param_spec_get_name (GParamSpec *pspec);
    gchar* g_param_spec_get_nick (GParamSpec *pspec);
    gchar* g_param_spec_get_blurb (GParamSpec *pspec);
    void g_value_set_param (GValue *value,
                            GParamSpec *param);
    GParamSpec* g_value_get_param ( GValue *value);
    GParamSpec* g_value_dup_param ( GValue *value);


    void g_value_take_param (GValue *value,
                            GParamSpec *param);

    void g_value_set_param_take_ownership (GValue *value,
                            GParamSpec *param);



    alias _GParamSpecTypeInfo GParamSpecTypeInfo;

    struct _GParamSpecTypeInfo {

    guint16 instance_size;
    guint16 n_preallocs;
    void (*instanc_init) (GParamSpec *pspec);


    GType value_type;
    void (*finalize) (GParamSpec *pspec);
    void (*value_set_default) (GParamSpec *pspec,
                        GValue *value);
    gboolean (*value_validate) (GParamSpec *pspec,
                        GValue *value);
    gint (*values_cmp) (GParamSpec *pspec,
                        GValue *value1,
                        GValue *value2);
    }
    GType g_param_type_register_static ( gchar *name,
                        GParamSpecTypeInfo *pspec_info);


    GType _g_param_type_register_static_ant ( gchar *name,
                            GParamSpecTypeInfo *pspec_info,
                        GType opt_type);



    gpointer g_param_spec_internal (GType param_type,
                            gchar *name,
                            gchar *nick,
                            gchar *blurb,
                            GParamFlags flags);
    GParamSpecPool* g_param_spec_pool_new (gboolean type_prefixing);
    void g_param_spec_pool_insert (GParamSpecPool *pool,
                            GParamSpec *pspec,
                            GType owner_type);
    void g_param_spec_pool_remove (GParamSpecPool *pool,
                            GParamSpec *pspec);
    GParamSpec* g_param_spec_pool_lookup (GParamSpecPool *pool,
                            gchar *param_name,
                            GType owner_type,
                            gboolean walk_ancestors);
    GList* g_param_spec_pool_list_owned (GParamSpecPool *pool,
                            GType owner_type);
    GParamSpec** g_param_spec_pool_list (GParamSpecPool *pool,
                            GType owner_type,
                            guint *n_pspecs_p);



    alias _GClosure GClosure;

    alias _GClosureNotifyData GClosureNotifyData;

    alias void (*GCallback) ();
    alias void (*GClosureNotify) (gpointer data,
                        GClosure *closure);
    alias void (*GClosureMarshal) (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);
    alias _GCClosure GCClosure;




    struct _GClosureNotifyData {
    gpointer data;
    GClosureNotify notify;
    }
    struct _GClosure {
                guint ref_count;
                guint meta_marshal;
                guint n_guards;
                guint n_fnotifiers;
                guint n_inotifiers;
                guint in_inotify;
                guint floating;
                guint derivative_flag;
                guint in_marshal;
                guint is_invalid;

                void (*marshal) (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);
                gpointer data;

                GClosureNotifyData *notifiers;
    }


    struct _GCClosure {
    GClosure closure;
    gpointer callback;
    }



    GClosure* g_cclosure_new (GCallback callback_func,
                            gpointer user_data,
                            GClosureNotify destroy_data);
    GClosure* g_cclosure_new_swap (GCallback callback_func,
                            gpointer user_data,
                            GClosureNotify destroy_data);
    GClosure* g_signal_type_cclosure_new (GType itype);



    GClosure* g_closure_ref (GClosure *closure);
    void g_closure_sink (GClosure *closure);
    void g_closure_unref (GClosure *closure);

    GClosure* g_closure_new_simple (guint sizeof_closure,
                            gpointer data);
    void g_closure_add_finalize_notifier (GClosure *closure,
                            gpointer notify_data,
                            GClosureNotify notify_func);
    void g_closure_remove_finalize_notifier (GClosure *closure,
                            gpointer notify_data,
                            GClosureNotify notify_func);
    void g_closure_add_invalidate_notifier (GClosure *closure,
                            gpointer notify_data,
                            GClosureNotify notify_func);
    void g_closure_remove_invalidate_notifier (GClosure *closure,
                            gpointer notify_data,
                            GClosureNotify notify_func);
    void g_closure_add_marshal_guards (GClosure *closure,
                            gpointer pre_marshal_data,
                            GClosureNotify pre_marshal_notify,
                            gpointer post_marshal_data,
                            GClosureNotify post_marshal_notify);
    void g_closure_set_marshal (GClosure *closure,
                            GClosureMarshal marshal);
    void g_closure_set_meta_marshal (GClosure *closure,
                            gpointer marshal_data,
                            GClosureMarshal meta_marshal);
    void g_closure_invalidate (GClosure *closure);
    void g_closure_invoke (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint);







    void g_cclosure_marshal_VOID__VOID (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__BOOLEAN (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__CHAR (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__UCHAR (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__INT (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__UINT (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__LONG (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__ULONG (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__ENUM (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__FLAGS (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__FLOAT (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__DOUBLE (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__STRING (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__PARAM (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__BOXED (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__POINTER (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__OBJECT (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);


    void g_cclosure_marshal_VOID__UINT_POINTER (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);


    void g_cclosure_marshal_BOOLEAN__FLAGS (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                            GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);



    void g_cclosure_marshal_STRING__OBJECT_POINTER (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                                GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);






    alias _GSignalQuery GSignalQuery;

    alias _GSignalInvocationHint GSignalInvocationHint;

    alias GClosureMarshal GSignalCMarshaller;
    alias gboolean (*GSignalEmissionHook) (GSignalInvocationHint *ihint,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer data);
    alias gboolean (*GSignalAccumulator) (GSignalInvocationHint *ihint,
                        GValue *return_accu,
                        GValue *handler_return,
                        gpointer data);



    enum GSignalFlags {
    G_SIGNAL_RUN_FIRST = 1 << 0,
    G_SIGNAL_RUN_LAST = 1 << 1,
    G_SIGNAL_RUN_CLEANUP = 1 << 2,
    G_SIGNAL_NO_RECURSE = 1 << 3,
    G_SIGNAL_DETAILED = 1 << 4,
    G_SIGNAL_ACTION = 1 << 5,
    G_SIGNAL_NO_HOOKS = 1 << 6
    };


    enum GConnectFlags {
    G_CONNECT_AFTER = 1 << 0,
    G_CONNECT_SWAPPED = 1 << 1
    };

    enum GSignalMatchType {
    G_SIGNAL_MATCH_ID = 1 << 0,
    G_SIGNAL_MATCH_DETAIL = 1 << 1,
    G_SIGNAL_MATCH_CLOSURE = 1 << 2,
    G_SIGNAL_MATCH_FUNC = 1 << 3,
    G_SIGNAL_MATCH_DATA = 1 << 4,
    G_SIGNAL_MATCH_UNBLOCKED = 1 << 5
    };






    struct _GSignalInvocationHint {
    guint signal_id;
    GQuark detail;
    GSignalFlags run_type;
    }
    struct _GSignalQuery {
    guint signal_id;
    gchar *signal_name;
    GType itype;
    GSignalFlags signal_flags;
    GType return_type;
    guint n_params;
    GType *param_types;
    }



    guint g_signal_newv ( gchar *signal_name,
                        GType itype,
                        GSignalFlags signal_flags,
                        GClosure *class_closure,
                        GSignalAccumulator accumulator,
                        gpointer accu_data,
                        GSignalCMarshaller c_marshaller,
                        GType return_type,
                        guint n_params,
                        GType *param_types);
    guint g_signal_new_valist ( gchar *signal_name,
                        GType itype,
                        GSignalFlags signal_flags,
                        GClosure *class_closure,
                        GSignalAccumulator accumulator,
                        gpointer accu_data,
                        GSignalCMarshaller c_marshaller,
                        GType return_type,
                        guint n_params,
                        va_list args);
    guint g_signal_new ( gchar *signal_name,
                        GType itype,
                        GSignalFlags signal_flags,
                        guint class_offset,
                        GSignalAccumulator accumulator,
                        gpointer accu_data,
                        GSignalCMarshaller c_marshaller,
                        GType return_type,
                        guint n_params,
                        ...);
    void g_signal_emitv ( GValue *instanc_and_params,
                        guint signal_id,
                        GQuark detail,
                        GValue *return_value);
    void g_signal_emit_valist (gpointer instanc,
                        guint signal_id,
                        GQuark detail,
                        va_list var_args);
    void g_signal_emit (gpointer instanc,
                        guint signal_id,
                        GQuark detail,
                        ...);
    void g_signal_emit_by_name (gpointer instanc,
                        gchar *detailed_signal,
                        ...);
    guint g_signal_lookup ( gchar *name,
                        GType itype);
    gchar* g_signal_name (guint signal_id);
    void g_signal_query (guint signal_id,
                        GSignalQuery *query);
    guint* g_signal_list_ids (GType itype,
                        guint *n_ids);
    gboolean g_signal_parse_name ( gchar *detailed_signal,
                        GType itype,
                        guint *signal_id_p,
                        GQuark *detail_p,
                        gboolean force_detail_quark);
    GSignalInvocationHint* g_signal_get_invocation_hint (gpointer instanc);



    void g_signal_stop_emission (gpointer instanc,
                        guint signal_id,
                        GQuark detail);
    void g_signal_stop_emission_by_name (gpointer instanc,
                        gchar *detailed_signal);
    gulong g_signal_add_emission_hook (guint signal_id,
                        GQuark detail,
                        GSignalEmissionHook hook_func,
                        gpointer hook_data,
                        GDestroyNotify data_destroy);
    void g_signal_remove_emission_hook (guint signal_id,
                        gulong hook_id);



    gboolean g_signal_has_handler_pending (gpointer instanc,
                        guint signal_id,
                        GQuark detail,
                        gboolean may_be_blocked);
    gulong g_signal_connect_closure_by_id (gpointer instanc,
                        guint signal_id,
                        GQuark detail,
                        GClosure *closure,
                        gboolean after);
    gulong g_signal_connect_closure (gpointer instanc,
                            gchar *detailed_signal,
                        GClosure *closure,
                        gboolean after);
    gulong g_signal_connect_data (gpointer instanc,
                            gchar *detailed_signal,
                        GCallback c_handler,
                        gpointer data,
                        GClosureNotify destroy_data,
                        GConnectFlags connect_flags);
    void g_signal_handler_block (gpointer instanc,
                        gulong handler_id);
    void g_signal_handler_unblock (gpointer instanc,
                        gulong handler_id);
    void g_signal_handler_disconnect (gpointer instanc,
                        gulong handler_id);
    gboolean g_signal_handler_is_connected (gpointer instanc,
                        gulong handler_id);
    gulong g_signal_handler_find (gpointer instanc,
                        GSignalMatchType mask,
                        guint signal_id,
                        GQuark detail,
                        GClosure *closure,
                        gpointer func,
                        gpointer data);
    guint g_signal_handlers_block_matched (gpointer instanc,
                        GSignalMatchType mask,
                        guint signal_id,
                        GQuark detail,
                        GClosure *closure,
                        gpointer func,
                        gpointer data);
    guint g_signal_handlers_unblock_matched (gpointer instanc,
                        GSignalMatchType mask,
                        guint signal_id,
                        GQuark detail,
                        GClosure *closure,
                        gpointer func,
                        gpointer data);
    guint g_signal_handlers_disconnect_matched (gpointer instanc,
                        GSignalMatchType mask,
                        guint signal_id,
                        GQuark detail,
                        GClosure *closure,
                        gpointer func,
                        gpointer data);



    void g_signal_override_class_closure (guint signal_id,
                        GType instance_type,
                        GClosure *class_closure);
    void g_signal_chain_from_overridden ( GValue *instanc_and_params,
                        GValue *return_value);
    gboolean g_signal_accumulator_true_handled (GSignalInvocationHint *ihint,
                        GValue *return_accu,
                        GValue *handler_return,
                        gpointer dummy);


    void g_signal_handlers_destroy (gpointer instanc);
    void _g_signals_destroy (GType itype);




    alias _GObject GObject;

    alias _GObjectClass GObjectClass;


    alias void (*GObjectGetPropertyFunc) (GObject *object,
                        guint property_id,
                        GValue *value,
                        GParamSpec *pspec);
    alias void (*GObjectSetPropertyFunc) (GObject *object,
                        guint property_id,
                        GValue *value,
                        GParamSpec *pspec);
    alias void (*GObjectFinalizeFunc) (GObject *object);
    alias void (*GWeakNotify) (gpointer data,
                        GObject *where_the_object_was);
    struct _GObject {
    GTypeInstance g_type_instance;


    guint ref_count;
    GData *qdata;
    }
    struct _GObjectClass {
    GTypeClass g_type_class;


      GSList      *construct_properties; // BVH



    GObject* (*constructor) (GType type,
                    guint n_ruct_properties);
    void (*set_property) (GObject *object,
                        guint property_id,
                        GValue *value,
                        GParamSpec *pspec);
    void (*get_property) (GObject *object,
                        guint property_id,
                        GValue *value,
                        GParamSpec *pspec);
    void (*dispose) (GObject *object);
    void (*finalize) (GObject *object);


    void (*dispatch_properties_changed) (GObject *object,
                        guint n_pspecs,
                        GParamSpec **pspecs);


    void (*notify) (GObject *object,
                        GParamSpec *pspec);


    gpointer pdummy[8];
    }
    struct _GObjectConstructParam {
    GParamSpec *pspec;
    GValue *value;
    }



    void g_object_class_install_property (GObjectClass *oclass,
                        guint property_id,
                        GParamSpec *pspec);
    GParamSpec* g_object_class_find_property (GObjectClass *oclass,
                            gchar *property_name);
    GParamSpec**g_object_class_list_properties (GObjectClass *oclass,
                        guint *n_properties);
    void g_object_class_override_property (GObjectClass *oclass,
                        guint property_id,
                            gchar *name);

    void g_object_interface_install_property (gpointer g_iface,
                            GParamSpec *pspec);
    GParamSpec* g_object_interface_find_property (gpointer g_iface,
                            gchar *property_name);
    GParamSpec**g_object_interface_list_properties (gpointer g_iface,
                            guint *n_properties_p);

    gpointer g_object_new (GType object_type,
                            gchar *first_property_name,
                        ...);
    gpointer g_object_newv (GType object_type,
                        guint n_parameters,
                        GParameter *parameters);
    GObject* g_object_new_valist (GType object_type,
                            gchar *first_property_name,
                        va_list var_args);
    void g_object_set (gpointer object,
                            gchar *first_property_name,
                        ...);
    void g_object_get (gpointer object,
                            gchar *first_property_name,
                        ...);
    gpointer g_object_connect (gpointer object,
                            gchar *signal_spec,
                        ...);
    void g_object_disconnect (gpointer object,
                            gchar *signal_spec,
                        ...);
    void g_object_set_valist (GObject *object,
                            gchar *first_property_name,
                        va_list var_args);
    void g_object_get_valist (GObject *object,
                            gchar *first_property_name,
                        va_list var_args);
    void g_object_set_property (GObject *object,
                            gchar *property_name,
                            GValue *value);
    void g_object_get_property (GObject *object,
                            gchar *property_name,
                        GValue *value);
    void g_object_freeze_notify (GObject *object);
    void g_object_notify (GObject *object,
                            gchar *property_name);
    void g_object_thaw_notify (GObject *object);
    gpointer g_object_ref (gpointer object);
    void g_object_unref (gpointer object);
    void g_object_weak_ref (GObject *object,
                        GWeakNotify notify,
                        gpointer data);
    void g_object_weak_unref (GObject *object,
                        GWeakNotify notify,
                        gpointer data);
    void g_object_add_weak_pointer (GObject *object,
                        gpointer *weak_pointer_location);
    void g_object_remove_weak_pointer (GObject *object,
                        gpointer *weak_pointer_location);
    gpointer g_object_get_qdata (GObject *object,
                        GQuark quark);
    void g_object_set_qdata (GObject *object,
                        GQuark quark,
                        gpointer data);
    void g_object_set_qdata_full (GObject *object,
                        GQuark quark,
                        gpointer data,
                        GDestroyNotify destroy);
    gpointer g_object_steal_qdata (GObject *object,
                        GQuark quark);
    gpointer g_object_get_data (GObject *object,
                            gchar *key);
    void g_object_set_data (GObject *object,
                            gchar *key,
                        gpointer data);
    void g_object_set_data_full (GObject *object,
                            gchar *key,
                        gpointer data,
                        GDestroyNotify destroy);
    gpointer g_object_steal_data (GObject *object,
                            gchar *key);
    void g_object_watch_closure (GObject *object,
                        GClosure *closure);
    GClosure* g_cclosure_new_object (GCallback callback_func,
                        GObject *object);
    GClosure* g_cclosure_new_object_swap (GCallback callback_func,
                        GObject *object);
    GClosure* g_closure_new_object (guint sizeof_closure,
                        GObject *object);
    void g_value_set_object (GValue *value,
                        gpointer v_object);
    gpointer g_value_get_object ( GValue *value);
    GObject* g_value_dup_object ( GValue *value);
    gulong g_signal_connect_object (gpointer instanc,
                            gchar *detailed_signal,
                        GCallback c_handler,
                        gpointer gobject,
                        GConnectFlags connect_flags);



    void g_object_run_dispose (GObject *object);


    void g_value_take_object (GValue *value,
                        gpointer v_object);

    void g_value_set_object_take_ownership (GValue *value,
                        gpointer v_object);



    alias _GParamSpecChar GParamSpecChar;

    alias _GParamSpecUChar GParamSpecUChar;

    alias _GParamSpecBoolean GParamSpecBoolean;

    alias _GParamSpecInt GParamSpecInt;

    alias _GParamSpecUInt GParamSpecUInt;

    alias _GParamSpecLong GParamSpecLong;

    alias _GParamSpecULong GParamSpecULong;

    alias _GParamSpecInt64 GParamSpecInt64;

    alias _GParamSpecUInt64 GParamSpecUInt64;

    alias _GParamSpecUnichar GParamSpecUnichar;

    alias _GParamSpecEnum GParamSpecEnum;

    alias _GParamSpecFlags GParamSpecFlags;

    alias _GParamSpecFloat GParamSpecFloat;

    alias _GParamSpecDouble GParamSpecDouble;

    alias _GParamSpecString GParamSpecString;

    alias _GParamSpecParam GParamSpecParam;

    alias _GParamSpecBoxed GParamSpecBoxed;

    alias _GParamSpecPointer GParamSpecPointer;

    alias _GParamSpecValueArray GParamSpecValueArray;

    alias _GParamSpecObject GParamSpecObject;

    alias _GParamSpecOverride GParamSpecOverride;


    struct _GParamSpecChar {
    GParamSpec parent_instance;

    gint8 minimum;
    gint8 maximum;
    gint8 default_value;
    }
    struct _GParamSpecUChar {
    GParamSpec parent_instance;

    guint8 minimum;
    guint8 maximum;
    guint8 default_value;
    }
    struct _GParamSpecBoolean {
    GParamSpec parent_instance;

    gboolean default_value;
    }
    struct _GParamSpecInt {
    GParamSpec parent_instance;

    gint minimum;
    gint maximum;
    gint default_value;
    }
    struct _GParamSpecUInt {
    GParamSpec parent_instance;

    guint minimum;
    guint maximum;
    guint default_value;
    }
    struct _GParamSpecLong {
    GParamSpec parent_instance;

    glong minimum;
    glong maximum;
    glong default_value;
    }
    struct _GParamSpecULong {
    GParamSpec parent_instance;

    gulong minimum;
    gulong maximum;
    gulong default_value;
    }
    struct _GParamSpecInt64 {
    GParamSpec parent_instance;

    gint64 minimum;
    gint64 maximum;
    gint64 default_value;
    }
    struct _GParamSpecUInt64 {
    GParamSpec parent_instance;

    guint64 minimum;
    guint64 maximum;
    guint64 default_value;
    }
    struct _GParamSpecUnichar {
    GParamSpec parent_instance;

    gunichar default_value;
    }
    struct _GParamSpecEnum {
    GParamSpec parent_instance;

    GEnumClass *enum_class;
    gint default_value;
    }
    struct _GParamSpecFlags {
    GParamSpec parent_instance;

    GFlagsClass *flags_class;
    guint default_value;
    }
    struct _GParamSpecFloat {
    GParamSpec parent_instance;

    gfloat minimum;
    gfloat maximum;
    gfloat default_value;
    gfloat epsilon;
    }
    struct _GParamSpecDouble {
    GParamSpec parent_instance;

    gdouble minimum;
    gdouble maximum;
    gdouble default_value;
    gdouble epsilon;
    }
    struct _GParamSpecString {
    GParamSpec parent_instance;

    gchar *default_value;
    gchar *cset_first;
    gchar *cset_nth;
    gchar substitutor;
    guint null_fold_if_empty;
    guint ensure_non_null;
    }
    struct _GParamSpecParam {
    GParamSpec parent_instance;
    }
    struct _GParamSpecBoxed {
    GParamSpec parent_instance;
    }
    struct _GParamSpecPointer {
    GParamSpec parent_instance;
    }
    struct _GParamSpecValueArray {
    GParamSpec parent_instance;
    GParamSpec *element_spec;
    guint fixed_n_elements;
    }
    struct _GParamSpecObject {
    GParamSpec parent_instance;
    }
    struct _GParamSpecOverride {

    GParamSpec parent_instance;
    GParamSpec *overridden;
    }


    GParamSpec* g_param_spec_char ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gint8 minimum,
                        gint8 maximum,
                        gint8 default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_uchar ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        guint8 minimum,
                        guint8 maximum,
                        guint8 default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_boolean ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gboolean default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_int ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gint minimum,
                        gint maximum,
                        gint default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_uint ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        guint minimum,
                        guint maximum,
                        guint default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_long ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        glong minimum,
                        glong maximum,
                        glong default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_ulong ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gulong minimum,
                        gulong maximum,
                        gulong default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_int64 ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gint64 minimum,
                        gint64 maximum,
                        gint64 default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_uint64 ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        guint64 minimum,
                        guint64 maximum,
                        guint64 default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_unichar ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gunichar default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_enum ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        GType enum_type,
                        gint default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_flags ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        GType flags_type,
                        guint default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_float ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gfloat minimum,
                        gfloat maximum,
                        gfloat default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_double ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gdouble minimum,
                        gdouble maximum,
                        gdouble default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_string ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        gchar *default_value,
                        GParamFlags flags);
    GParamSpec* g_param_spec_param ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        GType param_type,
                        GParamFlags flags);
    GParamSpec* g_param_spec_boxed ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        GType boxed_type,
                        GParamFlags flags);
    GParamSpec* g_param_spec_pointer ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        GParamFlags flags);
    GParamSpec* g_param_spec_value_array ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        GParamSpec *element_spec,
                        GParamFlags flags);
    GParamSpec* g_param_spec_object ( gchar *name,
                        gchar *nick,
                        gchar *blurb,
                        GType object_type,
                        GParamFlags flags);

    GParamSpec* g_param_spec_override ( gchar *name,
                        GParamSpec *overridden);
    GType *g_param_spec_types;





    void g_source_set_closure (GSource *source,
                GClosure *closure);

    GType g_io_channel_get_type ();
    GType g_io_condition_get_type ();








    alias _GTypeModule GTypeModule;

    alias _GTypeModuleClass GTypeModuleClass;

    struct _GTypeModule {
    GObject parent_instance;

    guint use_count;
    GSList *type_infos;
    GSList *interface_infos;


    gchar *name;
    }

    struct _GTypeModuleClass {
    GObjectClass parent_class;


    gboolean (* load) (GTypeModule *modle);
    void (* unload) (GTypeModule *modle);



    void (*reserved1) ();
    void (*reserved2) ();
    void (*reserved3) ();
    void (*reserved4) ();
    }

    GType g_type_module_get_type ();
    gboolean g_type_module_use (GTypeModule *modle);
    void g_type_module_unuse (GTypeModule *modle);
    void g_type_module_set_name (GTypeModule *modle,
                    gchar *name);
    GType g_type_module_register_type (GTypeModule *modle,
                    GType parent_type,
                    gchar *type_name,
                    GTypeInfo *type_info,
                    GTypeFlags flags);
    void g_type_module_add_interface (GTypeModule *modle,
                    GType instance_type,
                    GType interface_type,
                    GInterfaceInfo *interface_info);




    alias _GTypePluginClass GTypePluginClass;

    alias void (*GTypePluginUse) (GTypePlugin *plugin);
    alias void (*GTypePluginUnuse) (GTypePlugin *plugin);
    alias void (*GTypePluginCompleteTypeInfo) (GTypePlugin *plugin,
                            GType g_type,
                            GTypeInfo *info,
                            GTypeValueTable *value_table);
    alias void (*GTypePluginCompleteInterfaceInfo) (GTypePlugin *plugin,
                            GType instance_type,
                            GType interface_type,
                            GInterfaceInfo *info);
    struct _GTypePluginClass {

    GTypeInterface base_iface;


    GTypePluginUse use_plugin;
    GTypePluginUnuse unuse_plugin;
    GTypePluginCompleteTypeInfo complete_type_info;
    GTypePluginCompleteInterfaceInfo complete_interface_info;
    }



    GType g_type_plugin_get_type () ;
    void g_type_plugin_use (GTypePlugin *plugin);
    void g_type_plugin_unuse (GTypePlugin *plugin);
    void g_type_plugin_complete_type_info (GTypePlugin *plugin,
                            GType g_type,
                            GTypeInfo *info,
                            GTypeValueTable *value_table);
    void g_type_plugin_complete_interface_info (GTypePlugin *plugin,
                            GType instance_type,
                            GType interface_type,
                            GInterfaceInfo *info);


    alias _GValueArray GValueArray;

    struct _GValueArray {
    guint n_values;
    GValue *values;


    guint n_prealloced;
    }



    GValue* g_value_array_get_nth (GValueArray *value_array,
                        guint index_);
    GValueArray* g_value_array_new (guint n_prealloced);
    void g_value_array_free (GValueArray *value_array);
    GValueArray* g_value_array_copy ( GValueArray *value_array);
    GValueArray* g_value_array_prepend (GValueArray *value_array,
                        GValue *value);
    GValueArray* g_value_array_append (GValueArray *value_array,
                        GValue *value);
    GValueArray* g_value_array_insert (GValueArray *value_array,
                        guint index_,
                        GValue *value);
    GValueArray* g_value_array_remove (GValueArray *value_array,
                        guint index_);
    GValueArray* g_value_array_sort (GValueArray *value_array,
                        GCompareFunc compare_func);
    GValueArray* g_value_array_sort_with_data (GValueArray *value_array,
                        GCompareDataFunc compare_func,
                        gpointer user_data);


    void g_value_set_char (GValue *value,
                            gchar v_char);
    gchar g_value_get_char ( GValue *value);
    void g_value_set_uchar (GValue *value,
                            guchar v_uchar);
    guchar g_value_get_uchar ( GValue *value);
    void g_value_set_boolean (GValue *value,
                            gboolean v_boolean);
    gboolean g_value_get_boolean ( GValue *value);
    void g_value_set_int (GValue *value,
                            gint v_int);
    gint g_value_get_int ( GValue *value);
    void g_value_set_uint (GValue *value,
                            guint v_uint);
    guint g_value_get_uint ( GValue *value);
    void g_value_set_long (GValue *value,
                            glong v_long);
    glong g_value_get_long ( GValue *value);
    void g_value_set_ulong (GValue *value,
                            gulong v_ulong);
    gulong g_value_get_ulong ( GValue *value);
    void g_value_set_int64 (GValue *value,
                            gint64 v_int64);
    gint64 g_value_get_int64 ( GValue *value);
    void g_value_set_uint64 (GValue *value,
                            guint64 v_uint64);
    guint64 g_value_get_uint64 ( GValue *value);
    void g_value_set_float (GValue *value,
                            gfloat v_float);
    gfloat g_value_get_float ( GValue *value);
    void g_value_set_double (GValue *value,
                            gdouble v_double);
    gdouble g_value_get_double ( GValue *value);
    void g_value_set_string (GValue *value,
                            gchar *v_string);
    void g_value_set_static_string (GValue *value,
                            gchar *v_string);
    gchar* g_value_get_string ( GValue *value);
    gchar* g_value_dup_string ( GValue *value);
    void g_value_set_pointer (GValue *value,
                            gpointer v_pointer);
    gpointer g_value_get_pointer ( GValue *value);



    GType g_pointer_type_register_static ( gchar *name);


    gchar* g_strdup_value_contents ( GValue *value);


    void g_value_take_string (GValue *value,
                            gchar *v_string);

    void g_value_set_string_take_ownership (GValue *value,
                            gchar *v_string);




    alias gchar* gchararray;






    alias _PangoLogAttr PangoLogAttr;


    alias _PangoEngineLang PangoEngineLang;
    alias void _PangoEngineLang;

    alias _PangoEngineShape PangoEngineShape;
    alias void _PangoEngineShape;


    alias _PangoFont PangoFont;
    alias void _PangoFont;


    alias _PangoMatrix PangoMatrix;

    alias _PangoRectangle PangoRectangle;



    alias _PangoLanguage PangoLanguage;
    alias void _PangoLanguage;




    alias guint32 PangoGlyph;




    struct _PangoRectangle {
    int x;
    int y;
    int width;
    int height;
    }
    struct _PangoMatrix {
    double xx;
    double xy;
    double yx;
    double yy;
    double x0;
    double y0;
    }
    GType pango_matrix_get_type ();

    PangoMatrix *pango_matrix_copy ( PangoMatrix *matrix);
    void pango_matrix_free (PangoMatrix *matrix);

    void pango_matrix_translate (PangoMatrix *matrix,
                double tx,
                double ty);
    void pango_matrix_scale (PangoMatrix *matrix,
                double scale_x,
                double scale_y);
    void pango_matrix_rotate (PangoMatrix *matrix,
                double degrees);
    void pango_matrix_concat (PangoMatrix *matrix,
                PangoMatrix *new_matrix);
    enum PangoDirection {
    PANGO_DIRECTION_LTR,
    PANGO_DIRECTION_RTL,
    PANGO_DIRECTION_TTB_LTR,
    PANGO_DIRECTION_TTB_RTL,
    PANGO_DIRECTION_WEAK_LTR,
    PANGO_DIRECTION_WEAK_RTL,
    PANGO_DIRECTION_NEUTRAL
    };




    GType pango_language_get_type ();
    PangoLanguage *pango_language_from_string ( char *language);


    gboolean pango_language_matches (PangoLanguage *language,
                        char *range_list);


    gboolean pango_get_mirror_char (gunichar ch,
                        gunichar *mirrored_ch);



    PangoDirection pango_unichar_direction (gunichar ch);
    PangoDirection pango_find_base_dir ( gchar *text,
                        gint length);







    alias _PangoFontDescription PangoFontDescription;
    alias void _PangoFontDescription;

    alias _PangoFontMetrics PangoFontMetrics;
    alias void _PangoFontMetrics;

    enum PangoStyle {
    PANGO_STYLE_NORMAL,
    PANGO_STYLE_OBLIQUE,
    PANGO_STYLE_ITALIC
    };


    enum PangoVariant {
    PANGO_VARIANT_NORMAL,
    PANGO_VARIANT_SMALL_CAPS
    };


    enum PangoWeight {
    PANGO_WEIGHT_ULTRALIGHT = 200,
    PANGO_WEIGHT_LIGHT = 300,
    PANGO_WEIGHT_NORMAL = 400,
    PANGO_WEIGHT_BOLD = 700,
    PANGO_WEIGHT_ULTRABOLD = 800,
    PANGO_WEIGHT_HEAVY = 900
    };


    enum PangoStretch {
    PANGO_STRETCH_ULTRA_CONDENSED,
    PANGO_STRETCH_EXTRA_CONDENSED,
    PANGO_STRETCH_CONDENSED,
    PANGO_STRETCH_SEMI_CONDENSED,
    PANGO_STRETCH_NORMAL,
    PANGO_STRETCH_SEMI_EXPANDED,
    PANGO_STRETCH_EXPANDED,
    PANGO_STRETCH_EXTRA_EXPANDED,
    PANGO_STRETCH_ULTRA_EXPANDED
    };


    enum PangoFontMask {
    PANGO_FONT_MASK_FAMILY = 1 << 0,
    PANGO_FONT_MASK_STYLE = 1 << 1,
    PANGO_FONT_MASK_VARIANT = 1 << 2,
    PANGO_FONT_MASK_WEIGHT = 1 << 3,
    PANGO_FONT_MASK_STRETCH = 1 << 4,
    PANGO_FONT_MASK_SIZE = 1 << 5
    };

    GType pango_font_description_get_type ();
    PangoFontDescription *pango_font_description_new ();
    PangoFontDescription *pango_font_description_copy ( PangoFontDescription *desc);
    PangoFontDescription *pango_font_description_copy_static ( PangoFontDescription *desc);
    guint pango_font_description_hash ( PangoFontDescription *desc);
    gboolean pango_font_description_equal ( PangoFontDescription *desc1,
                                PangoFontDescription *desc2);
    void pango_font_description_free (PangoFontDescription *desc);
    void pango_font_descriptions_free (PangoFontDescription **descs,
                                int n_descs);

    void pango_font_description_set_family (PangoFontDescription *desc,
                                    char *family);
    void pango_font_description_set_family_static (PangoFontDescription *desc,
                                    char *family);
    char *pango_font_description_get_family ( PangoFontDescription *desc);
    void pango_font_description_set_style (PangoFontDescription *desc,
                                PangoStyle style);
    PangoStyle pango_font_description_get_style ( PangoFontDescription *desc);
    void pango_font_description_set_variant (PangoFontDescription *desc,
                                PangoVariant variant);
    PangoVariant pango_font_description_get_variant ( PangoFontDescription *desc);
    void pango_font_description_set_weight (PangoFontDescription *desc,
                                PangoWeight weight);
    PangoWeight pango_font_description_get_weight ( PangoFontDescription *desc);
    void pango_font_description_set_stretch (PangoFontDescription *desc,
                                PangoStretch stretch);
    PangoStretch pango_font_description_get_stretch ( PangoFontDescription *desc);
    void pango_font_description_set_size (PangoFontDescription *desc,
                                gint size);
    gint pango_font_description_get_size ( PangoFontDescription *desc);

    PangoFontMask pango_font_description_get_set_fields ( PangoFontDescription *desc);
    void pango_font_description_unset_fields (PangoFontDescription *desc,
                            PangoFontMask to_unset);

    void pango_font_description_merge (PangoFontDescription *desc,
                        PangoFontDescription *desc_to_merge,
                        gboolean replace_existing);
    void pango_font_description_merge_static (PangoFontDescription *desc,
                        PangoFontDescription *desc_to_merge,
                        gboolean replace_existing);

    gboolean pango_font_description_better_match ( PangoFontDescription *desc,
                        PangoFontDescription *old_match,
                        PangoFontDescription *new_match);

    PangoFontDescription *pango_font_description_from_string ( char *str);
    char * pango_font_description_to_string ( PangoFontDescription *desc);
    char * pango_font_description_to_filename ( PangoFontDescription *desc);






    GType pango_font_metrics_get_type ();
    PangoFontMetrics *pango_font_metrics_ref (PangoFontMetrics *metrics);
    void pango_font_metrics_unref (PangoFontMetrics *metrics);
    int pango_font_metrics_get_ascent (PangoFontMetrics *metrics);
    int pango_font_metrics_get_descent (PangoFontMetrics *metrics);
    int pango_font_metrics_get_approximate_char_width (PangoFontMetrics *metrics);
    int pango_font_metrics_get_approximate_digit_width (PangoFontMetrics *metrics);
    int pango_font_metrics_get_underline_position (PangoFontMetrics *metrics);
    int pango_font_metrics_get_underline_thickness (PangoFontMetrics *metrics);
    int pango_font_metrics_get_strikethrough_position (PangoFontMetrics *metrics);
    int pango_font_metrics_get_strikethrough_thickness (PangoFontMetrics *metrics);
    alias _PangoFontFamily PangoFontFamily;
    alias void _PangoFontFamily;

    alias _PangoFontFace PangoFontFace;
    alias void _PangoFontFace;


    GType pango_font_family_get_type () ;

    void pango_font_family_list_faces (PangoFontFamily *family,
                            PangoFontFace ***faces,
                            int *n_faces);
    char *pango_font_family_get_name (PangoFontFamily *family);
    gboolean pango_font_family_is_monospace (PangoFontFamily *family);
    GType pango_font_face_get_type () ;

    PangoFontDescription *pango_font_face_describe (PangoFontFace *face);
    char *pango_font_face_get_face_name (PangoFontFace *face);
    void pango_font_face_list_sizes (PangoFontFace *face,
                            int **sizes,
                            int *n_sizes);
    GType pango_font_get_type () ;

    PangoFontDescription *pango_font_describe (PangoFont *font);
    PangoCoverage * pango_font_get_coverage (PangoFont *font,
                            PangoLanguage *language);
    PangoEngineShape * pango_font_find_shaper (PangoFont *font,
                            PangoLanguage *language,
                            guint32 ch);
    PangoFontMetrics * pango_font_get_metrics (PangoFont *font,
                            PangoLanguage *language);
    void pango_font_get_glyph_extents (PangoFont *font,
                            PangoGlyph glyph,
                            PangoRectangle *ink_rect,
                            PangoRectangle *logical_rect);







    alias _PangoColor PangoColor;


    struct _PangoColor {
    guint16 red;
    guint16 green;
    guint16 blue;
    }


    GType pango_color_get_type () ;

    PangoColor *pango_color_copy ( PangoColor *src);
    void pango_color_free (PangoColor *color);
    gboolean pango_color_parse (PangoColor *color,
                    char *spec);



    alias _PangoAttribute PangoAttribute;

    alias _PangoAttrClass PangoAttrClass;


    alias _PangoAttrString PangoAttrString;

    alias _PangoAttrLanguage PangoAttrLanguage;

    alias _PangoAttrInt PangoAttrInt;

    alias _PangoAttrFloat PangoAttrFloat;

    alias _PangoAttrColor PangoAttrColor;

    alias _PangoAttrFontDesc PangoAttrFontDesc;

    alias _PangoAttrShape PangoAttrShape;



    alias _PangoAttrList PangoAttrList;
    alias void _PangoAttrList;

    alias _PangoAttrIterator PangoAttrIterator;
    alias void _PangoAttrIterator;


    enum PangoAttrType {
    PANGO_ATTR_INVALID,
    PANGO_ATTR_LANGUAGE,
    PANGO_ATTR_FAMILY,
    PANGO_ATTR_STYLE,
    PANGO_ATTR_WEIGHT,
    PANGO_ATTR_VARIANT,
    PANGO_ATTR_STRETCH,
    PANGO_ATTR_SIZE,
    PANGO_ATTR_FONT_DESC,
    PANGO_ATTR_FOREGROUND,
    PANGO_ATTR_BACKGROUND,
    PANGO_ATTR_UNDERLINE,
    PANGO_ATTR_STRIKETHROUGH,
    PANGO_ATTR_RISE,
    PANGO_ATTR_SHAPE,
    PANGO_ATTR_SCALE,
    PANGO_ATTR_FALLBACK,
    PANGO_ATTR_LETTER_SPACING
    };


    enum PangoUnderline {
    PANGO_UNDERLINE_NONE,
    PANGO_UNDERLINE_SINGLE,
    PANGO_UNDERLINE_DOUBLE,
    PANGO_UNDERLINE_LOW,
    PANGO_UNDERLINE_ERROR
    };


    struct _PangoAttribute {
    PangoAttrClass *klass;
    guint start_index;
    guint end_index;
    }

    alias gboolean (*PangoAttrFilterFunc) (PangoAttribute *attribute,
                        gpointer data);

    struct _PangoAttrClass {

    PangoAttrType type;
    PangoAttribute * (*copy) ( PangoAttribute *attr);
    void (*destroy) (PangoAttribute *attr);
    gboolean (*equal) ( PangoAttribute *attr1, PangoAttribute *attr2);
    }

    struct _PangoAttrString {
    PangoAttribute attr;
    char *value;
    }

    struct _PangoAttrLanguage {
    PangoAttribute attr;
    PangoLanguage *value;
    }

    struct _PangoAttrInt {
    PangoAttribute attr;
    int value;
    }

    struct _PangoAttrFloat {
    PangoAttribute attr;
    double value;
    }

    struct _PangoAttrColor {
    PangoAttribute attr;
    PangoColor color;
    }

    struct _PangoAttrShape {
    PangoAttribute attr;
    PangoRectangle ink_rect;
    PangoRectangle logical_rect;
    }

    struct _PangoAttrFontDesc {
    PangoAttribute attr;
    PangoFontDescription *desc;
    }

    PangoAttrType pango_attr_type_register ( gchar *name);

    PangoAttribute * pango_attribute_copy ( PangoAttribute *attr);
    void pango_attribute_destroy (PangoAttribute *attr);
    gboolean pango_attribute_equal ( PangoAttribute *attr1,
                            PangoAttribute *attr2);

    PangoAttribute *pango_attr_language_new (PangoLanguage *language);
    PangoAttribute *pango_attr_family_new ( char *family);
    PangoAttribute *pango_attr_foreground_new (guint16 red,
                        guint16 green,
                        guint16 blue);
    PangoAttribute *pango_attr_background_new (guint16 red,
                        guint16 green,
                        guint16 blue);
    PangoAttribute *pango_attr_size_new (int size);
    PangoAttribute *pango_attr_style_new (PangoStyle style);
    PangoAttribute *pango_attr_weight_new (PangoWeight weight);
    PangoAttribute *pango_attr_variant_new (PangoVariant variant);
    PangoAttribute *pango_attr_stretch_new (PangoStretch stretch);
    PangoAttribute *pango_attr_font_desc_new ( PangoFontDescription *desc);
    PangoAttribute *pango_attr_underline_new (PangoUnderline underline);
    PangoAttribute *pango_attr_strikethrough_new (gboolean strikethrough);
    PangoAttribute *pango_attr_rise_new (int rise);
    PangoAttribute *pango_attr_shape_new ( PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);
    PangoAttribute *pango_attr_scale_new (double scale_factor);
    PangoAttribute *pango_attr_fallback_new (gboolean enable_fallback);
    PangoAttribute *pango_attr_letter_spacing_new (int letter_spacing);

    GType pango_attr_list_get_type () ;
    PangoAttrList * pango_attr_list_new ();
    void pango_attr_list_ref (PangoAttrList *list);
    void pango_attr_list_unref (PangoAttrList *list);
    PangoAttrList * pango_attr_list_copy (PangoAttrList *list);
    void pango_attr_list_insert (PangoAttrList *list,
                            PangoAttribute *attr);
    void pango_attr_list_insert_before (PangoAttrList *list,
                            PangoAttribute *attr);
    void pango_attr_list_change (PangoAttrList *list,
                            PangoAttribute *attr);
    void pango_attr_list_splice (PangoAttrList *list,
                            PangoAttrList *other,
                            gint pos,
                            gint len);

    PangoAttrList *pango_attr_list_filter (PangoAttrList *list,
                    PangoAttrFilterFunc func,
                    gpointer data);

    PangoAttrIterator *pango_attr_list_get_iterator (PangoAttrList *list);

    void pango_attr_iterator_range (PangoAttrIterator *iterator,
                            gint *start,
                            gint *end);
    gboolean pango_attr_iterator_next (PangoAttrIterator *iterator);
    PangoAttrIterator *pango_attr_iterator_copy (PangoAttrIterator *iterator);
    void pango_attr_iterator_destroy (PangoAttrIterator *iterator);
    PangoAttribute * pango_attr_iterator_get (PangoAttrIterator *iterator,
                            PangoAttrType type);
    void pango_attr_iterator_get_font (PangoAttrIterator *iterator,
                            PangoFontDescription *desc,
                            PangoLanguage **language,
                            GSList **extra_attrs);
    GSList * pango_attr_iterator_get_attrs (PangoAttrIterator *iterator);


    gboolean pango_parse_markup ( char *markup_text,
                int length,
                gunichar accel_marker,
                PangoAttrList **attr_list,
                char **text,
                gunichar *accel_char,
                GError **error);






    alias _PangoAnalysis PangoAnalysis;

    alias _PangoItem PangoItem;


    struct _PangoAnalysis {
    PangoEngineShape *shape_engine;
    PangoEngineLang *lang_engine;
    PangoFont *font;
    guint8 level;
    PangoLanguage *language;
    GSList *extra_attrs;
    }

    struct _PangoItem {
    gint offset;
    gint length;
    gint num_chars;
    PangoAnalysis analysis;
    }

    PangoItem *pango_item_new ();
    PangoItem *pango_item_copy (PangoItem *item);
    void pango_item_free (PangoItem *item);
    PangoItem *pango_item_split (PangoItem *orig,
                int split_index,
                int split_offset);





    struct _PangoLogAttr {
    guint is_line_break;

    guint is_mandatory_break;

    guint is_char_break;

    guint is_white;




    guint is_cursor_position;






    guint is_word_start;
    guint is_word_end;
    guint is_sentence_boundary;
    guint is_sentence_start;
    guint is_sentence_end;




    guint backspace_deletes_character;
    }




    void pango_break ( gchar *text,
            int length,
            PangoAnalysis *analysis,
            PangoLogAttr *attrs,
            int attrs_len);

    void pango_find_paragraph_boundary ( gchar *text,
                    gint length,
                    gint *paragraph_delimiter_index,
                    gint *next_paragraph_start);

    void pango_get_log_attrs ( char *text,
                int length,
                int level,
                PangoLanguage *language,
                PangoLogAttr *log_attrs,
                int attrs_len);


    GType pango_fontset_get_type () ;

    alias _PangoFontset PangoFontset;
    alias void _PangoFontset;

    alias gboolean (*PangoFontsetForeachFunc) (PangoFontset *fontset,
                        PangoFont *font,
                        gpointer data);

    PangoFont * pango_fontset_get_font (PangoFontset *fontset,
                        guint wc);
    PangoFontMetrics *pango_fontset_get_metrics (PangoFontset *fontset);
    void pango_fontset_foreach (PangoFontset *fontset,
                        PangoFontsetForeachFunc func,
                        gpointer data);








    alias _PangoContext PangoContext;
    alias void _PangoContext;

    alias _PangoFontMap PangoFontMap;
    alias void _PangoFontMap;


    GType pango_font_map_get_type () ;
    PangoFont * pango_font_map_load_font (PangoFontMap *fontmap,
                        PangoContext *context,
                        PangoFontDescription *desc);
    PangoFontset *pango_font_map_load_fontset (PangoFontMap *fontmap,
                        PangoContext *context,
                        PangoFontDescription *desc,
                        PangoLanguage *language);
    void pango_font_map_list_families (PangoFontMap *fontmap,
                        PangoFontFamily ***families,
                        int *n_families);










    alias _PangoContextClass PangoContextClass;
    alias void _PangoContextClass;

    GType pango_context_get_type () ;






    PangoFontMap *pango_context_get_font_map (PangoContext *context);

    void pango_context_list_families (PangoContext *context,
                        PangoFontFamily ***families,
                        int *n_families);
    PangoFont * pango_context_load_font (PangoContext *context,
                        PangoFontDescription *desc);
    PangoFontset *pango_context_load_fontset (PangoContext *context,
                        PangoFontDescription *desc,
                        PangoLanguage *language);

    PangoFontMetrics *pango_context_get_metrics (PangoContext *context,
                            PangoFontDescription *desc,
                        PangoLanguage *language);

    void pango_context_set_font_description (PangoContext *context,
                                PangoFontDescription *desc);
    PangoFontDescription * pango_context_get_font_description (PangoContext *context);
    PangoLanguage *pango_context_get_language (PangoContext *context);
    void pango_context_set_language (PangoContext *context,
                                PangoLanguage *language);
    void pango_context_set_base_dir (PangoContext *context,
                                PangoDirection direction);
    PangoDirection pango_context_get_base_dir (PangoContext *context);

    void pango_context_set_matrix (PangoContext *context,
                            PangoMatrix *matrix);
    PangoMatrix *pango_context_get_matrix (PangoContext *context);





    GList *pango_itemize (PangoContext *context,
                    char *text,
                    int start_index,
                    int length,
                    PangoAttrList *attrs,
                    PangoAttrIterator *cached_iter);
    GList *pango_itemize_with_base_dir (PangoContext *context,
                    PangoDirection base_dir,
                    char *text,
                    int start_index,
                    int length,
                    PangoAttrList *attrs,
                    PangoAttrIterator *cached_iter);





    alias _PangoGlyphGeometry PangoGlyphGeometry;

    alias _PangoGlyphVisAttr PangoGlyphVisAttr;

    alias _PangoGlyphInfo PangoGlyphInfo;

    alias _PangoGlyphString PangoGlyphString;



    alias gint32 PangoGlyphUnit;



    struct _PangoGlyphGeometry {
    PangoGlyphUnit width;
    PangoGlyphUnit x_offset;
    PangoGlyphUnit y_offset;
    }



    struct _PangoGlyphVisAttr {
    guint is_cluster_start;
    }



    struct _PangoGlyphInfo {
    PangoGlyph glyph;
    PangoGlyphGeometry geometry;
    PangoGlyphVisAttr attr;
    }




    struct _PangoGlyphString {
    gint num_glyphs;

    PangoGlyphInfo *glyphs;






    gint *log_clusters;


    gint space;
    }



    PangoGlyphString *pango_glyph_string_new ();
    void pango_glyph_string_set_size (PangoGlyphString *string,
                        gint new_len);
    GType pango_glyph_string_get_type ();
    PangoGlyphString *pango_glyph_string_copy (PangoGlyphString *string);
    void pango_glyph_string_free (PangoGlyphString *string);
    void pango_glyph_string_extents (PangoGlyphString *glyphs,
                        PangoFont *font,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);

    void pango_glyph_string_extents_range (PangoGlyphString *glyphs,
                            int start,
                            int end,
                            PangoFont *font,
                            PangoRectangle *ink_rect,
                            PangoRectangle *logical_rect);

    void pango_glyph_string_get_logical_widths (PangoGlyphString *glyphs,
                        char *text,
                        int length,
                        int embedding_level,
                        int *logical_widths);

    void pango_glyph_string_index_to_x (PangoGlyphString *glyphs,
                    char *text,
                    int length,
                    PangoAnalysis *analysis,
                    int index_,
                    gboolean trailing,
                    int *x_pos);
    void pango_glyph_string_x_to_index (PangoGlyphString *glyphs,
                    char *text,
                    int length,
                    PangoAnalysis *analysis,
                    int x_pos,
                    int *index_,
                    int *trailing);



    void pango_shape ( gchar *text,
            gint length,
            PangoAnalysis *analysis,
            PangoGlyphString *glyphs);

    GList *pango_reorder_items (GList *logical_items);










    alias _PangoScriptIter PangoScriptIter;
    alias void _PangoScriptIter;

    const int PANGO_SCALE = 1024;
    enum PangoScript {
    PANGO_SCRIPT_INVALID_CODE = -1,
    PANGO_SCRIPT_COMMON = 0,
    PANGO_SCRIPT_INHERITED,
    PANGO_SCRIPT_ARABIC,
    PANGO_SCRIPT_ARMENIAN,
    PANGO_SCRIPT_BENGALI,
    PANGO_SCRIPT_BOPOMOFO,
    PANGO_SCRIPT_CHEROKEE,
    PANGO_SCRIPT_COPTIC,
    PANGO_SCRIPT_CYRILLIC,
    PANGO_SCRIPT_DESERET,
    PANGO_SCRIPT_DEVANAGARI,
    PANGO_SCRIPT_ETHIOPIC,
    PANGO_SCRIPT_GEORGIAN,
    PANGO_SCRIPT_GOTHIC,
    PANGO_SCRIPT_GREEK,
    PANGO_SCRIPT_GUJARATI,
    PANGO_SCRIPT_GURMUKHI,
    PANGO_SCRIPT_HAN,
    PANGO_SCRIPT_HANGUL,
    PANGO_SCRIPT_HEBREW,
    PANGO_SCRIPT_HIRAGANA,
    PANGO_SCRIPT_KANNADA,
    PANGO_SCRIPT_KATAKANA,
    PANGO_SCRIPT_KHMER,
    PANGO_SCRIPT_LAO,
    PANGO_SCRIPT_LATIN,
    PANGO_SCRIPT_MALAYALAM,
    PANGO_SCRIPT_MONGOLIAN,
    PANGO_SCRIPT_MYANMAR,
    PANGO_SCRIPT_OGHAM,
    PANGO_SCRIPT_OLD_ITALIC,
    PANGO_SCRIPT_ORIYA,
    PANGO_SCRIPT_RUNIC,
    PANGO_SCRIPT_SINHALA,
    PANGO_SCRIPT_SYRIAC,
    PANGO_SCRIPT_TAMIL,
    PANGO_SCRIPT_TELUGU,
    PANGO_SCRIPT_THAANA,
    PANGO_SCRIPT_THAI,
    PANGO_SCRIPT_TIBETAN,
    PANGO_SCRIPT_CANADIAN_ABORIGINAL,
    PANGO_SCRIPT_YI,
    PANGO_SCRIPT_TAGALOG,
    PANGO_SCRIPT_HANUNOO,
    PANGO_SCRIPT_BUHID,
    PANGO_SCRIPT_TAGBANWA,


    PANGO_SCRIPT_BRAILLE,
    PANGO_SCRIPT_CYPRIOT,
    PANGO_SCRIPT_LIMBU,
    PANGO_SCRIPT_OSMANYA,
    PANGO_SCRIPT_SHAVIAN,
    PANGO_SCRIPT_LINEAR_B,
    PANGO_SCRIPT_TAI_LE,
    PANGO_SCRIPT_UGARITIC
    };


    PangoScript pango_script_for_unichar (gunichar ch);

    PangoScriptIter *pango_script_iter_new ( char *text,
                        int length);
    void pango_script_iter_get_range (PangoScriptIter *iter,
                        char **start,
                        char **end,
                        PangoScript *script);
    gboolean pango_script_iter_next (PangoScriptIter *iter);
    void pango_script_iter_free (PangoScriptIter *iter);

    PangoLanguage *pango_script_get_sample_language (PangoScript script);
    gboolean pango_language_includes_script (PangoLanguage *language,
                            PangoScript script);









    GType pango_attr_type_get_type ();


    GType pango_underline_get_type ();




    GType pango_coverage_level_get_type ();




    GType pango_style_get_type ();


    GType pango_variant_get_type ();


    GType pango_weight_get_type ();


    GType pango_stretch_get_type ();


    GType pango_font_mask_get_type ();




    GType pango_alignment_get_type ();


    GType pango_wrap_mode_get_type ();


    GType pango_ellipsize_mode_get_type ();




    GType pango_script_get_type ();




    GType pango_tab_align_get_type ();




    GType pango_direction_get_type ();









    alias _PangoGlyphItem PangoGlyphItem;


    struct _PangoGlyphItem {
    PangoItem *item;
    PangoGlyphString *glyphs;
    }

    PangoGlyphItem *pango_glyph_item_split (PangoGlyphItem *orig,
                            char *text,
                        int split_index);
    void pango_glyph_item_free (PangoGlyphItem *glyph_item);
    GSList * pango_glyph_item_apply_attrs (PangoGlyphItem *glyph_item,
                            char *text,
                        PangoAttrList *list);
    void pango_glyph_item_letter_space (PangoGlyphItem *glyph_item,
                            char *text,
                        PangoLogAttr *log_attrs,
                        int letter_spacing);




    alias _PangoTabArray PangoTabArray;
    alias void _PangoTabArray;


    enum PangoTabAlign {
    PANGO_TAB_LEFT
    };




    PangoTabArray *pango_tab_array_new (gint initial_size,
                            gboolean positions_in_pixels);
    PangoTabArray *pango_tab_array_new_with_positions (gint size,
                            gboolean positions_in_pixels,
                            PangoTabAlign first_alignment,
                            gint first_position,
                            ...);
    GType pango_tab_array_get_type ();
    PangoTabArray *pango_tab_array_copy (PangoTabArray *src);
    void pango_tab_array_free (PangoTabArray *tab_array);
    gint pango_tab_array_get_size (PangoTabArray *tab_array);
    void pango_tab_array_resize (PangoTabArray *tab_array,
                            gint new_size);
    void pango_tab_array_set_tab (PangoTabArray *tab_array,
                            gint tab_index,
                            PangoTabAlign alignment,
                            gint location);
    void pango_tab_array_get_tab (PangoTabArray *tab_array,
                            gint tab_index,
                            PangoTabAlign *alignment,
                            gint *location);
    void pango_tab_array_get_tabs (PangoTabArray *tab_array,
                            PangoTabAlign **alignments,
                            gint **locations);

    gboolean pango_tab_array_get_positions_in_pixels (PangoTabArray *tab_array);






    alias _PangoLayout PangoLayout;
    alias void _PangoLayout;

    alias _PangoLayoutClass PangoLayoutClass;
    alias void _PangoLayoutClass;

    alias _PangoLayoutLine PangoLayoutLine;



    alias PangoGlyphItem PangoLayoutRun;

    enum PangoAlignment {
    PANGO_ALIGN_LEFT,
    PANGO_ALIGN_CENTER,
    PANGO_ALIGN_RIGHT
    };


    enum PangoWrapMode {
    PANGO_WRAP_WORD,
    PANGO_WRAP_CHAR,
    PANGO_WRAP_WORD_CHAR
    };

    enum PangoEllipsizeMode {
    PANGO_ELLIPSIZE_NONE,
    PANGO_ELLIPSIZE_START,
    PANGO_ELLIPSIZE_MIDDLE,
    PANGO_ELLIPSIZE_END
    };


    struct _PangoLayoutLine {
    PangoLayout *layout;
    gint start_index;
    gint length;
    GSList *runs;
    guint is_paragraph_start;
    guint resolved_dir;
    }
    GType pango_layout_get_type () ;
    PangoLayout *pango_layout_new (PangoContext *context);
    PangoLayout *pango_layout_copy (PangoLayout *src);

    PangoContext *pango_layout_get_context (PangoLayout *layout);

    void pango_layout_set_attributes (PangoLayout *layout,
                        PangoAttrList *attrs);
    PangoAttrList *pango_layout_get_attributes (PangoLayout *layout);

    void pango_layout_set_text (PangoLayout *layout,
                        char *text,
                        int length);
    char *pango_layout_get_text (PangoLayout *layout);

    void pango_layout_set_markup (PangoLayout *layout,
                        char *markup,
                        int length);

    void pango_layout_set_markup_with_accel (PangoLayout *layout,
                            char *markup,
                            int length,
                            gunichar accel_marker,
                            gunichar *accel_char);

    void pango_layout_set_font_description (PangoLayout *layout,
                            PangoFontDescription *desc);
    void pango_layout_set_width (PangoLayout *layout,
                            int width);
    int pango_layout_get_width (PangoLayout *layout);
    void pango_layout_set_wrap (PangoLayout *layout,
                            PangoWrapMode wrap);
    PangoWrapMode pango_layout_get_wrap (PangoLayout *layout);
    void pango_layout_set_indent (PangoLayout *layout,
                            int indent);
    int pango_layout_get_indent (PangoLayout *layout);
    void pango_layout_set_spacing (PangoLayout *layout,
                            int spacing);
    int pango_layout_get_spacing (PangoLayout *layout);
    void pango_layout_set_justify (PangoLayout *layout,
                            gboolean justify);
    gboolean pango_layout_get_justify (PangoLayout *layout);
    void pango_layout_set_auto_dir (PangoLayout *layout,
                            gboolean auto_dir);
    gboolean pango_layout_get_auto_dir (PangoLayout *layout);
    void pango_layout_set_alignment (PangoLayout *layout,
                            PangoAlignment alignment);
    PangoAlignment pango_layout_get_alignment (PangoLayout *layout);

    void pango_layout_set_tabs (PangoLayout *layout,
                            PangoTabArray *tabs);

    PangoTabArray* pango_layout_get_tabs (PangoLayout *layout);

    void pango_layout_set_single_paragraph_mode (PangoLayout *layout,
                            gboolean setting);
    gboolean pango_layout_get_single_paragraph_mode (PangoLayout *layout);

    void pango_layout_set_ellipsize (PangoLayout *layout,
                        PangoEllipsizeMode ellipsize);
    PangoEllipsizeMode pango_layout_get_ellipsize (PangoLayout *layout);

    void pango_layout_context_changed (PangoLayout *layout);

    void pango_layout_get_log_attrs (PangoLayout *layout,
                    PangoLogAttr **attrs,
                    gint *n_attrs);

    void pango_layout_index_to_pos (PangoLayout *layout,
                        int index_,
                        PangoRectangle *pos);
    void pango_layout_get_cursor_pos (PangoLayout *layout,
                        int index_,
                        PangoRectangle *strong_pos,
                        PangoRectangle *weak_pos);
    void pango_layout_move_cursor_visually (PangoLayout *layout,
                        gboolean strong,
                        int old_index,
                        int old_trailing,
                        int direction,
                        int *new_index,
                        int *new_trailing);
    gboolean pango_layout_xy_to_index (PangoLayout *layout,
                        int x,
                        int y,
                        int *index_,
                        int *trailing);
    void pango_layout_get_extents (PangoLayout *layout,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);
    void pango_layout_get_pixel_extents (PangoLayout *layout,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);
    void pango_layout_get_size (PangoLayout *layout,
                        int *width,
                        int *height);
    void pango_layout_get_pixel_size (PangoLayout *layout,
                        int *width,
                        int *height);

    int pango_layout_get_line_count (PangoLayout *layout);
    PangoLayoutLine *pango_layout_get_line (PangoLayout *layout,
                            int line);
    GSList * pango_layout_get_lines (PangoLayout *layout);

    void pango_layout_line_ref (PangoLayoutLine *line);
    void pango_layout_line_unref (PangoLayoutLine *line);
    gboolean pango_layout_line_x_to_index (PangoLayoutLine *line,
                        int x_pos,
                        int *index_,
                        int *trailing);
    void pango_layout_line_index_to_x (PangoLayoutLine *line,
                        int index_,
                        gboolean trailing,
                        int *x_pos);
    void pango_layout_line_get_x_ranges (PangoLayoutLine *line,
                        int start_index,
                        int end_index,
                        int **ranges,
                        int *n_ranges);
    void pango_layout_line_get_extents (PangoLayoutLine *line,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);
    void pango_layout_line_get_pixel_extents (PangoLayoutLine *layout_line,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);

    alias _PangoLayoutIter PangoLayoutIter;
    alias void _PangoLayoutIter;




    GType pango_layout_iter_get_type ();

    PangoLayoutIter *pango_layout_get_iter (PangoLayout *layout);
    void pango_layout_iter_free (PangoLayoutIter *iter);

    int pango_layout_iter_get_index (PangoLayoutIter *iter);
    PangoLayoutRun *pango_layout_iter_get_run (PangoLayoutIter *iter);
    PangoLayoutLine *pango_layout_iter_get_line (PangoLayoutIter *iter);
    gboolean pango_layout_iter_at_last_line (PangoLayoutIter *iter);

    gboolean pango_layout_iter_next_char (PangoLayoutIter *iter);
    gboolean pango_layout_iter_next_cluster (PangoLayoutIter *iter);
    gboolean pango_layout_iter_next_run (PangoLayoutIter *iter);
    gboolean pango_layout_iter_next_line (PangoLayoutIter *iter);

    void pango_layout_iter_get_char_extents (PangoLayoutIter *iter,
                        PangoRectangle *logical_rect);
    void pango_layout_iter_get_cluster_extents (PangoLayoutIter *iter,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);
    void pango_layout_iter_get_run_extents (PangoLayoutIter *iter,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);
    void pango_layout_iter_get_line_extents (PangoLayoutIter *iter,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);



    void pango_layout_iter_get_line_yrange (PangoLayoutIter *iter,
                        int *y0_,
                        int *y1_);
    void pango_layout_iter_get_layout_extents (PangoLayoutIter *iter,
                        PangoRectangle *ink_rect,
                        PangoRectangle *logical_rect);
    int pango_layout_iter_get_baseline (PangoLayoutIter *iter);


    alias _GdkPoint GdkPoint;

    alias _GdkRectangle GdkRectangle;

    alias _GdkSegment GdkSegment;

    alias _GdkSpan GdkSpan;







    alias guint32 GdkWChar;

    alias _GdkAtom *GdkAtom;
    alias void _GdkAtom;

    alias guint32 GdkNativeWindow;




    alias _GdkColor GdkColor;

    alias _GdkColormap GdkColormap;

    alias _GdkCursor GdkCursor;

    alias _GdkFont GdkFont;

    alias _GdkGC GdkGC;

    alias _GdkImage GdkImage;

    alias _GdkRegion GdkRegion;
    alias void _GdkRegion;

    alias _GdkVisual GdkVisual;


    alias _GdkDrawable GdkDrawable;

    alias _GdkDrawable GdkBitmap;

    alias _GdkDrawable GdkPixmap;

    alias _GdkDrawable GdkWindow;

    alias _GdkDisplay GdkDisplay;

    alias _GdkScreen GdkScreen;


    enum GdkByteOrder {
    GDK_LSB_FIRST,
    GDK_MSB_FIRST
    };




    enum GdkModifierType {
    GDK_SHIFT_MASK = 1 << 0,
    GDK_LOCK_MASK = 1 << 1,
    GDK_CONTROL_MASK = 1 << 2,
    GDK_MOD1_MASK = 1 << 3,
    GDK_MOD2_MASK = 1 << 4,
    GDK_MOD3_MASK = 1 << 5,
    GDK_MOD4_MASK = 1 << 6,
    GDK_MOD5_MASK = 1 << 7,
    GDK_BUTTON1_MASK = 1 << 8,
    GDK_BUTTON2_MASK = 1 << 9,
    GDK_BUTTON3_MASK = 1 << 10,
    GDK_BUTTON4_MASK = 1 << 11,
    GDK_BUTTON5_MASK = 1 << 12,




    GDK_RELEASE_MASK = 1 << 30,
    GDK_MODIFIER_MASK = GDK_RELEASE_MASK | 0x1fff
    };


    enum GdkInputCondition {
    GDK_INPUT_READ = 1 << 0,
    GDK_INPUT_WRITE = 1 << 1,
    GDK_INPUT_EXCEPTION = 1 << 2
    };


    enum GdkStatus {
    GDK_OK = 0,
    GDK_ERROR = -1,
    GDK_ERROR_PARAM = -2,
    GDK_ERROR_FILE = -3,
    GDK_ERROR_MEM = -4
    };






    enum GdkGrabStatus {
    GDK_GRAB_SUCCESS = 0,
    GDK_GRAB_ALREADY_GRABBED = 1,
    GDK_GRAB_INVALID_TIME = 2,
    GDK_GRAB_NOT_VIEWABLE = 3,
    GDK_GRAB_FROZEN = 4
    };


    alias void (*GdkInputFunction) (gpointer data,
                    gint source,
                    GdkInputCondition condition);

    alias void (*GdkDestroyNotify) (gpointer data);

    struct _GdkPoint {
    gint x;
    gint y;
    }

    struct _GdkRectangle {
    gint x;
    gint y;
    gint width;
    gint height;
    }

    struct _GdkSegment {
    gint x1;
    gint y1;
    gint x2;
    gint y2;
    }

    struct _GdkSpan {
    gint x;
    gint y;
    gint width;
    }

    struct _GdkColor {
      guint32 pixel;
    guint16 red;
    guint16 green;
    guint16 blue;
    }




    alias _GdkColormapClass GdkColormapClass;

    struct _GdkColormap {
    GObject parent_instance;


    gint size;
    GdkColor *colors;


    GdkVisual *visual;

    gpointer windowing_data;
    }

    struct _GdkColormapClass {
    GObjectClass parent_class;

    }

    GType gdk_colormap_get_type () ;

    GdkColormap* gdk_colormap_new (GdkVisual *visual,
                    gboolean allocate);


    GdkColormap* gdk_colormap_ref (GdkColormap *cmap);
    void gdk_colormap_unref (GdkColormap *cmap);



    GdkColormap* gdk_colormap_get_system ();


    GdkScreen *gdk_colormap_get_screen (GdkColormap *cmap);


    gint gdk_colormap_get_system_size ();




    void gdk_colormap_change (GdkColormap *colormap,
                gint ncolors);


    gint gdk_colormap_alloc_colors (GdkColormap *colormap,
                    GdkColor *colors,
                    gint ncolors,
                    gboolean writeable,
                    gboolean best_match,
                    gboolean *success);
    gboolean gdk_colormap_alloc_color (GdkColormap *colormap,
                    GdkColor *color,
                    gboolean writeable,
                    gboolean best_match);
    void gdk_colormap_free_colors (GdkColormap *colormap,
                    GdkColor *colors,
                    gint ncolors);
    void gdk_colormap_query_color (GdkColormap *colormap,
                    gulong pixel,
                    GdkColor *result);

    GdkVisual *gdk_colormap_get_visual (GdkColormap *colormap);

    GdkColor *gdk_color_copy ( GdkColor *color);
    void gdk_color_free (GdkColor *color);
    gint gdk_color_parse ( gchar *spec,
                GdkColor *color);
    guint gdk_color_hash ( GdkColor *colora);
    gboolean gdk_color_equal ( GdkColor *colora,
                GdkColor *colorb);

    GType gdk_color_get_type ();



    void gdk_colors_store (GdkColormap *colormap,
                GdkColor *colors,
                gint ncolors);
    gint gdk_color_white (GdkColormap *colormap,
                GdkColor *color);
    gint gdk_color_black (GdkColormap *colormap,
                GdkColor *color);
    gint gdk_color_alloc (GdkColormap *colormap,
                GdkColor *color);
    gint gdk_color_change (GdkColormap *colormap,
                GdkColor *color);




    gint gdk_colors_alloc (GdkColormap *colormap,
                gboolean contiguous,
                gulong *planes,
                gint nplanes,
                gulong *pixels,
                gint npixels);
    void gdk_colors_free (GdkColormap *colormap,
                gulong *pixels,
                gint npixels,
                gulong planes);




    guint gdk_pixbuf_major_version, gdk_pixbuf_minor_version, gdk_pixbuf_micro_version;
    char *gdk_pixbuf_version;







    enum GdkPixbufAlphaMode {
        GDK_PIXBUF_ALPHA_BILEVEL,
        GDK_PIXBUF_ALPHA_FULL
    };






    enum GdkColorspace {
        GDK_COLORSPACE_RGB
    };



    alias _GdkPixbuf GdkPixbuf;
    alias void _GdkPixbuf;

    alias _GdkPixbufAnimation GdkPixbufAnimation;
    alias void _GdkPixbufAnimation;

    alias _GdkPixbufAnimationIter GdkPixbufAnimationIter;
    alias void _GdkPixbufAnimationIter;

    alias void (* GdkPixbufDestroyNotify) (guchar *pixels, gpointer data);



    enum GdkPixbufError {

        GDK_PIXBUF_ERROR_CORRUPT_IMAGE,

        GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY,

        GDK_PIXBUF_ERROR_BAD_OPTION,

        GDK_PIXBUF_ERROR_UNKNOWN_TYPE,

        GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION,
        GDK_PIXBUF_ERROR_FAILED
    };


    GQuark gdk_pixbuf_error_quark () ;



    GType gdk_pixbuf_get_type () ;




    GdkPixbuf *gdk_pixbuf_ref (GdkPixbuf *pixbuf);
    void gdk_pixbuf_unref (GdkPixbuf *pixbuf);




    GdkColorspace gdk_pixbuf_get_colorspace ( GdkPixbuf *pixbuf);
    int gdk_pixbuf_get_n_channels ( GdkPixbuf *pixbuf);
    gboolean gdk_pixbuf_get_has_alpha ( GdkPixbuf *pixbuf);
    int gdk_pixbuf_get_bits_per_sample ( GdkPixbuf *pixbuf);
    guchar *gdk_pixbuf_get_pixels ( GdkPixbuf *pixbuf);
    int gdk_pixbuf_get_width ( GdkPixbuf *pixbuf);
    int gdk_pixbuf_get_height ( GdkPixbuf *pixbuf);
    int gdk_pixbuf_get_rowstride ( GdkPixbuf *pixbuf);




    GdkPixbuf *gdk_pixbuf_new (GdkColorspace colorspace, gboolean has_alpha, int bits_per_sample,
                int width, int height);



    GdkPixbuf *gdk_pixbuf_copy ( GdkPixbuf *pixbuf);


    GdkPixbuf *gdk_pixbuf_new_subpixbuf (GdkPixbuf *src_pixbuf,
                    int src_x,
                    int src_y,
                    int width,
                    int height);



    GdkPixbuf *gdk_pixbuf_new_from_file ( char *filename,
                    GError **error);

    GdkPixbuf *gdk_pixbuf_new_from_file_at_size ( char *filename,
                        int width,
                        int height,
                        GError **error);

    GdkPixbuf *gdk_pixbuf_new_from_data ( guchar *data,
                    GdkColorspace colorspace,
                    gboolean has_alpha,
                    int bits_per_sample,
                    int width, int height,
                    int rowstride,
                    GdkPixbufDestroyNotify destroy_fn,
                    gpointer destroy_fn_data);

    GdkPixbuf *gdk_pixbuf_new_from_xpm_data ( char **data);
    GdkPixbuf* gdk_pixbuf_new_from_inline (gint data_length,
                        guint8 *data,
                        gboolean copy_pixels,
                        GError **error);


    void gdk_pixbuf_fill (GdkPixbuf *pixbuf,
                        guint32 pixel);



    gboolean gdk_pixbuf_save (GdkPixbuf *pixbuf,
                    char *filename,
                    char *type,
                    GError **error,
                    ...);

    gboolean gdk_pixbuf_savev (GdkPixbuf *pixbuf,
                    char *filename,
                    char *type,
                    char **option_keys,
                    char **option_values,
                    GError **error);



    alias gboolean (*GdkPixbufSaveFunc) ( gchar *buf,
                        gsize count,
                        GError **error,
                        gpointer data);

    gboolean gdk_pixbuf_save_to_callback (GdkPixbuf *pixbuf,
                        GdkPixbufSaveFunc save_func,
                        gpointer user_data,
                        char *type,
                        GError **error,
                        ...);

    gboolean gdk_pixbuf_save_to_callbackv (GdkPixbuf *pixbuf,
                        GdkPixbufSaveFunc save_func,
                        gpointer user_data,
                        char *type,
                        char **option_keys,
                        char **option_values,
                        GError **error);



    gboolean gdk_pixbuf_save_to_buffer (GdkPixbuf *pixbuf,
                        gchar **buffer,
                        gsize *buffer_size,
                        char *type,
                        GError **error,
                        ...);

    gboolean gdk_pixbuf_save_to_bufferv (GdkPixbuf *pixbuf,
                        gchar **buffer,
                        gsize *buffer_size,
                        char *type,
                        char **option_keys,
                        char **option_values,
                        GError **error);


    GdkPixbuf *gdk_pixbuf_add_alpha ( GdkPixbuf *pixbuf, gboolean substitute_color,
                    guchar r, guchar g, guchar b);


    void gdk_pixbuf_copy_area ( GdkPixbuf *src_pixbuf,
                int src_x, int src_y,
                int width, int height,
                GdkPixbuf *dest_pixbuf,
                int dest_x, int dest_y);


    void gdk_pixbuf_saturate_and_pixelate ( GdkPixbuf *src,
                    GdkPixbuf *dest,
                    gfloat saturation,
                    gboolean pixelate);
    enum GdkInterpType {
        GDK_INTERP_NEAREST,
        GDK_INTERP_TILES,
        GDK_INTERP_BILINEAR,
        GDK_INTERP_HYPER
    };


    void gdk_pixbuf_scale ( GdkPixbuf *src,
                    GdkPixbuf *dest,
                    int dest_x,
                    int dest_y,
                    int dest_width,
                    int dest_height,
                    double offset_x,
                    double offset_y,
                    double scale_x,
                    double scale_y,
                    GdkInterpType interp_type);
    void gdk_pixbuf_composite ( GdkPixbuf *src,
                    GdkPixbuf *dest,
                    int dest_x,
                    int dest_y,
                    int dest_width,
                    int dest_height,
                    double offset_x,
                    double offset_y,
                    double scale_x,
                    double scale_y,
                    GdkInterpType interp_type,
                    int overall_alpha);
    void gdk_pixbuf_composite_color ( GdkPixbuf *src,
                    GdkPixbuf *dest,
                    int dest_x,
                    int dest_y,
                    int dest_width,
                    int dest_height,
                    double offset_x,
                    double offset_y,
                    double scale_x,
                    double scale_y,
                    GdkInterpType interp_type,
                    int overall_alpha,
                    int check_x,
                    int check_y,
                    int check_size,
                    guint32 color1,
                    guint32 color2);

    GdkPixbuf *gdk_pixbuf_scale_simple ( GdkPixbuf *src,
                        int dest_width,
                        int dest_height,
                        GdkInterpType interp_type);

    GdkPixbuf *gdk_pixbuf_composite_color_simple ( GdkPixbuf *src,
                        int dest_width,
                        int dest_height,
                        GdkInterpType interp_type,
                        int overall_alpha,
                        int check_size,
                        guint32 color1,
                        guint32 color2);





    GType gdk_pixbuf_animation_get_type () ;

    GdkPixbufAnimation *gdk_pixbuf_animation_new_from_file ( char *filename,
                                GError **error);


    GdkPixbufAnimation *gdk_pixbuf_animation_ref (GdkPixbufAnimation *animation);
    void gdk_pixbuf_animation_unref (GdkPixbufAnimation *animation);


    int gdk_pixbuf_animation_get_width (GdkPixbufAnimation *animation);
    int gdk_pixbuf_animation_get_height (GdkPixbufAnimation *animation);
    gboolean gdk_pixbuf_animation_is_static_image (GdkPixbufAnimation *animation);
    GdkPixbuf *gdk_pixbuf_animation_get_static_image (GdkPixbufAnimation *animation);

    GdkPixbufAnimationIter *gdk_pixbuf_animation_get_iter (GdkPixbufAnimation *animation,
                                        GTimeVal *start_time);
    GType gdk_pixbuf_animation_iter_get_type () ;
    int gdk_pixbuf_animation_iter_get_delay_time (GdkPixbufAnimationIter *iter);
    GdkPixbuf *gdk_pixbuf_animation_iter_get_pixbuf (GdkPixbufAnimationIter *iter);
    gboolean gdk_pixbuf_animation_iter_on_currently_loading_frame (GdkPixbufAnimationIter *iter);
    gboolean gdk_pixbuf_animation_iter_advance (GdkPixbufAnimationIter *iter,
                                        GTimeVal *current_time);




    gchar * gdk_pixbuf_get_option (GdkPixbuf *pixbuf,
                        gchar *key);



    alias _GdkPixbufFormat GdkPixbufFormat;
    alias void _GdkPixbufFormat;


    GSList *gdk_pixbuf_get_formats ();
    gchar *gdk_pixbuf_format_get_name (GdkPixbufFormat *format);
    gchar *gdk_pixbuf_format_get_description (GdkPixbufFormat *format);
    gchar **gdk_pixbuf_format_get_mime_types (GdkPixbufFormat *format);
    gchar **gdk_pixbuf_format_get_extensions (GdkPixbufFormat *format);
    gboolean gdk_pixbuf_format_is_writable (GdkPixbufFormat *format);

    GdkPixbufFormat *gdk_pixbuf_get_file_info ( gchar *filename,
                        gint *width,
                        gint *height);




    alias _GdkPixbufLoader GdkPixbufLoader;

    struct _GdkPixbufLoader {
    GObject parent_instance;


    gpointer priv;
    }

    alias _GdkPixbufLoaderClass GdkPixbufLoaderClass;

    struct _GdkPixbufLoaderClass {
    GObjectClass parent_class;

    void (*size_prepared) (GdkPixbufLoader *loader,
                int width,
                int height);

    void (*area_prepared) (GdkPixbufLoader *loader);


    void (*area_updated) (GdkPixbufLoader *loader,
                int x,
                int y,
                int width,
                int height);

    void (*closed) (GdkPixbufLoader *loader);
    }

    GType gdk_pixbuf_loader_get_type () ;
    GdkPixbufLoader * gdk_pixbuf_loader_new ();
    GdkPixbufLoader * gdk_pixbuf_loader_new_with_type ( char *image_type,
                            GError **error);
    GdkPixbufLoader * gdk_pixbuf_loader_new_with_mime_type ( char *mime_type,
                                GError **error);
    void gdk_pixbuf_loader_set_size (GdkPixbufLoader *loader,
                            int width,
                            int height);
    gboolean gdk_pixbuf_loader_write (GdkPixbufLoader *loader,
                            guchar *buf,
                            gsize count,
                            GError **error);
    GdkPixbuf * gdk_pixbuf_loader_get_pixbuf (GdkPixbufLoader *loader);
    GdkPixbufAnimation * gdk_pixbuf_loader_get_animation (GdkPixbufLoader *loader);
    gboolean gdk_pixbuf_loader_close (GdkPixbufLoader *loader,
                            GError **error);
    GdkPixbufFormat *gdk_pixbuf_loader_get_format (GdkPixbufLoader *loader);






    GType gdk_pixbuf_alpha_mode_get_type ();


    GType gdk_colorspace_get_type ();


    GType gdk_pixbuf_error_get_type ();


    GType gdk_interp_type_get_type ();



    enum GdkCursorType {
    GDK_X_CURSOR = 0,
    GDK_ARROW = 2,
    GDK_BASED_ARROW_DOWN = 4,
    GDK_BASED_ARROW_UP = 6,
    GDK_BOAT = 8,
    GDK_BOGOSITY = 10,
    GDK_BOTTOM_LEFT_CORNER = 12,
    GDK_BOTTOM_RIGHT_CORNER = 14,
    GDK_BOTTOM_SIDE = 16,
    GDK_BOTTOM_TEE = 18,
    GDK_BOX_SPIRAL = 20,
    GDK_CENTER_PTR = 22,
    GDK_CIRCLE = 24,
    GDK_CLOCK = 26,
    GDK_COFFEE_MUG = 28,
    GDK_CROSS = 30,
    GDK_CROSS_REVERSE = 32,
    GDK_CROSSHAIR = 34,
    GDK_DIAMOND_CROSS = 36,
    GDK_DOT = 38,
    GDK_DOTBOX = 40,
    GDK_DOUBLE_ARROW = 42,
    GDK_DRAFT_LARGE = 44,
    GDK_DRAFT_SMALL = 46,
    GDK_DRAPED_BOX = 48,
    GDK_EXCHANGE = 50,
    GDK_FLEUR = 52,
    GDK_GOBBLER = 54,
    GDK_GUMBY = 56,
    GDK_HAND1 = 58,
    GDK_HAND2 = 60,
    GDK_HEART = 62,
    GDK_ICON = 64,
    GDK_IRON_CROSS = 66,
    GDK_LEFT_PTR = 68,
    GDK_LEFT_SIDE = 70,
    GDK_LEFT_TEE = 72,
    GDK_LEFTBUTTON = 74,
    GDK_LL_ANGLE = 76,
    GDK_LR_ANGLE = 78,
    GDK_MAN = 80,
    GDK_MIDDLEBUTTON = 82,
    GDK_MOUSE = 84,
    GDK_PENCIL = 86,
    GDK_PIRATE = 88,
    GDK_PLUS = 90,
    GDK_QUESTION_ARROW = 92,
    GDK_RIGHT_PTR = 94,
    GDK_RIGHT_SIDE = 96,
    GDK_RIGHT_TEE = 98,
    GDK_RIGHTBUTTON = 100,
    GDK_RTL_LOGO = 102,
    GDK_SAILBOAT = 104,
    GDK_SB_DOWN_ARROW = 106,
    GDK_SB_H_DOUBLE_ARROW = 108,
    GDK_SB_LEFT_ARROW = 110,
    GDK_SB_RIGHT_ARROW = 112,
    GDK_SB_UP_ARROW = 114,
    GDK_SB_V_DOUBLE_ARROW = 116,
    GDK_SHUTTLE = 118,
    GDK_SIZING = 120,
    GDK_SPIDER = 122,
    GDK_SPRAYCAN = 124,
    GDK_STAR = 126,
    GDK_TARGET = 128,
    GDK_TCROSS = 130,
    GDK_TOP_LEFT_ARROW = 132,
    GDK_TOP_LEFT_CORNER = 134,
    GDK_TOP_RIGHT_CORNER = 136,
    GDK_TOP_SIDE = 138,
    GDK_TOP_TEE = 140,
    GDK_TREK = 142,
    GDK_UL_ANGLE = 144,
    GDK_UMBRELLA = 146,
    GDK_UR_ANGLE = 148,
    GDK_WATCH = 150,
    GDK_XTERM = 152,
    GDK_LAST_CURSOR,
    GDK_CURSOR_IS_PIXMAP = -1
    };


    struct _GdkCursor {
    GdkCursorType type;
    guint ref_count;
    }




    GType gdk_cursor_get_type ();

    GdkCursor* gdk_cursor_new_for_display (GdkDisplay *display,
                        GdkCursorType cursor_type);

    GdkCursor* gdk_cursor_new (GdkCursorType cursor_type);

    GdkCursor* gdk_cursor_new_from_pixmap (GdkPixmap *source,
                        GdkPixmap *mask,
                        GdkColor *fg,
                        GdkColor *bg,
                        gint x,
                        gint y);
    GdkCursor* gdk_cursor_new_from_pixbuf (GdkDisplay *display,
                        GdkPixbuf *pixbuf,
                        gint x,
                        gint y);
    GdkDisplay* gdk_cursor_get_display (GdkCursor *cursor);
    GdkCursor* gdk_cursor_ref (GdkCursor *cursor);
    void gdk_cursor_unref (GdkCursor *cursor);





    alias _GdkDragContext GdkDragContext;


    enum GdkDragAction {
    GDK_ACTION_DEFAULT = 1 << 0,
    GDK_ACTION_COPY = 1 << 1,
    GDK_ACTION_MOVE = 1 << 2,
    GDK_ACTION_LINK = 1 << 3,
    GDK_ACTION_PRIVATE = 1 << 4,
    GDK_ACTION_ASK = 1 << 5
    };


    enum GdkDragProtocol {
    GDK_DRAG_PROTO_MOTIF,
    GDK_DRAG_PROTO_XDND,
    GDK_DRAG_PROTO_ROOTWIN,

    GDK_DRAG_PROTO_NONE,
    GDK_DRAG_PROTO_WIN32_DROPFILES,
    GDK_DRAG_PROTO_OLE2,
    GDK_DRAG_PROTO_LOCAL
    };






    alias _GdkDragContextClass GdkDragContextClass;

    struct _GdkDragContext {
    GObject parent_instance;



    GdkDragProtocol protocol;

    gboolean is_source;

    GdkWindow *source_window;
    GdkWindow *dest_window;

    GList *targets;
    GdkDragAction actions;
    GdkDragAction suggested_action;
    GdkDragAction action;

    guint32 start_time;



    gpointer windowing_data;
    }

    struct _GdkDragContextClass {
    GObjectClass parent_class;


    }



    GType gdk_drag_context_get_type () ;
    GdkDragContext * gdk_drag_context_new ();


    void gdk_drag_context_ref (GdkDragContext *context);
    void gdk_drag_context_unref (GdkDragContext *context);




    void gdk_drag_status (GdkDragContext *context,
                        GdkDragAction action,
                        guint32 time_);
    void gdk_drop_reply (GdkDragContext *context,
                        gboolean ok,
                        guint32 time_);
    void gdk_drop_finish (GdkDragContext *context,
                        gboolean success,
                        guint32 time_);
    GdkAtom gdk_drag_get_selection (GdkDragContext *context);



    GdkDragContext * gdk_drag_begin (GdkWindow *window,
                    GList *targets);

    guint32 gdk_drag_get_protocol_for_display (GdkDisplay *display,
                        guint32 xid,
                        GdkDragProtocol *protocol);
    void gdk_drag_find_window_for_screen (GdkDragContext *context,
                        GdkWindow *drag_window,
                        GdkScreen *screen,
                        gint x_root,
                        gint y_root,
                        GdkWindow **dest_window,
                        GdkDragProtocol *protocol);


    guint32 gdk_drag_get_protocol (guint32 xid,
                GdkDragProtocol *protocol);
    void gdk_drag_find_window (GdkDragContext *context,
                GdkWindow *drag_window,
                gint x_root,
                gint y_root,
                GdkWindow **dest_window,
                GdkDragProtocol *protocol);


    gboolean gdk_drag_motion (GdkDragContext *context,
                    GdkWindow *dest_window,
                    GdkDragProtocol protocol,
                    gint x_root,
                    gint y_root,
                    GdkDragAction suggested_action,
                    GdkDragAction possible_actions,
                    guint32 time_);
    void gdk_drag_drop (GdkDragContext *context,
                    guint32 time_);
    void gdk_drag_abort (GdkDragContext *context,
                    guint32 time_);
    alias _GdkDeviceKey GdkDeviceKey;

    alias _GdkDeviceAxis GdkDeviceAxis;

    alias _GdkDevice GdkDevice;

    alias _GdkDeviceClass GdkDeviceClass;
    alias void _GdkDeviceClass;

    alias _GdkTimeCoord GdkTimeCoord;


    enum GdkExtensionMode {
    GDK_EXTENSION_EVENTS_NONE,
    GDK_EXTENSION_EVENTS_ALL,
    GDK_EXTENSION_EVENTS_CURSOR
    };


    enum GdkInputSource {
    GDK_SOURCE_MOUSE,
    GDK_SOURCE_PEN,
    GDK_SOURCE_ERASER,
    GDK_SOURCE_CURSOR
    };


    enum GdkInputMode {
    GDK_MODE_DISABLED,
    GDK_MODE_SCREEN,
    GDK_MODE_WINDOW
    };


    enum GdkAxisUse {
    GDK_AXIS_IGNORE,
    GDK_AXIS_X,
    GDK_AXIS_Y,
    GDK_AXIS_PRESSURE,
    GDK_AXIS_XTILT,
    GDK_AXIS_YTILT,
    GDK_AXIS_WHEEL,
    GDK_AXIS_LAST
    };


    struct _GdkDeviceKey {
    guint keyval;
    GdkModifierType modifiers;
    }

    struct _GdkDeviceAxis {
    GdkAxisUse use;
    gdouble min;
    gdouble max;
    }

    struct _GdkDevice {
    GObject parent_instance;


    gchar *name;
    GdkInputSource source;
    GdkInputMode mode;
    gboolean has_cursor;

    gint num_axes;
    GdkDeviceAxis *axes;

    gint num_keys;
    GdkDeviceKey *keys;
    }






    struct _GdkTimeCoord {
    guint32 time;
    gdouble axes[128];
    }

    GType gdk_device_get_type ();



    GList * gdk_devices_list ();



    void gdk_device_set_source (GdkDevice *device,
                        GdkInputSource source);

    gboolean gdk_device_set_mode (GdkDevice *device,
                        GdkInputMode mode);

    void gdk_device_set_key (GdkDevice *device,
                        guint index_,
                        guint keyval,
                        GdkModifierType modifiers);

    void gdk_device_set_axis_use (GdkDevice *device,
                    guint index_,
                    GdkAxisUse use);
    void gdk_device_get_state (GdkDevice *device,
                    GdkWindow *window,
                    gdouble *axes,
                    GdkModifierType *mask);
    gboolean gdk_device_get_history (GdkDevice *device,
                    GdkWindow *window,
                    guint32 start,
                    guint32 stop,
                    GdkTimeCoord ***events,
                    gint *n_events);
    void gdk_device_free_history (GdkTimeCoord **events,
                    gint n_events);
    gboolean gdk_device_get_axis (GdkDevice *device,
                    gdouble *axes,
                    GdkAxisUse use,
                    gdouble *value);

    void gdk_input_set_extension_events (GdkWindow *window,
                    gint mask,
                    GdkExtensionMode mode);


    GdkDevice *gdk_device_get_core_pointer ();
    alias _GdkEventAny GdkEventAny;

    alias _GdkEventExpose GdkEventExpose;

    alias _GdkEventNoExpose GdkEventNoExpose;

    alias _GdkEventVisibility GdkEventVisibility;

    alias _GdkEventMotion GdkEventMotion;

    alias _GdkEventButton GdkEventButton;

    alias _GdkEventScroll GdkEventScroll;

    alias _GdkEventKey GdkEventKey;

    alias _GdkEventFocus GdkEventFocus;

    alias _GdkEventCrossing GdkEventCrossing;

    alias _GdkEventConfigure GdkEventConfigure;

    alias _GdkEventProperty GdkEventProperty;

    alias _GdkEventSelection GdkEventSelection;

    alias _GdkEventProximity GdkEventProximity;

    alias _GdkEventClient GdkEventClient;

    alias _GdkEventDND GdkEventDND;

    alias _GdkEventWindowState GdkEventWindowState;

    alias _GdkEventSetting GdkEventSetting;


    alias _GdkEvent GdkEvent;


    alias void (*GdkEventFunc) (GdkEvent *event,
                gpointer data);



    alias void GdkXEvent;



    enum GdkFilterReturn {
    GDK_FILTER_CONTINUE,
    GDK_FILTER_TRANSLATE,


    GDK_FILTER_REMOVE
    };


    alias GdkFilterReturn (*GdkFilterFunc) (GdkXEvent *xevent,
                        GdkEvent *event,
                        gpointer data);
    enum GdkEventType {
    GDK_NOTHING = -1,
    GDK_DELETE = 0,
    GDK_DESTROY = 1,
    GDK_EXPOSE = 2,
    GDK_MOTION_NOTIFY = 3,
    GDK_BUTTON_PRESS = 4,
    GDK_2BUTTON_PRESS = 5,
    GDK_3BUTTON_PRESS = 6,
    GDK_BUTTON_RELEASE = 7,
    GDK_KEY_PRESS = 8,
    GDK_KEY_RELEASE = 9,
    GDK_ENTER_NOTIFY = 10,
    GDK_LEAVE_NOTIFY = 11,
    GDK_FOCUS_CHANGE = 12,
    GDK_CONFIGURE = 13,
    GDK_MAP = 14,
    GDK_UNMAP = 15,
    GDK_PROPERTY_NOTIFY = 16,
    GDK_SELECTION_CLEAR = 17,
    GDK_SELECTION_REQUEST = 18,
    GDK_SELECTION_NOTIFY = 19,
    GDK_PROXIMITY_IN = 20,
    GDK_PROXIMITY_OUT = 21,
    GDK_DRAG_ENTER = 22,
    GDK_DRAG_LEAVE = 23,
    GDK_DRAG_MOTION = 24,
    GDK_DRAG_STATUS = 25,
    GDK_DROP_START = 26,
    GDK_DROP_FINISHED = 27,
    GDK_CLIENT_EVENT = 28,
    GDK_VISIBILITY_NOTIFY = 29,
    GDK_NO_EXPOSE = 30,
    GDK_SCROLL = 31,
    GDK_WINDOW_STATE = 32,
    GDK_SETTING = 33
    };





    enum GdkEventMask {
    GDK_EXPOSURE_MASK = 1 << 1,
    GDK_POINTER_MOTION_MASK = 1 << 2,
    GDK_POINTER_MOTION_HINT_MASK = 1 << 3,
    GDK_BUTTON_MOTION_MASK = 1 << 4,
    GDK_BUTTON1_MOTION_MASK = 1 << 5,
    GDK_BUTTON2_MOTION_MASK = 1 << 6,
    GDK_BUTTON3_MOTION_MASK = 1 << 7,
    GDK_BUTTON_PRESS_MASK = 1 << 8,
    GDK_BUTTON_RELEASE_MASK = 1 << 9,
    GDK_KEY_PRESS_MASK = 1 << 10,
    GDK_KEY_RELEASE_MASK = 1 << 11,
    GDK_ENTER_NOTIFY_MASK = 1 << 12,
    GDK_LEAVE_NOTIFY_MASK = 1 << 13,
    GDK_FOCUS_CHANGE_MASK = 1 << 14,
    GDK_STRUCTURE_MASK = 1 << 15,
    GDK_PROPERTY_CHANGE_MASK = 1 << 16,
    GDK_VISIBILITY_NOTIFY_MASK = 1 << 17,
    GDK_PROXIMITY_IN_MASK = 1 << 18,
    GDK_PROXIMITY_OUT_MASK = 1 << 19,
    GDK_SUBSTRUCTURE_MASK = 1 << 20,
    GDK_SCROLL_MASK = 1 << 21,
    GDK_ALL_EVENTS_MASK = 0x3FFFFE
    };


    enum GdkVisibilityState {
    GDK_VISIBILITY_UNOBSCURED,
    GDK_VISIBILITY_PARTIAL,
    GDK_VISIBILITY_FULLY_OBSCURED
    };


    enum GdkScrollDirection {
    GDK_SCROLL_UP,
    GDK_SCROLL_DOWN,
    GDK_SCROLL_LEFT,
    GDK_SCROLL_RIGHT
    };

    enum GdkNotifyType {
    GDK_NOTIFY_ANCESTOR = 0,
    GDK_NOTIFY_VIRTUAL = 1,
    GDK_NOTIFY_INFERIOR = 2,
    GDK_NOTIFY_NONLINEAR = 3,
    GDK_NOTIFY_NONLINEAR_VIRTUAL = 4,
    GDK_NOTIFY_UNKNOWN = 5
    };







    enum GdkCrossingMode {
    GDK_CROSSING_NORMAL,
    GDK_CROSSING_GRAB,
    GDK_CROSSING_UNGRAB
    };


    enum GdkPropertyState {
    GDK_PROPERTY_NEW_VALUE,
    GDK_PROPERTY_DELETE
    };


    enum GdkWindowState {
    GDK_WINDOW_STATE_WITHDRAWN = 1 << 0,
    GDK_WINDOW_STATE_ICONIFIED = 1 << 1,
    GDK_WINDOW_STATE_MAXIMIZED = 1 << 2,
    GDK_WINDOW_STATE_STICKY = 1 << 3,
    GDK_WINDOW_STATE_FULLSCREEN = 1 << 4,
    GDK_WINDOW_STATE_ABOVE = 1 << 5,
    GDK_WINDOW_STATE_BELOW = 1 << 6
    };


    enum GdkSettingAction {
    GDK_SETTING_ACTION_NEW,
    GDK_SETTING_ACTION_CHANGED,
    GDK_SETTING_ACTION_DELETED
    };


    struct _GdkEventAny {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    }

    struct _GdkEventExpose {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkRectangle area;
    GdkRegion *region;
    gint count;
    }

    struct _GdkEventNoExpose {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    }

    struct _GdkEventVisibility {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkVisibilityState state;
    }

    struct _GdkEventMotion {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    guint32 time;
    gdouble x;
    gdouble y;
    gdouble *axes;
    guint state;
    gint16 is_hint;
    GdkDevice *device;
    gdouble x_root, y_root;
    }

    struct _GdkEventButton {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    guint32 time;
    gdouble x;
    gdouble y;
    gdouble *axes;
    guint state;
    guint button;
    GdkDevice *device;
    gdouble x_root, y_root;
    }

    struct _GdkEventScroll {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    guint32 time;
    gdouble x;
    gdouble y;
    guint state;
    GdkScrollDirection direction;
    GdkDevice *device;
    gdouble x_root, y_root;
    }

    struct _GdkEventKey {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    guint32 time;
    guint state;
    guint keyval;
    gint length;
    gchar *string;
    guint16 hardware_keycode;
    guint8 group;
    }

    struct _GdkEventCrossing {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkWindow *subwindow;
    guint32 time;
    gdouble x;
    gdouble y;
    gdouble x_root;
    gdouble y_root;
    GdkCrossingMode mode;
    GdkNotifyType detail;
    gboolean focus;
    guint state;
    }

    struct _GdkEventFocus {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    gint16 In;
    }

    struct _GdkEventConfigure {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    gint x, y;
    gint width;
    gint height;
    }

    struct _GdkEventProperty {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkAtom atom;
    guint32 time;
    guint state;
    }

    struct _GdkEventSelection {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkAtom selection;
    GdkAtom target;
    GdkAtom property;
    guint32 time;
    GdkNativeWindow requestor;
    }




    struct _GdkEventProximity {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    guint32 time;
    GdkDevice *device;
    }

    struct _GdkEventClient {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkAtom message_type;
    gushort data_format;
    union data_union  {
    char b[20];
    short s[10];
    int l[5];
    }
    data_union data;
    }

    struct _GdkEventSetting {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkSettingAction action;
    char *name;
    }

    struct _GdkEventWindowState {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkWindowState changed_mask;
    GdkWindowState new_window_state;
    }



    struct _GdkEventDND {
    GdkEventType type;
    GdkWindow *window;
    gint8 send_event;
    GdkDragContext *context;

    guint32 time;
    gshort x_root, y_root;
    }

    union _GdkEvent {
    GdkEventType type;
    GdkEventAny any;
    GdkEventExpose expose;
    GdkEventNoExpose no_expose;
    GdkEventVisibility visibility;
    GdkEventMotion motion;
    GdkEventButton button;
    GdkEventScroll scroll;
    GdkEventKey key;
    GdkEventCrossing crossing;
    GdkEventFocus focus_change;
    GdkEventConfigure configure;
    GdkEventProperty property;
    GdkEventSelection selection;
    GdkEventProximity proximity;
    GdkEventClient client;
    GdkEventDND dnd;
    GdkEventWindowState window_state;
    GdkEventSetting setting;
    }

    GType gdk_event_get_type ();

    gboolean gdk_events_pending ();
    GdkEvent* gdk_event_get ();

    GdkEvent* gdk_event_peek ();
    GdkEvent* gdk_event_get_graphics_expose (GdkWindow *window);
    void gdk_event_put (GdkEvent *event);

    GdkEvent* gdk_event_new (GdkEventType type);
    GdkEvent* gdk_event_copy (GdkEvent *event);
    void gdk_event_free (GdkEvent *event);

    guint32 gdk_event_get_time (GdkEvent *event);
    gboolean gdk_event_get_state (GdkEvent *event,
                        GdkModifierType *state);
    gboolean gdk_event_get_coords (GdkEvent *event,
                        gdouble *x_win,
                        gdouble *y_win);
    gboolean gdk_event_get_root_coords (GdkEvent *event,
                        gdouble *x_root,
                        gdouble *y_root);
    gboolean gdk_event_get_axis (GdkEvent *event,
                        GdkAxisUse axis_use,
                        gdouble *value);
    void gdk_event_handler_set (GdkEventFunc func,
                        gpointer data,
                        GDestroyNotify notify);

    void gdk_event_set_screen (GdkEvent *event,
                    GdkScreen *screen);
    GdkScreen *gdk_event_get_screen (GdkEvent *event);

    void gdk_set_show_events (gboolean show_events);
    gboolean gdk_get_show_events ();


    void gdk_add_client_message_filter (GdkAtom message_type,
                    GdkFilterFunc func,
                    gpointer data);

    gboolean gdk_setting_get ( gchar *name,
                GValue *value);




    alias _GdkDisplayClass GdkDisplayClass;

    alias _GdkDisplayPointerHooks GdkDisplayPointerHooks;

    struct _GdkDisplay {
    GObject parent_instance;


    GList *queued_events;
    GList *queued_tail;




    guint32 button_click_time[2];
    GdkWindow *button_window[2];
    gint button_number[2];

    guint double_click_time;
    GdkDevice *core_pointer;

    GdkDisplayPointerHooks *pointer_hooks;

    guint closed;

    guint double_click_distance;
    gint button_x[2];
    gint button_y[2];
    }

    struct _GdkDisplayClass {
    GObjectClass parent_class;

    gchar * (*get_display_name) (GdkDisplay *display);
    gint (*get_n_screens) (GdkDisplay *display);
    GdkScreen * (*get_screen) (GdkDisplay *display,
                            gint screen_num);
    GdkScreen * (*get_default_screen) (GdkDisplay *display);



    void (*closed) (GdkDisplay *display,
            gboolean is_error);
    }

    struct _GdkDisplayPointerHooks {
    void (*get_pointer) (GdkDisplay *display,
                    GdkScreen **screen,
                    gint *x,
                    gint *y,
                    GdkModifierType *mask);
    GdkWindow* (*window_get_pointer) (GdkDisplay *display,
                    GdkWindow *window,
                    gint *x,
                    gint *y,
                    GdkModifierType *mask);
    GdkWindow* (*window_at_pointer) (GdkDisplay *display,
                    gint *win_x,
                    gint *win_y);
    }

    GType gdk_display_get_type ();
    GdkDisplay *gdk_display_open ( gchar *display_name);

    gchar * gdk_display_get_name (GdkDisplay *display);

    gint gdk_display_get_n_screens (GdkDisplay *display);
    GdkScreen * gdk_display_get_screen (GdkDisplay *display,
                        gint screen_num);
    GdkScreen * gdk_display_get_default_screen (GdkDisplay *display);
    void gdk_display_pointer_ungrab (GdkDisplay *display,
                        guint32 time_);
    void gdk_display_keyboard_ungrab (GdkDisplay *display,
                        guint32 time_);
    gboolean gdk_display_pointer_is_grabbed (GdkDisplay *display);
    void gdk_display_beep (GdkDisplay *display);
    void gdk_display_sync (GdkDisplay *display);
    void gdk_display_flush (GdkDisplay *display);

    void gdk_display_close (GdkDisplay *display);

    GList * gdk_display_list_devices (GdkDisplay *display);

    GdkEvent* gdk_display_get_event (GdkDisplay *display);
    GdkEvent* gdk_display_peek_event (GdkDisplay *display);
    void gdk_display_put_event (GdkDisplay *display,
                    GdkEvent *event);

    void gdk_display_add_client_message_filter (GdkDisplay *display,
                        GdkAtom message_type,
                        GdkFilterFunc func,
                        gpointer data);

    void gdk_display_set_double_click_time (GdkDisplay *display,
                        guint msec);
    void gdk_display_set_double_click_distance (GdkDisplay *display,
                        guint distance);

    GdkDisplay *gdk_display_get_default ();

    GdkDevice *gdk_display_get_core_pointer (GdkDisplay *display);

    void gdk_display_get_pointer (GdkDisplay *display,
                            GdkScreen **screen,
                            gint *x,
                            gint *y,
                            GdkModifierType *mask);
    GdkWindow * gdk_display_get_window_at_pointer (GdkDisplay *display,
                            gint *win_x,
                            gint *win_y);

    GdkDisplayPointerHooks *gdk_display_set_pointer_hooks (GdkDisplay *display,
                                GdkDisplayPointerHooks *new_hooks);

    GdkDisplay *gdk_display_open_default_libgtk_only ();

    gboolean gdk_display_supports_cursor_alpha (GdkDisplay *display);
    gboolean gdk_display_supports_cursor_color (GdkDisplay *display);
    guint gdk_display_get_default_cursor_size (GdkDisplay *display);
    void gdk_display_get_maximal_cursor_size (GdkDisplay *display,
                            guint *width,
                            guint *height);

    GdkWindow *gdk_display_get_default_group (GdkDisplay *display);







    alias _GdkGCValues GdkGCValues;

    alias _GdkGCClass GdkGCClass;








    enum GdkCapStyle {
    GDK_CAP_NOT_LAST,
    GDK_CAP_BUTT,
    GDK_CAP_ROUND,
    GDK_CAP_PROJECTING
    };








    enum GdkFill {
    GDK_SOLID,
    GDK_TILED,
    GDK_STIPPLED,
    GDK_OPAQUE_STIPPLED
    };

    enum GdkFunction {
    GDK_COPY,
    GDK_INVERT,
    GDK_XOR,
    GDK_CLEAR,
    GDK_AND,
    GDK_AND_REVERSE,
    GDK_AND_INVERT,
    GDK_NOOP,
    GDK_OR,
    GDK_EQUIV,
    GDK_OR_REVERSE,
    GDK_COPY_INVERT,
    GDK_OR_INVERT,
    GDK_NAND,
    GDK_NOR,
    GDK_SET
    };







    enum GdkJoinStyle {
    GDK_JOIN_MITER,
    GDK_JOIN_ROUND,
    GDK_JOIN_BEVEL
    };







    enum GdkLineStyle {
    GDK_LINE_SOLID,
    GDK_LINE_ON_OFF_DASH,
    GDK_LINE_DOUBLE_DASH
    };


    enum GdkSubwindowMode {
    GDK_CLIP_BY_CHILDREN = 0,
    GDK_INCLUDE_INFERIORS = 1
    };


    enum GdkGCValuesMask {
    GDK_GC_FOREGROUND = 1 << 0,
    GDK_GC_BACKGROUND = 1 << 1,
    GDK_GC_FONT = 1 << 2,
    GDK_GC_FUNCTION = 1 << 3,
    GDK_GC_FILL = 1 << 4,
    GDK_GC_TILE = 1 << 5,
    GDK_GC_STIPPLE = 1 << 6,
    GDK_GC_CLIP_MASK = 1 << 7,
    GDK_GC_SUBWINDOW = 1 << 8,
    GDK_GC_TS_X_ORIGIN = 1 << 9,
    GDK_GC_TS_Y_ORIGIN = 1 << 10,
    GDK_GC_CLIP_X_ORIGIN = 1 << 11,
    GDK_GC_CLIP_Y_ORIGIN = 1 << 12,
    GDK_GC_EXPOSURES = 1 << 13,
    GDK_GC_LINE_WIDTH = 1 << 14,
    GDK_GC_LINE_STYLE = 1 << 15,
    GDK_GC_CAP_STYLE = 1 << 16,
    GDK_GC_JOIN_STYLE = 1 << 17
    };


    struct _GdkGCValues {
    GdkColor foreground;
    GdkColor background;
    GdkFont *font;
    GdkFunction Function;
    GdkFill fill;
    GdkPixmap *tile;
    GdkPixmap *stipple;
    GdkPixmap *clip_mask;
    GdkSubwindowMode subwindow_mode;
    gint ts_x_origin;
    gint ts_y_origin;
    gint clip_x_origin;
    gint clip_y_origin;
    gint graphics_exposures;
    gint line_width;
    GdkLineStyle line_style;
    GdkCapStyle cap_style;
    GdkJoinStyle join_style;
    }
    struct _GdkGC {
    GObject parent_instance;

    gint clip_x_origin;
    gint clip_y_origin;
    gint ts_x_origin;
    gint ts_y_origin;

    GdkColormap *colormap;
    }

    struct _GdkGCClass {
    GObjectClass parent_class;

    void (*get_values) (GdkGC *gc,
                GdkGCValues *values);
    void (*set_values) (GdkGC *gc,
                GdkGCValues *values,
                GdkGCValuesMask mask);
    void (*set_dashes) (GdkGC *gc,
                gint dash_offset,
                gint8* dash_list,
                gint n);


    void (*_gdk_reserved1) ();
    void (*_gdk_reserved2) ();
    void (*_gdk_reserved3) ();
    void (*_gdk_reserved4) ();
    }


    GType gdk_gc_get_type () ;
    GdkGC *gdk_gc_new (GdkDrawable *drawable);
    GdkGC *gdk_gc_new_with_values (GdkDrawable *drawable,
                    GdkGCValues *values,
                    GdkGCValuesMask values_mask);


    GdkGC *gdk_gc_ref (GdkGC *gc);
    void gdk_gc_unref (GdkGC *gc);


    void gdk_gc_get_values (GdkGC *gc,
                    GdkGCValues *values);
    void gdk_gc_set_values (GdkGC *gc,
                    GdkGCValues *values,
                    GdkGCValuesMask values_mask);
    void gdk_gc_set_foreground (GdkGC *gc,
                    GdkColor *color);
    void gdk_gc_set_background (GdkGC *gc,
                    GdkColor *color);

    void gdk_gc_set_font (GdkGC *gc,
                    GdkFont *font);

    void gdk_gc_set_function (GdkGC *gc,
                    GdkFunction Function);
    void gdk_gc_set_fill (GdkGC *gc,
                    GdkFill fill);
    void gdk_gc_set_tile (GdkGC *gc,
                    GdkPixmap *tile);
    void gdk_gc_set_stipple (GdkGC *gc,
                    GdkPixmap *stipple);
    void gdk_gc_set_ts_origin (GdkGC *gc,
                    gint x,
                    gint y);
    void gdk_gc_set_clip_origin (GdkGC *gc,
                    gint x,
                    gint y);
    void gdk_gc_set_clip_mask (GdkGC *gc,
                    GdkBitmap *mask);
    void gdk_gc_set_clip_rectangle (GdkGC *gc,
                    GdkRectangle *rectangle);
    void gdk_gc_set_clip_region (GdkGC *gc,
                    GdkRegion *region);
    void gdk_gc_set_subwindow (GdkGC *gc,
                    GdkSubwindowMode mode);
    void gdk_gc_set_exposures (GdkGC *gc,
                    gboolean exposures);
    void gdk_gc_set_line_attributes (GdkGC *gc,
                    gint line_width,
                    GdkLineStyle line_style,
                    GdkCapStyle cap_style,
                    GdkJoinStyle join_style);
    void gdk_gc_set_dashes (GdkGC *gc,
                    gint dash_offset,
                    gint8* dash_list,
                    gint n);
    void gdk_gc_offset (GdkGC *gc,
                    gint x_offset,
                    gint y_offset);
    void gdk_gc_copy (GdkGC *dst_gc,
                    GdkGC *src_gc);


    void gdk_gc_set_colormap (GdkGC *gc,
                    GdkColormap *colormap);
    GdkColormap *gdk_gc_get_colormap (GdkGC *gc);
    void gdk_gc_set_rgb_fg_color (GdkGC *gc,
                    GdkColor *color);
    void gdk_gc_set_rgb_bg_color (GdkGC *gc,
                    GdkColor *color);
    GdkScreen * gdk_gc_get_screen (GdkGC *gc);
    alias _GdkRgbCmap GdkRgbCmap;


    struct _GdkRgbCmap {
    guint32 colors[256];
    gint n_colors;


    GSList *info_list;
    }


    void gdk_rgb_init ();

    gulong gdk_rgb_xpixel_from_rgb (guint32 rgb) ;
    void gdk_rgb_gc_set_foreground (GdkGC *gc,
                    guint32 rgb);
    void gdk_rgb_gc_set_background (GdkGC *gc,
                    guint32 rgb);



    void gdk_rgb_find_color (GdkColormap *colormap,
                    GdkColor *color);

    enum GdkRgbDither {
    GDK_RGB_DITHER_NONE,
    GDK_RGB_DITHER_NORMAL,
    GDK_RGB_DITHER_MAX
    };


    void gdk_draw_rgb_image (GdkDrawable *drawable,
                        GdkGC *gc,
                        gint x,
                        gint y,
                        gint width,
                        gint height,
                        GdkRgbDither dith,
                        guchar *rgb_buf,
                        gint rowstride);
    void gdk_draw_rgb_image_dithalign (GdkDrawable *drawable,
                        GdkGC *gc,
                        gint x,
                        gint y,
                        gint width,
                        gint height,
                        GdkRgbDither dith,
                        guchar *rgb_buf,
                        gint rowstride,
                        gint xdith,
                        gint ydith);
    void gdk_draw_rgb_32_image (GdkDrawable *drawable,
                        GdkGC *gc,
                        gint x,
                        gint y,
                        gint width,
                        gint height,
                        GdkRgbDither dith,
                        guchar *buf,
                        gint rowstride);
    void gdk_draw_rgb_32_image_dithalign (GdkDrawable *drawable,
                        GdkGC *gc,
                        gint x,
                        gint y,
                        gint width,
                        gint height,
                        GdkRgbDither dith,
                        guchar *buf,
                        gint rowstride,
                        gint xdith,
                        gint ydith);
    void gdk_draw_gray_image (GdkDrawable *drawable,
                        GdkGC *gc,
                        gint x,
                        gint y,
                        gint width,
                        gint height,
                        GdkRgbDither dith,
                        guchar *buf,
                        gint rowstride);
    void gdk_draw_indexed_image (GdkDrawable *drawable,
                        GdkGC *gc,
                        gint x,
                        gint y,
                        gint width,
                        gint height,
                        GdkRgbDither dith,
                        guchar *buf,
                        gint rowstride,
                        GdkRgbCmap *cmap);
    GdkRgbCmap *gdk_rgb_cmap_new (guint32 *colors,
                        gint n_colors);
    void gdk_rgb_cmap_free (GdkRgbCmap *cmap);

    void gdk_rgb_set_verbose (gboolean verbose);


    void gdk_rgb_set_install (gboolean install);
    void gdk_rgb_set_min_colors (gint min_colors);


    GdkColormap *gdk_rgb_get_colormap ();
    GdkVisual * gdk_rgb_get_visual ();
    gboolean gdk_rgb_ditherable ();






    alias _GdkDrawableClass GdkDrawableClass;

    struct _GdkDrawable {
    GObject parent_instance;
    }

    struct _GdkDrawableClass {
    GObjectClass parent_class;

    GdkGC *(*create_gc) (GdkDrawable *drawable,
                GdkGCValues *values,
                GdkGCValuesMask mask);
    void (*draw_rectangle) (GdkDrawable *drawable,
                GdkGC *gc,
                gboolean filled,
                gint x,
                gint y,
                gint width,
                gint height);
    void (*draw_arc) (GdkDrawable *drawable,
                GdkGC *gc,
                gboolean filled,
                gint x,
                gint y,
                gint width,
                gint height,
                gint angle1,
                gint angle2);
    void (*draw_polygon) (GdkDrawable *drawable,
                GdkGC *gc,
                gboolean filled,
                GdkPoint *points,
                gint npoints);
    void (*draw_text) (GdkDrawable *drawable,
                GdkFont *font,
                GdkGC *gc,
                gint x,
                gint y,
                gchar *text,
                gint text_length);
    void (*draw_text_wc) (GdkDrawable *drawable,
                GdkFont *font,
                GdkGC *gc,
                gint x,
                gint y,
                GdkWChar *text,
                gint text_length);
    void (*draw_drawable) (GdkDrawable *drawable,
                GdkGC *gc,
                GdkDrawable *src,
                gint xsrc,
                gint ysrc,
                gint xdest,
                gint ydest,
                gint width,
                gint height);
    void (*draw_points) (GdkDrawable *drawable,
                GdkGC *gc,
                GdkPoint *points,
                gint npoints);
    void (*draw_segments) (GdkDrawable *drawable,
                GdkGC *gc,
                GdkSegment *segs,
                gint nsegs);
    void (*draw_lines) (GdkDrawable *drawable,
                GdkGC *gc,
                GdkPoint *points,
                gint npoints);

    void (*draw_glyphs) (GdkDrawable *drawable,
                GdkGC *gc,
                PangoFont *font,
                gint x,
                gint y,
                PangoGlyphString *glyphs);

    void (*draw_image) (GdkDrawable *drawable,
                GdkGC *gc,
                GdkImage *image,
                gint xsrc,
                gint ysrc,
                gint xdest,
                gint ydest,
                gint width,
                gint height);

    gint (*get_depth) (GdkDrawable *drawable);
    void (*get_size) (GdkDrawable *drawable,
                gint *width,
                gint *height);

    void (*set_colormap) (GdkDrawable *drawable,
                GdkColormap *cmap);

    GdkColormap* (*get_colormap) (GdkDrawable *drawable);
    GdkVisual* (*get_visual) (GdkDrawable *drawable);
    GdkScreen* (*get_screen) (GdkDrawable *drawable);

    GdkImage* (*get_image) (GdkDrawable *drawable,
                gint x,
                gint y,
                gint width,
                gint height);

    GdkRegion* (*get_clip_region) (GdkDrawable *drawable);
    GdkRegion* (*get_visible_region) (GdkDrawable *drawable);

    GdkDrawable* (*get_composite_drawable) (GdkDrawable *drawable,
                        gint x,
                        gint y,
                        gint width,
                        gint height,
                        gint *composite_x_offset,
                        gint *composite_y_offset);

    void (*draw_pixbuf) (GdkDrawable *drawable,
                GdkGC *gc,
                GdkPixbuf *pixbuf,
                gint src_x,
                gint src_y,
                gint dest_x,
                gint dest_y,
                gint width,
                gint height,
                GdkRgbDither dither,
                gint x_dither,
                gint y_dither);
    GdkImage* (*_copy_to_image) (GdkDrawable *drawable,
                    GdkImage *image,
                    gint src_x,
                    gint src_y,
                    gint dest_x,
                    gint dest_y,
                    gint width,
                    gint height);


    void (*_gdk_reserved1) ();
    void (*_gdk_reserved2) ();
    void (*_gdk_reserved3) ();
    void (*_gdk_reserved4) ();
    void (*_gdk_reserved5) ();
    void (*_gdk_reserved6) ();
    void (*_gdk_reserved7) ();
    void (*_gdk_reserved9) ();
    void (*_gdk_reserved10) ();
    void (*_gdk_reserved11) ();
    void (*_gdk_reserved12) ();
    void (*_gdk_reserved13) ();
    void (*_gdk_reserved14) ();
    void (*_gdk_reserved15) ();
    void (*_gdk_reserved16) ();
    }

    GType gdk_drawable_get_type ();





    void gdk_drawable_set_data (GdkDrawable *drawable,
                        gchar *key,
                        gpointer data,
                        GDestroyNotify destroy_func);
    gpointer gdk_drawable_get_data (GdkDrawable *drawable,
                        gchar *key);


    void gdk_drawable_get_size (GdkDrawable *drawable,
                        gint *width,
                        gint *height);
    void gdk_drawable_set_colormap (GdkDrawable *drawable,
                        GdkColormap *colormap);
    GdkColormap* gdk_drawable_get_colormap (GdkDrawable *drawable);
    GdkVisual* gdk_drawable_get_visual (GdkDrawable *drawable);
    gint gdk_drawable_get_depth (GdkDrawable *drawable);
    GdkScreen* gdk_drawable_get_screen (GdkDrawable *drawable);
    GdkDisplay* gdk_drawable_get_display (GdkDrawable *drawable);


    GdkDrawable* gdk_drawable_ref (GdkDrawable *drawable);
    void gdk_drawable_unref (GdkDrawable *drawable);




    void gdk_draw_point (GdkDrawable *drawable,
                GdkGC *gc,
                gint x,
                gint y);
    void gdk_draw_line (GdkDrawable *drawable,
                GdkGC *gc,
                gint x1_,
                gint y1_,
                gint x2_,
                gint y2_);
    void gdk_draw_rectangle (GdkDrawable *drawable,
                GdkGC *gc,
                gboolean filled,
                gint x,
                gint y,
                gint width,
                gint height);
    void gdk_draw_arc (GdkDrawable *drawable,
                GdkGC *gc,
                gboolean filled,
                gint x,
                gint y,
                gint width,
                gint height,
                gint angle1,
                gint angle2);
    void gdk_draw_polygon (GdkDrawable *drawable,
                GdkGC *gc,
                gboolean filled,
                GdkPoint *points,
                gint npoints);


    void gdk_draw_string (GdkDrawable *drawable,
                GdkFont *font,
                GdkGC *gc,
                gint x,
                gint y,
                gchar *string);



    void gdk_draw_text (GdkDrawable *drawable,
                GdkFont *font,
                GdkGC *gc,
                gint x,
                gint y,
                gchar *text,
                gint text_length);

    void gdk_draw_text_wc (GdkDrawable *drawable,
                GdkFont *font,
                GdkGC *gc,
                gint x,
                gint y,
                GdkWChar *text,
                gint text_length);

    void gdk_draw_drawable (GdkDrawable *drawable,
                GdkGC *gc,
                GdkDrawable *src,
                gint xsrc,
                gint ysrc,
                gint xdest,
                gint ydest,
                gint width,
                gint height);
    void gdk_draw_image (GdkDrawable *drawable,
                GdkGC *gc,
                GdkImage *image,
                gint xsrc,
                gint ysrc,
                gint xdest,
                gint ydest,
                gint width,
                gint height);
    void gdk_draw_points (GdkDrawable *drawable,
                GdkGC *gc,
                GdkPoint *points,
                gint npoints);
    void gdk_draw_segments (GdkDrawable *drawable,
                GdkGC *gc,
                GdkSegment *segs,
                gint nsegs);
    void gdk_draw_lines (GdkDrawable *drawable,
                GdkGC *gc,
                GdkPoint *points,
                gint npoints);
    void gdk_draw_pixbuf (GdkDrawable *drawable,
                GdkGC *gc,
                GdkPixbuf *pixbuf,
                gint src_x,
                gint src_y,
                gint dest_x,
                gint dest_y,
                gint width,
                gint height,
                GdkRgbDither dither,
                gint x_dither,
                gint y_dither);

    void gdk_draw_glyphs (GdkDrawable *drawable,
                GdkGC *gc,
                PangoFont *font,
                gint x,
                gint y,
                PangoGlyphString *glyphs);
    void gdk_draw_layout_line (GdkDrawable *drawable,
                GdkGC *gc,
                gint x,
                gint y,
                PangoLayoutLine *line);
    void gdk_draw_layout (GdkDrawable *drawable,
                GdkGC *gc,
                gint x,
                gint y,
                PangoLayout *layout);

    void gdk_draw_layout_line_with_colors (GdkDrawable *drawable,
                    GdkGC *gc,
                    gint x,
                    gint y,
                    PangoLayoutLine *line,
                        GdkColor *foreground,
                        GdkColor *background);
    void gdk_draw_layout_with_colors (GdkDrawable *drawable,
                    GdkGC *gc,
                    gint x,
                    gint y,
                    PangoLayout *layout,
                        GdkColor *foreground,
                        GdkColor *background);






    GdkImage* gdk_drawable_get_image (GdkDrawable *drawable,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    GdkImage *gdk_drawable_copy_to_image (GdkDrawable *drawable,
                    GdkImage *image,
                    gint src_x,
                    gint src_y,
                    gint dest_x,
                    gint dest_y,
                    gint width,
                    gint height);

    GdkRegion *gdk_drawable_get_clip_region (GdkDrawable *drawable);
    GdkRegion *gdk_drawable_get_visible_region (GdkDrawable *drawable);




    GType gdk_cursor_type_get_type ();




    GType gdk_drag_action_get_type ();


    GType gdk_drag_protocol_get_type ();




    GType gdk_filter_return_get_type ();


    GType gdk_event_type_get_type ();


    GType gdk_event_mask_get_type ();


    GType gdk_visibility_state_get_type ();


    GType gdk_scroll_direction_get_type ();


    GType gdk_notify_type_get_type ();


    GType gdk_crossing_mode_get_type ();


    GType gdk_property_state_get_type ();


    GType gdk_window_state_get_type ();


    GType gdk_setting_action_get_type ();




    GType gdk_font_type_get_type ();




    GType gdk_cap_style_get_type ();


    GType gdk_fill_get_type ();


    GType gdk_function_get_type ();


    GType gdk_join_style_get_type ();


    GType gdk_line_style_get_type ();


    GType gdk_subwindow_mode_get_type ();


    GType gdk_gc_values_mask_get_type ();




    GType gdk_image_type_get_type ();




    GType gdk_extension_mode_get_type ();


    GType gdk_input_source_get_type ();


    GType gdk_input_mode_get_type ();


    GType gdk_axis_use_get_type ();




    GType gdk_prop_mode_get_type ();




    GType gdk_fill_rule_get_type ();


    GType gdk_overlap_type_get_type ();




    GType gdk_rgb_dither_get_type ();




    GType gdk_byte_order_get_type ();


    GType gdk_modifier_type_get_type ();


    GType gdk_input_condition_get_type ();


    GType gdk_status_get_type ();


    GType gdk_grab_status_get_type ();




    GType gdk_visual_type_get_type ();




    GType gdk_window_class_get_type ();


    GType gdk_window_type_get_type ();


    GType gdk_window_attributes_type_get_type ();


    GType gdk_window_hints_get_type ();


    GType gdk_window_type_hint_get_type ();


    GType gdk_wm_decoration_get_type ();


    GType gdk_wm_function_get_type ();


    GType gdk_gravity_get_type ();


    GType gdk_window_edge_get_type ();




    enum GdkFontType {
    GDK_FONT_FONT,
    GDK_FONT_FONTSET
    };


    struct _GdkFont {
    GdkFontType type;
    gint ascent;
    gint descent;
    }

    GType gdk_font_get_type ();

    GdkFont* gdk_font_ref (GdkFont *font);
    void gdk_font_unref (GdkFont *font);
    gint gdk_font_id ( GdkFont *font);
    gboolean gdk_font_equal ( GdkFont *fonta,
                GdkFont *fontb);

    GdkFont *gdk_font_load_for_display (GdkDisplay *display,
                            gchar *font_name);
    GdkFont *gdk_fontset_load_for_display (GdkDisplay *display,
                            gchar *fontset_name);
    GdkFont *gdk_font_from_description_for_display (GdkDisplay *display,
                            PangoFontDescription *font_desc);




    GdkFont* gdk_font_load ( gchar *font_name);
    GdkFont* gdk_fontset_load ( gchar *fontset_name);
    GdkFont* gdk_font_from_description (PangoFontDescription *font_desc);


    gint gdk_string_width (GdkFont *font,
                gchar *string);
    gint gdk_text_width (GdkFont *font,
                gchar *text,
                gint text_length);
    gint gdk_text_width_wc (GdkFont *font,
                GdkWChar *text,
                gint text_length);
    gint gdk_char_width (GdkFont *font,
                gchar character);
    gint gdk_char_width_wc (GdkFont *font,
                GdkWChar character);
    gint gdk_string_measure (GdkFont *font,
                gchar *string);
    gint gdk_text_measure (GdkFont *font,
                gchar *text,
                gint text_length);
    gint gdk_char_measure (GdkFont *font,
                gchar character);
    gint gdk_string_height (GdkFont *font,
                gchar *string);
    gint gdk_text_height (GdkFont *font,
                gchar *text,
                gint text_length);
    gint gdk_char_height (GdkFont *font,
                gchar character);

    void gdk_text_extents (GdkFont *font,
                gchar *text,
                gint text_length,
                gint *lbearing,
                gint *rbearing,
                gint *width,
                gint *ascent,
                gint *descent);
    void gdk_text_extents_wc (GdkFont *font,
                GdkWChar *text,
                gint text_length,
                gint *lbearing,
                gint *rbearing,
                gint *width,
                gint *ascent,
                gint *descent);
    void gdk_string_extents (GdkFont *font,
                gchar *string,
                gint *lbearing,
                gint *rbearing,
                gint *width,
                gint *ascent,
                gint *descent);

    GdkDisplay * gdk_font_get_display (GdkFont *font);

    enum GdkImageType {
    GDK_IMAGE_NORMAL,
    GDK_IMAGE_SHARED,
    GDK_IMAGE_FASTEST
    };


    alias _GdkImageClass GdkImageClass;

    struct _GdkImage {
    GObject parent_instance;



    GdkImageType type;
    GdkVisual *visual;
    GdkByteOrder byte_order;
    gint width;
    gint height;
    guint16 depth;
    guint16 bpp;
    guint16 bpl;
    guint16 bits_per_pixel;
    gpointer mem;

    GdkColormap *colormap;

    gpointer windowing_data;
    }

    struct _GdkImageClass {
    GObjectClass parent_class;
    }

    GType gdk_image_get_type () ;

    GdkImage* gdk_image_new (GdkImageType type,
                    GdkVisual *visual,
                    gint width,
                    gint height);


    GdkImage* gdk_image_get (GdkDrawable *drawable,
                    gint x,
                    gint y,
                    gint width,
                    gint height);

    GdkImage * gdk_image_ref (GdkImage *image);
    void gdk_image_unref (GdkImage *image);


    void gdk_image_put_pixel (GdkImage *image,
                    gint x,
                    gint y,
                    guint32 pixel);
    guint32 gdk_image_get_pixel (GdkImage *image,
                    gint x,
                    gint y);

    void gdk_image_set_colormap (GdkImage *image,
                    GdkColormap *colormap);
    GdkColormap* gdk_image_get_colormap (GdkImage *image);

    alias _GdkKeymapKey GdkKeymapKey;



    struct _GdkKeymapKey {
    guint keycode;
    gint group;
    gint level;
    }
    alias _GdkKeymap GdkKeymap;

    alias _GdkKeymapClass GdkKeymapClass;

    struct _GdkKeymap {
    GObject parent_instance;
    GdkDisplay *display;
    }

    struct _GdkKeymapClass {
    GObjectClass parent_class;

    void (*direction_changed) (GdkKeymap *keymap);
    void (*keys_changed) (GdkKeymap *keymap);
    }

    GType gdk_keymap_get_type () ;


    GdkKeymap* gdk_keymap_get_default ();

    GdkKeymap* gdk_keymap_get_for_display (GdkDisplay *display);


    guint gdk_keymap_lookup_key (GdkKeymap *keymap,
                            GdkKeymapKey *key);
    gboolean gdk_keymap_translate_keyboard_state (GdkKeymap *keymap,
                            guint hardware_keycode,
                            GdkModifierType state,
                            gint group,
                            guint *keyval,
                            gint *effective_group,
                            gint *level,
                            GdkModifierType *consumed_modifiers);
    gboolean gdk_keymap_get_entries_for_keyval (GdkKeymap *keymap,
                            guint keyval,
                            GdkKeymapKey **keys,
                            gint *n_keys);
    gboolean gdk_keymap_get_entries_for_keycode (GdkKeymap *keymap,
                            guint hardware_keycode,
                            GdkKeymapKey **keys,
                            guint **keyvals,
                            gint *n_entries);
    PangoDirection gdk_keymap_get_direction (GdkKeymap *keymap);



    gchar* gdk_keyval_name (guint keyval) ;
    guint gdk_keyval_from_name ( gchar *keyval_name);
    void gdk_keyval_convert_case (guint symbol,
                    guint *lower,
                    guint *upper);
    guint gdk_keyval_to_upper (guint keyval) ;
    guint gdk_keyval_to_lower (guint keyval) ;
    gboolean gdk_keyval_is_upper (guint keyval) ;
    gboolean gdk_keyval_is_lower (guint keyval) ;

    guint32 gdk_keyval_to_unicode (guint keyval) ;
    guint gdk_unicode_to_keyval (guint32 wc) ;


    alias _GdkDisplayManager GdkDisplayManager;
    alias void _GdkDisplayManager;

    alias _GdkDisplayManagerClass GdkDisplayManagerClass;

    struct _GdkDisplayManagerClass {
    GObjectClass parent_class;

    void (*display_opened) (GdkDisplayManager *display_manager,
                GdkDisplay *display);
    }

    GType gdk_display_manager_get_type () ;

    GdkDisplayManager *gdk_display_manager_get ();
    GdkDisplay * gdk_display_manager_get_default_display (GdkDisplayManager *display_manager);
    void gdk_display_manager_set_default_display (GdkDisplayManager *display_manager,
                                GdkDisplay *display);
    GSList * gdk_display_manager_list_displays (GdkDisplayManager *display_manager);


    PangoContext *gdk_pango_context_get_for_screen (GdkScreen *screen);

    PangoContext *gdk_pango_context_get ();

    void gdk_pango_context_set_colormap (PangoContext *context,
                            GdkColormap *colormap);
    GdkRegion *gdk_pango_layout_line_get_clip_region (PangoLayoutLine *line,
                            gint x_origin,
                            gint y_origin,
                            gint *index_ranges,
                            gint n_ranges);
    GdkRegion *gdk_pango_layout_get_clip_region (PangoLayout *layout,
                            gint x_origin,
                            gint y_origin,
                            gint *index_ranges,
                            gint n_ranges);





    alias _GdkPangoAttrStipple GdkPangoAttrStipple;

    alias _GdkPangoAttrEmbossed GdkPangoAttrEmbossed;


    struct _GdkPangoAttrStipple {
    PangoAttribute attr;
    GdkBitmap *stipple;
    }

    struct _GdkPangoAttrEmbossed {
    PangoAttribute attr;
    gboolean embossed;
    }

    PangoAttribute *gdk_pango_attr_stipple_new (GdkBitmap *stipple);
    PangoAttribute *gdk_pango_attr_embossed_new (gboolean embossed);
    void gdk_pixbuf_render_threshold_alpha (GdkPixbuf *pixbuf,
                        GdkBitmap *bitmap,
                        int src_x,
                        int src_y,
                        int dest_x,
                        int dest_y,
                        int width,
                        int height,
                        int alpha_threshold);

    void gdk_pixbuf_render_to_drawable (GdkPixbuf *pixbuf,
                        GdkDrawable *drawable,
                        GdkGC *gc,
                        int src_x,
                        int src_y,
                        int dest_x,
                        int dest_y,
                        int width,
                        int height,
                        GdkRgbDither dither,
                        int x_dither,
                        int y_dither);
    void gdk_pixbuf_render_to_drawable_alpha (GdkPixbuf *pixbuf,
                        GdkDrawable *drawable,
                        int src_x,
                        int src_y,
                        int dest_x,
                        int dest_y,
                        int width,
                        int height,
                        GdkPixbufAlphaMode alpha_mode,
                        int alpha_threshold,
                        GdkRgbDither dither,
                        int x_dither,
                        int y_dither);

    void gdk_pixbuf_render_pixmap_and_mask_for_colormap (GdkPixbuf *pixbuf,
                            GdkColormap *colormap,
                            GdkPixmap **pixmap_return,
                            GdkBitmap **mask_return,
                            int alpha_threshold);

    void gdk_pixbuf_render_pixmap_and_mask (GdkPixbuf *pixbuf,
                            GdkPixmap **pixmap_return,
                            GdkBitmap **mask_return,
                            int alpha_threshold);




    GdkPixbuf *gdk_pixbuf_get_from_drawable (GdkPixbuf *dest,
                        GdkDrawable *src,
                        GdkColormap *cmap,
                        int src_x,
                        int src_y,
                        int dest_x,
                        int dest_y,
                        int width,
                        int height);

    GdkPixbuf *gdk_pixbuf_get_from_image (GdkPixbuf *dest,
                        GdkImage *src,
                        GdkColormap *cmap,
                        int src_x,
                        int src_y,
                        int dest_x,
                        int dest_y,
                        int width,
                        int height);
    alias _GdkPixmapObject GdkPixmapObject;

    alias _GdkPixmapObjectClass GdkPixmapObjectClass;

    struct _GdkPixmapObject {
    GdkDrawable parent_instance;

    GdkDrawable *impl;

    gint depth;
    }

    struct _GdkPixmapObjectClass {
    GdkDrawableClass parent_class;

    }

    GType gdk_pixmap_get_type () ;



    GdkPixmap* gdk_pixmap_new (GdkDrawable *drawable,
                        gint width,
                        gint height,
                        gint depth);
    GdkBitmap* gdk_bitmap_create_from_data (GdkDrawable *drawable,
                        gchar *data,
                        gint width,
                        gint height);
    GdkPixmap* gdk_pixmap_create_from_data (GdkDrawable *drawable,
                        gchar *data,
                        gint width,
                        gint height,
                        gint depth,
                        GdkColor *fg,
                        GdkColor *bg);

    GdkPixmap* gdk_pixmap_create_from_xpm (GdkDrawable *drawable,
                            GdkBitmap **mask,
                            GdkColor *transparent_color,
                            gchar *filename);
    GdkPixmap* gdk_pixmap_colormap_create_from_xpm (GdkDrawable *drawable,
                            GdkColormap *colormap,
                            GdkBitmap **mask,
                            GdkColor *transparent_color,
                            gchar *filename);
    GdkPixmap* gdk_pixmap_create_from_xpm_d (GdkDrawable *drawable,
                            GdkBitmap **mask,
                            GdkColor *transparent_color,
                            gchar **data);
    GdkPixmap* gdk_pixmap_colormap_create_from_xpm_d (GdkDrawable *drawable,
                            GdkColormap *colormap,
                            GdkBitmap **mask,
                            GdkColor *transparent_color,
                            gchar **data);




    GdkPixmap* gdk_pixmap_foreign_new (GdkNativeWindow anid);
    GdkPixmap* gdk_pixmap_lookup (GdkNativeWindow anid);


    GdkPixmap* gdk_pixmap_foreign_new_for_display (GdkDisplay *display,
                            GdkNativeWindow anid);
    GdkPixmap* gdk_pixmap_lookup_for_display (GdkDisplay *display,
                            GdkNativeWindow anid);
    enum GdkPropMode {
    GDK_PROP_MODE_REPLACE,
    GDK_PROP_MODE_PREPEND,
    GDK_PROP_MODE_APPEND
    };


    GdkAtom gdk_atom_intern ( gchar *atom_name,
                gboolean only_if_exists);
    gchar* gdk_atom_name (GdkAtom atom);

    gboolean gdk_property_get (GdkWindow *window,
                GdkAtom property,
                GdkAtom type,
                gulong offset,
                gulong length,
                gint pdelete,
                GdkAtom *actual_property_type,
                gint *actual_format,
                gint *actual_length,
                guchar **data);
    void gdk_property_change (GdkWindow *window,
                GdkAtom property,
                GdkAtom type,
                gint format,
                GdkPropMode mode,
                guchar *data,
                gint nelements);
    void gdk_property_delete (GdkWindow *window,
                GdkAtom property);

    gint gdk_text_property_to_text_list (GdkAtom encoding,
                    gint format,
                    guchar *text,
                    gint length,
                    gchar ***list);
    gint gdk_text_property_to_utf8_list (GdkAtom encoding,
                    gint format,
                    guchar *text,
                    gint length,
                    gchar ***list);
    gboolean gdk_utf8_to_compound_text ( gchar *str,
                    GdkAtom *encoding,
                    gint *format,
                    guchar **ctext,
                    gint *length);
    gint gdk_string_to_compound_text ( gchar *str,
                    GdkAtom *encoding,
                    gint *format,
                    guchar **ctext,
                    gint *length);


    gint gdk_text_property_to_text_list_for_display (GdkDisplay *display,
                            GdkAtom encoding,
                            gint format,
                            guchar *text,
                            gint length,
                            gchar ***list);
    gint gdk_text_property_to_utf8_list_for_display (GdkDisplay *display,
                            GdkAtom encoding,
                            gint format,
                            guchar *text,
                            gint length,
                            gchar ***list);

    gchar *gdk_utf8_to_string_target ( gchar *str);
    gint gdk_string_to_compound_text_for_display (GdkDisplay *display,
                            gchar *str,
                            GdkAtom *encoding,
                            gint *format,
                            guchar **ctext,
                            gint *length);
    gboolean gdk_utf8_to_compound_text_for_display (GdkDisplay *display,
                            gchar *str,
                            GdkAtom *encoding,
                            gint *format,
                            guchar **ctext,
                            gint *length);

    void gdk_free_text_list (gchar **list);
    void gdk_free_compound_text (guchar *ctext);
    enum GdkFillRule {
    GDK_EVEN_ODD_RULE,
    GDK_WINDING_RULE
    };







    enum GdkOverlapType {
    GDK_OVERLAP_RECTANGLE_IN,
    GDK_OVERLAP_RECTANGLE_OUT,
    GDK_OVERLAP_RECTANGLE_PART
    };


    alias void (*GdkSpanFunc) (GdkSpan *span,
                gpointer data);

    GdkRegion *gdk_region_new ();
    GdkRegion *gdk_region_polygon (GdkPoint *points,
                    gint npoints,
                    GdkFillRule fill_rule);
    GdkRegion *gdk_region_copy (GdkRegion *region);
    GdkRegion *gdk_region_rectangle (GdkRectangle *rectangle);
    void gdk_region_destroy (GdkRegion *region);

    void gdk_region_get_clipbox (GdkRegion *region,
                        GdkRectangle *rectangle);
    void gdk_region_get_rectangles (GdkRegion *region,
                        GdkRectangle **rectangles,
                        gint *n_rectangles);

    gboolean gdk_region_empty (GdkRegion *region);
    gboolean gdk_region_equal (GdkRegion *region1,
                    GdkRegion *region2);
    gboolean gdk_region_point_in (GdkRegion *region,
                    int x,
                    int y);
    GdkOverlapType gdk_region_rect_in (GdkRegion *region,
                    GdkRectangle *rect);

    void gdk_region_offset (GdkRegion *region,
                    gint dx,
                    gint dy);
    void gdk_region_shrink (GdkRegion *region,
                    gint dx,
                    gint dy);
    void gdk_region_union_with_rect (GdkRegion *region,
                    GdkRectangle *rect);
    void gdk_region_intersect (GdkRegion *source1,
                    GdkRegion *source2);
    void gdk_region_union (GdkRegion *source1,
                    GdkRegion *source2);
    void gdk_region_subtract (GdkRegion *source1,
                    GdkRegion *source2);
    void gdk_region_xor (GdkRegion *source1,
                    GdkRegion *source2);

    void gdk_region_spans_intersect_foreach (GdkRegion *region,
                        GdkSpan *spans,
                        int n_spans,
                        gboolean sorted,
                        GdkSpanFunc Function,
                        gpointer data);



    alias _GdkScreenClass GdkScreenClass;

    struct _GdkScreen {
    GObject parent_instance;

    guint closed;

    GdkGC *normal_gcs[32];
    GdkGC *exposure_gcs[32];
    }

    struct _GdkScreenClass {
    GObjectClass parent_class;

    void (*size_changed) (GdkScreen *screen);
    }

    GType gdk_screen_get_type ();
    GdkColormap *gdk_screen_get_default_colormap (GdkScreen *screen);
    void gdk_screen_set_default_colormap (GdkScreen *screen,
                        GdkColormap *colormap);
    GdkColormap* gdk_screen_get_system_colormap (GdkScreen *screen);
    GdkVisual* gdk_screen_get_system_visual (GdkScreen *screen);
    GdkColormap *gdk_screen_get_rgb_colormap (GdkScreen *screen);
    GdkVisual * gdk_screen_get_rgb_visual (GdkScreen *screen);

    GdkWindow * gdk_screen_get_root_window (GdkScreen *screen);
    GdkDisplay * gdk_screen_get_display (GdkScreen *screen);
    gint gdk_screen_get_number (GdkScreen *screen);
    gint gdk_screen_get_width (GdkScreen *screen);
    gint gdk_screen_get_height (GdkScreen *screen);
    gint gdk_screen_get_width_mm (GdkScreen *screen);
    gint gdk_screen_get_height_mm (GdkScreen *screen);

    GList * gdk_screen_list_visuals (GdkScreen *screen);
    GList * gdk_screen_get_toplevel_windows (GdkScreen *screen);
    gchar * gdk_screen_make_display_name (GdkScreen *screen);

    gint gdk_screen_get_n_monitors (GdkScreen *screen);
    void gdk_screen_get_monitor_geometry (GdkScreen *screen,
                            gint monitor_num,
                            GdkRectangle *dest);
    gint gdk_screen_get_monitor_at_point (GdkScreen *screen,
                            gint x,
                            gint y);
    gint gdk_screen_get_monitor_at_window (GdkScreen *screen,
                            GdkWindow *window);

    void gdk_screen_broadcast_client_message (GdkScreen *screen,
                            GdkEvent *event);

    GdkScreen *gdk_screen_get_default ();

    gboolean gdk_screen_get_setting (GdkScreen *screen,
                    gchar *name,
                    GValue *value);


    alias GdkAtom GdkSelection;
    alias GdkAtom GdkTarget;
    alias GdkAtom GdkSelectionType;







    gboolean gdk_selection_owner_set (GdkWindow *owner,
                    GdkAtom selection,
                    guint32 time_,
                    gboolean send_event);
    GdkWindow* gdk_selection_owner_get (GdkAtom selection);


    gboolean gdk_selection_owner_set_for_display (GdkDisplay *display,
                            GdkWindow *owner,
                            GdkAtom selection,
                            guint32 time_,
                            gboolean send_event);
    GdkWindow *gdk_selection_owner_get_for_display (GdkDisplay *display,
                            GdkAtom selection);

    void gdk_selection_convert (GdkWindow *requestor,
                    GdkAtom selection,
                    GdkAtom target,
                    guint32 time_);
    gboolean gdk_selection_property_get (GdkWindow *requestor,
                    guchar **data,
                    GdkAtom *prop_type,
                    gint *prop_format);


    void gdk_selection_send_notify (guint32 requestor,
                    GdkAtom selection,
                    GdkAtom target,
                    GdkAtom property,
                    guint32 time_);


    void gdk_selection_send_notify_for_display (GdkDisplay *display,
                            guint32 requestor,
                            GdkAtom selection,
                            GdkAtom target,
                            GdkAtom property,
                            guint32 time_);


    gboolean gdk_spawn_on_screen (GdkScreen *screen,
                        gchar *working_directory,
                        gchar **argv,
                        gchar **envp,
                        GSpawnFlags flags,
                        GSpawnChildSetupFunc child_setup,
                        gpointer user_data,
                        gint *child_pid,
                        GError **error);

    gboolean gdk_spawn_on_screen_with_pipes (GdkScreen *screen,
                        gchar *working_directory,
                        gchar **argv,
                        gchar **envp,
                        GSpawnFlags flags,
                        GSpawnChildSetupFunc child_setup,
                        gpointer user_data,
                        gint *child_pid,
                        gint *standard_input,
                        gint *standard_output,
                        gint *standard_error,
                        GError **error);

    gboolean gdk_spawn_command_line_on_screen (GdkScreen *screen,
                        gchar *command_line,
                        GError **error);









    alias _GdkVisualClass GdkVisualClass;
    alias void _GdkVisualClass;

    enum GdkVisualType {
    GDK_VISUAL_STATIC_GRAY,
    GDK_VISUAL_GRAYSCALE,
    GDK_VISUAL_STATIC_COLOR,
    GDK_VISUAL_PSEUDO_COLOR,
    GDK_VISUAL_TRUE_COLOR,
    GDK_VISUAL_DIRECT_COLOR
    };

    struct _GdkVisual {
    GObject parent_instance;

    GdkVisualType type;
    gint depth;
    GdkByteOrder byte_order;
    gint colormap_size;
    gint bits_per_rgb;

    guint32 red_mask;
    gint red_shift;
    gint red_prec;

    guint32 green_mask;
    gint green_shift;
    gint green_prec;

    guint32 blue_mask;
    gint blue_shift;
    gint blue_prec;
    }

    GType gdk_visual_get_type ();


    gint gdk_visual_get_best_depth ();
    GdkVisualType gdk_visual_get_best_type ();
    GdkVisual* gdk_visual_get_system ();
    GdkVisual* gdk_visual_get_best ();
    GdkVisual* gdk_visual_get_best_with_depth (gint depth);
    GdkVisual* gdk_visual_get_best_with_type (GdkVisualType visual_type);
    GdkVisual* gdk_visual_get_best_with_both (gint depth,
                        GdkVisualType visual_type);

    void gdk_query_depths (gint **depths,
                gint *count);
    void gdk_query_visual_types (GdkVisualType **visual_types,
                gint *count);

    GList* gdk_list_visuals ();


    GdkScreen *gdk_visual_get_screen (GdkVisual *visual);







    alias _GdkGeometry GdkGeometry;

    alias _GdkWindowAttr GdkWindowAttr;

    alias _GdkPointerHooks GdkPointerHooks;

    enum GdkWindowClass {
    GDK_INPUT_OUTPUT,
    GDK_INPUT_ONLY
    };

    enum GdkWindowType {
    GDK_WINDOW_ROOT,
    GDK_WINDOW_TOPLEVEL,
    GDK_WINDOW_CHILD,
    GDK_WINDOW_DIALOG,
    GDK_WINDOW_TEMP,
    GDK_WINDOW_FOREIGN
    };

    enum GdkWindowAttributesType {
    GDK_WA_TITLE = 1 << 1,
    GDK_WA_X = 1 << 2,
    GDK_WA_Y = 1 << 3,
    GDK_WA_CURSOR = 1 << 4,
    GDK_WA_COLORMAP = 1 << 5,
    GDK_WA_VISUAL = 1 << 6,
    GDK_WA_WMCLASS = 1 << 7,
    GDK_WA_NOREDIR = 1 << 8
    };




    enum GdkWindowHints {
    GDK_HINT_POS = 1 << 0,
    GDK_HINT_MIN_SIZE = 1 << 1,
    GDK_HINT_MAX_SIZE = 1 << 2,
    GDK_HINT_BASE_SIZE = 1 << 3,
    GDK_HINT_ASPECT = 1 << 4,
    GDK_HINT_RESIZE_INC = 1 << 5,
    GDK_HINT_WIN_GRAVITY = 1 << 6,
    GDK_HINT_USER_POS = 1 << 7,
    GDK_HINT_USER_SIZE = 1 << 8
    };

    enum GdkWindowTypeHint {
    GDK_WINDOW_TYPE_HINT_NORMAL,
    GDK_WINDOW_TYPE_HINT_DIALOG,
    GDK_WINDOW_TYPE_HINT_MENU,
    GDK_WINDOW_TYPE_HINT_TOOLBAR,
    GDK_WINDOW_TYPE_HINT_SPLASHSCREEN,
    GDK_WINDOW_TYPE_HINT_UTILITY,
    GDK_WINDOW_TYPE_HINT_DOCK,
    GDK_WINDOW_TYPE_HINT_DESKTOP
    };








    enum GdkWMDecoration {
    GDK_DECOR_ALL = 1 << 0,
    GDK_DECOR_BORDER = 1 << 1,
    GDK_DECOR_RESIZEH = 1 << 2,
    GDK_DECOR_TITLE = 1 << 3,
    GDK_DECOR_MENU = 1 << 4,
    GDK_DECOR_MINIMIZE = 1 << 5,
    GDK_DECOR_MAXIMIZE = 1 << 6
    };


    enum GdkWMFunction {
    GDK_FUNC_ALL = 1 << 0,
    GDK_FUNC_RESIZE = 1 << 1,
    GDK_FUNC_MOVE = 1 << 2,
    GDK_FUNC_MINIMIZE = 1 << 3,
    GDK_FUNC_MAXIMIZE = 1 << 4,
    GDK_FUNC_CLOSE = 1 << 5
    };






    enum GdkGravity {
    GDK_GRAVITY_NORTH_WEST = 1,
    GDK_GRAVITY_NORTH,
    GDK_GRAVITY_NORTH_EAST,
    GDK_GRAVITY_WEST,
    GDK_GRAVITY_CENTER,
    GDK_GRAVITY_EAST,
    GDK_GRAVITY_SOUTH_WEST,
    GDK_GRAVITY_SOUTH,
    GDK_GRAVITY_SOUTH_EAST,
    GDK_GRAVITY_STATIC
    };



    enum GdkWindowEdge {
    GDK_WINDOW_EDGE_NORTH_WEST,
    GDK_WINDOW_EDGE_NORTH,
    GDK_WINDOW_EDGE_NORTH_EAST,
    GDK_WINDOW_EDGE_WEST,
    GDK_WINDOW_EDGE_EAST,
    GDK_WINDOW_EDGE_SOUTH_WEST,
    GDK_WINDOW_EDGE_SOUTH,
    GDK_WINDOW_EDGE_SOUTH_EAST
    };


    struct _GdkWindowAttr {
    gchar *title;
    gint event_mask;
    gint x, y;
    gint width;
    gint height;
    GdkWindowClass wclass;
    GdkVisual *visual;
    GdkColormap *colormap;
    GdkWindowType window_type;
    GdkCursor *cursor;
    gchar *wmclass_name;
    gchar *wmclass_class;
    gboolean override_redirect;
    }

    struct _GdkGeometry {
    gint min_width;
    gint min_height;
    gint max_width;
    gint max_height;
    gint base_width;
    gint base_height;
    gint width_inc;
    gint height_inc;
    gdouble min_aspect;
    gdouble max_aspect;
    GdkGravity win_gravity;
    }

    struct _GdkPointerHooks {
    GdkWindow* (*get_pointer) (GdkWindow *window,
                    gint *x,
                    gint *y,
                    GdkModifierType *mask);
    GdkWindow* (*window_at_pointer) (GdkScreen *screen,
                    gint *win_x,
                    gint *win_y);
    }

    alias _GdkWindowObject GdkWindowObject;

    alias _GdkWindowObjectClass GdkWindowObjectClass;

    struct _GdkWindowObject {
    GdkDrawable parent_instance;

    GdkDrawable *impl;

    GdkWindowObject *parent;

    gpointer user_data;

    gint x;
    gint y;

    gint extension_events;

    GList *filters;
    GList *children;

    GdkColor bg_color;
    GdkPixmap *bg_pixmap;

    GSList *paint_stack;

    GdkRegion *update_area;
    guint update_freeze_count;

    guint8 window_type;
    guint8 depth;
    guint8 resize_count;

    GdkWindowState state;

    guint guffaw_gravity;
    guint input_only;
    guint modal_hint;

    guint destroyed;

    guint accept_focus;

    GdkEventMask event_mask;
    }

    struct _GdkWindowObjectClass {
    GdkDrawableClass parent_class;
    }



    GType gdk_window_object_get_type () ;
    GdkWindow* gdk_window_new (GdkWindow *parent,
                            GdkWindowAttr *attributes,
                            gint attributes_mask);
    void gdk_window_destroy (GdkWindow *window);
    GdkWindowType gdk_window_get_window_type (GdkWindow *window);
    GdkWindow* gdk_window_at_pointer (gint *win_x,
                            gint *win_y);
    void gdk_window_show (GdkWindow *window);
    void gdk_window_hide (GdkWindow *window);
    void gdk_window_withdraw (GdkWindow *window);
    void gdk_window_show_unraised (GdkWindow *window);
    void gdk_window_move (GdkWindow *window,
                            gint x,
                            gint y);
    void gdk_window_resize (GdkWindow *window,
                            gint width,
                            gint height);
    void gdk_window_move_resize (GdkWindow *window,
                            gint x,
                            gint y,
                            gint width,
                            gint height);
    void gdk_window_reparent (GdkWindow *window,
                            GdkWindow *new_parent,
                            gint x,
                            gint y);
    void gdk_window_clear (GdkWindow *window);
    void gdk_window_clear_area (GdkWindow *window,
                            gint x,
                            gint y,
                            gint width,
                            gint height);
    void gdk_window_clear_area_e (GdkWindow *window,
                            gint x,
                            gint y,
                            gint width,
                            gint height);
    void gdk_window_raise (GdkWindow *window);
    void gdk_window_lower (GdkWindow *window);
    void gdk_window_focus (GdkWindow *window,
                            guint32 timestamp);
    void gdk_window_set_user_data (GdkWindow *window,
                            gpointer user_data);
    void gdk_window_set_override_redirect (GdkWindow *window,
                            gboolean override_redirect);
    void gdk_window_set_accept_focus (GdkWindow *window,
                            gboolean accept_focus);
    void gdk_window_add_filter (GdkWindow *window,
                            GdkFilterFunc Function,
                            gpointer data);
    void gdk_window_remove_filter (GdkWindow *window,
                            GdkFilterFunc Function,
                            gpointer data);
    void gdk_window_scroll (GdkWindow *window,
                            gint dx,
                            gint dy);







    void gdk_window_shape_combine_mask (GdkWindow *window,
                    GdkBitmap *mask,
                    gint x,
                    gint y);
    void gdk_window_shape_combine_region (GdkWindow *window,
                    GdkRegion *shape_region,
                    gint offset_x,
                    gint offset_y);
    void gdk_window_set_child_shapes (GdkWindow *window);
    void gdk_window_merge_child_shapes (GdkWindow *window);







    gboolean gdk_window_is_visible (GdkWindow *window);
    gboolean gdk_window_is_viewable (GdkWindow *window);

    GdkWindowState gdk_window_get_state (GdkWindow *window);




    gboolean gdk_window_set_static_gravities (GdkWindow *window,
                        gboolean use_static);



    GdkWindow* gdk_window_foreign_new (GdkNativeWindow anid);
    GdkWindow* gdk_window_lookup (GdkNativeWindow anid);

    GdkWindow *gdk_window_foreign_new_for_display (GdkDisplay *display,
                            GdkNativeWindow anid);
    GdkWindow* gdk_window_lookup_for_display (GdkDisplay *display,
                        GdkNativeWindow anid);





    void gdk_window_set_hints (GdkWindow *window,
                        gint x,
                        gint y,
                        gint min_width,
                        gint min_height,
                        gint max_width,
                        gint max_height,
                        gint flags);

    void gdk_window_set_type_hint (GdkWindow *window,
                        GdkWindowTypeHint hint);
    void gdk_window_set_modal_hint (GdkWindow *window,
                        gboolean modal);

    void gdk_window_set_skip_taskbar_hint (GdkWindow *window,
                    gboolean skips_taskbar);
    void gdk_window_set_skip_pager_hint (GdkWindow *window,
                    gboolean skips_pager);

    void gdk_window_set_geometry_hints (GdkWindow *window,
                        GdkGeometry *geometry,
                        GdkWindowHints geom_mask);
    void gdk_set_sm_client_id ( gchar *sm_client_id);

    void gdk_window_begin_paint_rect (GdkWindow *window,
                        GdkRectangle *rectangle);
    void gdk_window_begin_paint_region (GdkWindow *window,
                        GdkRegion *region);
    void gdk_window_end_paint (GdkWindow *window);

    void gdk_window_set_title (GdkWindow *window,
                        gchar *title);
    void gdk_window_set_role (GdkWindow *window,
                        gchar *role);
    void gdk_window_set_transient_for (GdkWindow *window,
                        GdkWindow *parent);
    void gdk_window_set_background (GdkWindow *window,
                        GdkColor *color);
    void gdk_window_set_back_pixmap (GdkWindow *window,
                        GdkPixmap *pixmap,
                        gboolean parent_relative);
    void gdk_window_set_cursor (GdkWindow *window,
                        GdkCursor *cursor);
    void gdk_window_get_user_data (GdkWindow *window,
                        gpointer *data);
    void gdk_window_get_geometry (GdkWindow *window,
                        gint *x,
                        gint *y,
                        gint *width,
                        gint *height,
                        gint *depth);
    void gdk_window_get_position (GdkWindow *window,
                        gint *x,
                        gint *y);
    gint gdk_window_get_origin (GdkWindow *window,
                        gint *x,
                        gint *y);



    gboolean gdk_window_get_deskrelative_origin (GdkWindow *window,
                        gint *x,
                        gint *y);


    void gdk_window_get_root_origin (GdkWindow *window,
                        gint *x,
                        gint *y);
    void gdk_window_get_frame_extents (GdkWindow *window,
                        GdkRectangle *rect);
    GdkWindow* gdk_window_get_pointer (GdkWindow *window,
                        gint *x,
                        gint *y,
                        GdkModifierType *mask);
    GdkWindow * gdk_window_get_parent (GdkWindow *window);
    GdkWindow * gdk_window_get_toplevel (GdkWindow *window);

    GList * gdk_window_get_children (GdkWindow *window);
    GList * gdk_window_peek_children (GdkWindow *window);
    GdkEventMask gdk_window_get_events (GdkWindow *window);
    void gdk_window_set_events (GdkWindow *window,
                        GdkEventMask event_mask);

    void gdk_window_set_icon_list (GdkWindow *window,
                        GList *pixbufs);
    void gdk_window_set_icon (GdkWindow *window,
                        GdkWindow *icon_window,
                        GdkPixmap *pixmap,
                        GdkBitmap *mask);
    void gdk_window_set_icon_name (GdkWindow *window,
                        gchar *name);
    void gdk_window_set_group (GdkWindow *window,
                        GdkWindow *leader);
    GdkWindow* gdk_window_get_group (GdkWindow *window);
    void gdk_window_set_decorations (GdkWindow *window,
                        GdkWMDecoration decorations);
    gboolean gdk_window_get_decorations (GdkWindow *window,
                        GdkWMDecoration *decorations);
    void gdk_window_set_functions (GdkWindow *window,
                        GdkWMFunction functions);

    GList * gdk_window_get_toplevels ();


    void gdk_window_iconify (GdkWindow *window);
    void gdk_window_deiconify (GdkWindow *window);
    void gdk_window_stick (GdkWindow *window);
    void gdk_window_unstick (GdkWindow *window);
    void gdk_window_maximize (GdkWindow *window);
    void gdk_window_unmaximize (GdkWindow *window);
    void gdk_window_fullscreen (GdkWindow *window);
    void gdk_window_unfullscreen (GdkWindow *window);
    void gdk_window_set_keep_above (GdkWindow *window,
                        gboolean setting);
    void gdk_window_set_keep_below (GdkWindow *window,
                        gboolean setting);

    void gdk_window_register_dnd (GdkWindow *window);

    void gdk_window_begin_resize_drag (GdkWindow *window,
                    GdkWindowEdge edge,
                    gint button,
                    gint root_x,
                    gint root_y,
                    guint32 timestamp);
    void gdk_window_begin_move_drag (GdkWindow *window,
                    gint button,
                    gint root_x,
                    gint root_y,
                    guint32 timestamp);


    void gdk_window_invalidate_rect (GdkWindow *window,
                            GdkRectangle *rect,
                            gboolean invalidate_children);
    void gdk_window_invalidate_region (GdkWindow *window,
                            GdkRegion *region,
                            gboolean invalidate_children);
    void gdk_window_invalidate_maybe_recurse (GdkWindow *window,
                            GdkRegion *region,
                            gboolean (*child_func) (GdkWindow *, gpointer),
                            gpointer user_data);
    GdkRegion *gdk_window_get_update_area (GdkWindow *window);

    void gdk_window_freeze_updates (GdkWindow *window);
    void gdk_window_thaw_updates (GdkWindow *window);

    gint gdk_window_get_update_serial ();
    void gdk_window_process_all_updates ();
    void gdk_window_process_updates (GdkWindow *window,
                        gboolean update_children);


    void gdk_window_set_debug_updates (gboolean setting);

    void gdk_window_rain_size (GdkGeometry *geometry,
                        guint flags,
                        gint width,
                        gint height,
                        gint *new_width,
                        gint *new_height);

    void gdk_window_get_internal_paint_info (GdkWindow *window,
                        GdkDrawable **real_drawable,
                        gint *x_offset,
                        gint *y_offset);


    GdkPointerHooks *gdk_set_pointer_hooks ( GdkPointerHooks *new_hooks);


    GdkWindow *gdk_get_default_root_window ();
    void gdk_parse_args (gint *argc,
                        gchar ***argv);
    void gdk_init (gint *argc,
                        gchar ***argv);
    gboolean gdk_init_check (gint *argc,
                        gchar ***argv);


    void gdk_exit (gint error_code);

    gchar* gdk_set_locale ();

    char *gdk_get_program_class ();
    void gdk_set_program_class ( char *program_class);



    void gdk_error_trap_push ();
    gint gdk_error_trap_pop ();


    void gdk_set_use_xshm (gboolean use_xshm);
    gboolean gdk_get_use_xshm ();


    gchar* gdk_get_display ();
    gchar* gdk_get_display_arg_name ();



    gint gdk_input_add_full (gint source,
                GdkInputCondition condition,
                GdkInputFunction Function,
                gpointer data,
                GdkDestroyNotify destroy);


    gint gdk_input_add (gint source,
                GdkInputCondition condition,
                GdkInputFunction Function,
                gpointer data);
    void gdk_input_remove (gint tag);


    GdkGrabStatus gdk_pointer_grab (GdkWindow *window,
                    gboolean owner_events,
                    GdkEventMask event_mask,
                    GdkWindow *confine_to,
                    GdkCursor *cursor,
                    guint32 time_);
    GdkGrabStatus gdk_keyboard_grab (GdkWindow *window,
                    gboolean owner_events,
                    guint32 time_);


    void gdk_pointer_ungrab (guint32 time_);
    void gdk_keyboard_ungrab (guint32 time_);
    gboolean gdk_pointer_is_grabbed ();

    gint gdk_screen_width () ;
    gint gdk_screen_height () ;

    gint gdk_screen_width_mm () ;
    gint gdk_screen_height_mm () ;

    void gdk_beep ();


    void gdk_flush ();


    void gdk_set_double_click_time (guint msec);




    gboolean gdk_rectangle_intersect (GdkRectangle *src1,
                    GdkRectangle *src2,
                    GdkRectangle *dest);
    void gdk_rectangle_union (GdkRectangle *src1,
                    GdkRectangle *src2,
                    GdkRectangle *dest);

    GType gdk_rectangle_get_type ();






    gchar *gdk_wcstombs ( GdkWChar *src);
    gint gdk_mbstowcs (GdkWChar *dest,
                    gchar *src,
                    gint dest_max);




    gboolean gdk_event_send_client_message (GdkEvent *event,
                        GdkNativeWindow winid);
    void gdk_event_send_clientmessage_toall (GdkEvent *event);

    gboolean gdk_event_send_client_message_for_display (GdkDisplay *display,
                            GdkEvent *event,
                            GdkNativeWindow winid);

    void gdk_notify_startup_complete ();





    GMutex *gdk_threads_mutex;


    GCallback gdk_threads_lock;
    GCallback gdk_threads_unlock;

    void gdk_threads_enter ();
    void gdk_threads_leave ();
    void gdk_threads_init ();
    void gdk_threads_set_lock_functions (GCallback enter_fn,
                        GCallback leave_fn);
    enum GtkAnchorType {
    GTK_ANCHOR_CENTER,
    GTK_ANCHOR_NORTH,
    GTK_ANCHOR_NORTH_WEST,
    GTK_ANCHOR_NORTH_EAST,
    GTK_ANCHOR_SOUTH,
    GTK_ANCHOR_SOUTH_WEST,
    GTK_ANCHOR_SOUTH_EAST,
    GTK_ANCHOR_WEST,
    GTK_ANCHOR_EAST,
    GTK_ANCHOR_N = GTK_ANCHOR_NORTH,
    GTK_ANCHOR_NW = GTK_ANCHOR_NORTH_WEST,
    GTK_ANCHOR_NE = GTK_ANCHOR_NORTH_EAST,
    GTK_ANCHOR_S = GTK_ANCHOR_SOUTH,
    GTK_ANCHOR_SW = GTK_ANCHOR_SOUTH_WEST,
    GTK_ANCHOR_SE = GTK_ANCHOR_SOUTH_EAST,
    GTK_ANCHOR_W = GTK_ANCHOR_WEST,
    GTK_ANCHOR_E = GTK_ANCHOR_EAST
    };



    enum GtkArrowType {
    GTK_ARROW_UP,
    GTK_ARROW_DOWN,
    GTK_ARROW_LEFT,
    GTK_ARROW_RIGHT
    };



    enum GtkAttachOptions {
    GTK_EXPAND = 1 << 0,
    GTK_SHRINK = 1 << 1,
    GTK_FILL = 1 << 2
    };



    enum GtkButtonBoxStyle {
    GTK_BUTTONBOX_DEFAULT_STYLE,
    GTK_BUTTONBOX_SPREAD,
    GTK_BUTTONBOX_EDGE,
    GTK_BUTTONBOX_START,
    GTK_BUTTONBOX_END
    };



    enum GtkCurveType {
    GTK_CURVE_TYPE_LINEAR,
    GTK_CURVE_TYPE_SPLINE,
    GTK_CURVE_TYPE_FREE
    };


    enum GtkDeleteType {
    GTK_DELETE_CHARS,
    GTK_DELETE_WORD_ENDS,


    GTK_DELETE_WORDS,
    GTK_DELETE_DISPLAY_LINES,
    GTK_DELETE_DISPLAY_LINE_ENDS,
    GTK_DELETE_PARAGRAPH_ENDS,
    GTK_DELETE_PARAGRAPHS,
    GTK_DELETE_WHITESPACE
    };



    enum GtkDirectionType {
    GTK_DIR_TAB_FORWARD,
    GTK_DIR_TAB_BACKWARD,
    GTK_DIR_UP,
    GTK_DIR_DOWN,
    GTK_DIR_LEFT,
    GTK_DIR_RIGHT
    };



    enum GtkExpanderStyle {
    GTK_EXPANDER_COLLAPSED,
    GTK_EXPANDER_SEMI_COLLAPSED,
    GTK_EXPANDER_SEMI_EXPANDED,
    GTK_EXPANDER_EXPANDED
    };



    enum GtkIconSize {
    GTK_ICON_SIZE_INVALID,
    GTK_ICON_SIZE_MENU,
    GTK_ICON_SIZE_SMALL_TOOLBAR,
    GTK_ICON_SIZE_LARGE_TOOLBAR,
    GTK_ICON_SIZE_BUTTON,
    GTK_ICON_SIZE_DND,
    GTK_ICON_SIZE_DIALOG
    };




    enum GtkSideType {
    GTK_SIDE_TOP,
    GTK_SIDE_BOTTOM,
    GTK_SIDE_LEFT,
    GTK_SIDE_RIGHT
    };




    enum GtkTextDirection {
    GTK_TEXT_DIR_NONE,
    GTK_TEXT_DIR_LTR,
    GTK_TEXT_DIR_RTL
    };



    enum GtkJustification {
    GTK_JUSTIFY_LEFT,
    GTK_JUSTIFY_RIGHT,
    GTK_JUSTIFY_CENTER,
    GTK_JUSTIFY_FILL
    };




    enum GtkMatchType {
    GTK_MATCH_ALL,
    GTK_MATCH_ALL_TAIL,
    GTK_MATCH_HEAD,
    GTK_MATCH_TAIL,
    GTK_MATCH_EXACT,
    GTK_MATCH_LAST
    };




    enum GtkMenuDirectionType {
    GTK_MENU_DIR_PARENT,
    GTK_MENU_DIR_CHILD,
    GTK_MENU_DIR_NEXT,
    GTK_MENU_DIR_PREV
    };


    enum GtkMetricType {
    GTK_PIXELS,
    GTK_INCHES,
    GTK_CENTIMETERS
    };


    enum GtkMovementStep {
    GTK_MOVEMENT_LOGICAL_POSITIONS,
    GTK_MOVEMENT_VISUAL_POSITIONS,
    GTK_MOVEMENT_WORDS,
    GTK_MOVEMENT_DISPLAY_LINES,
    GTK_MOVEMENT_DISPLAY_LINE_ENDS,
    GTK_MOVEMENT_PARAGRAPHS,
    GTK_MOVEMENT_PARAGRAPH_ENDS,
    GTK_MOVEMENT_PAGES,
    GTK_MOVEMENT_BUFFER_ENDS,
    GTK_MOVEMENT_HORIZONTAL_PAGES
    };


    enum GtkScrollStep {
    GTK_SCROLL_STEPS,
    GTK_SCROLL_PAGES,
    GTK_SCROLL_ENDS,
    GTK_SCROLL_HORIZONTAL_STEPS,
    GTK_SCROLL_HORIZONTAL_PAGES,
    GTK_SCROLL_HORIZONTAL_ENDS
    };



    enum GtkOrientation {
    GTK_ORIENTATION_HORIZONTAL,
    GTK_ORIENTATION_VERTICAL
    };



    enum GtkCornerType {
    GTK_CORNER_TOP_LEFT,
    GTK_CORNER_BOTTOM_LEFT,
    GTK_CORNER_TOP_RIGHT,
    GTK_CORNER_BOTTOM_RIGHT
    };



    enum GtkPackType {
    GTK_PACK_START,
    GTK_PACK_END
    };



    enum GtkPathPriorityType {
    GTK_PATH_PRIO_LOWEST = 0,
    GTK_PATH_PRIO_GTK = 4,
    GTK_PATH_PRIO_APPLICATION = 8,
    GTK_PATH_PRIO_THEME = 10,
    GTK_PATH_PRIO_RC = 12,
    GTK_PATH_PRIO_HIGHEST = 15
    };




    enum GtkPathType {
    GTK_PATH_WIDGET,
    GTK_PATH_WIDGET_CLASS,
    GTK_PATH_CLASS
    };



    enum GtkPolicyType {
    GTK_POLICY_ALWAYS,
    GTK_POLICY_AUTOMATIC,
    GTK_POLICY_NEVER
    };


    enum GtkPositionType {
    GTK_POS_LEFT,
    GTK_POS_RIGHT,
    GTK_POS_TOP,
    GTK_POS_BOTTOM
    };



    enum GtkPreviewType {
    GTK_PREVIEW_COLOR,
    GTK_PREVIEW_GRAYSCALE
    };




    enum GtkReliefStyle {
    GTK_RELIEF_NORMAL,
    GTK_RELIEF_HALF,
    GTK_RELIEF_NONE
    };



    enum GtkResizeMode {
    GTK_RESIZE_PARENT,
    GTK_RESIZE_QUEUE,
    GTK_RESIZE_IMMEDIATE
    };




    enum GtkSignalRunType {
    GTK_RUN_FIRST = GSignalFlags.G_SIGNAL_RUN_FIRST,
    GTK_RUN_LAST = GSignalFlags.G_SIGNAL_RUN_LAST,
    GTK_RUN_BOTH = (GTK_RUN_FIRST | GTK_RUN_LAST),
    GTK_RUN_NO_RECURSE = GSignalFlags.G_SIGNAL_NO_RECURSE,
    GTK_RUN_ACTION = GSignalFlags.G_SIGNAL_ACTION,
    GTK_RUN_NO_HOOKS = GSignalFlags.G_SIGNAL_NO_HOOKS
    };




    enum GtkScrollType {
    GTK_SCROLL_NONE,
    GTK_SCROLL_JUMP,
    GTK_SCROLL_STEP_BACKWARD,
    GTK_SCROLL_STEP_FORWARD,
    GTK_SCROLL_PAGE_BACKWARD,
    GTK_SCROLL_PAGE_FORWARD,
    GTK_SCROLL_STEP_UP,
    GTK_SCROLL_STEP_DOWN,
    GTK_SCROLL_PAGE_UP,
    GTK_SCROLL_PAGE_DOWN,
    GTK_SCROLL_STEP_LEFT,
    GTK_SCROLL_STEP_RIGHT,
    GTK_SCROLL_PAGE_LEFT,
    GTK_SCROLL_PAGE_RIGHT,
    GTK_SCROLL_START,
    GTK_SCROLL_END
    };



    enum GtkSelectionMode {
    GTK_SELECTION_NONE,
    GTK_SELECTION_SINGLE,
    GTK_SELECTION_BROWSE,
    GTK_SELECTION_MULTIPLE,
    GTK_SELECTION_EXTENDED = GTK_SELECTION_MULTIPLE
    };



    enum GtkShadowType {
    GTK_SHADOW_NONE,
    GTK_SHADOW_IN,
    GTK_SHADOW_OUT,
    GTK_SHADOW_ETCHED_IN,
    GTK_SHADOW_ETCHED_OUT
    };



    enum GtkStateType {
    GTK_STATE_NORMAL,
    GTK_STATE_ACTIVE,
    GTK_STATE_PRELIGHT,
    GTK_STATE_SELECTED,
    GTK_STATE_INSENSITIVE
    };




    enum GtkSubmenuDirection {
    GTK_DIRECTION_LEFT,
    GTK_DIRECTION_RIGHT
    };



    enum GtkSubmenuPlacement {
    GTK_TOP_BOTTOM,
    GTK_LEFT_RIGHT
    };




    enum GtkToolbarStyle {
    GTK_TOOLBAR_ICONS,
    GTK_TOOLBAR_TEXT,
    GTK_TOOLBAR_BOTH,
    GTK_TOOLBAR_BOTH_HORIZ
    };



    enum GtkUpdateType {
    GTK_UPDATE_CONTINUOUS,
    GTK_UPDATE_DISCONTINUOUS,
    GTK_UPDATE_DELAYED
    };



    enum GtkVisibility {
    GTK_VISIBILITY_NONE,
    GTK_VISIBILITY_PARTIAL,
    GTK_VISIBILITY_FULL
    };



    enum GtkWindowPosition {
    GTK_WIN_POS_NONE,
    GTK_WIN_POS_CENTER,
    GTK_WIN_POS_MOUSE,
    GTK_WIN_POS_CENTER_ALWAYS,
    GTK_WIN_POS_CENTER_ON_PARENT
    };



    enum GtkWindowType {
    GTK_WINDOW_TOPLEVEL,
    GTK_WINDOW_POPUP
    };



    enum GtkWrapMode {
    GTK_WRAP_NONE,
    GTK_WRAP_CHAR,
    GTK_WRAP_WORD,
    GTK_WRAP_WORD_CHAR
    };



    enum GtkSortType {
    GTK_SORT_ASCENDING,
    GTK_SORT_DESCENDING
    };



    enum GtkIMPreeditStyle {
    GTK_IM_PREEDIT_NOTHING,
    GTK_IM_PREEDIT_CALLBACK,
    GTK_IM_PREEDIT_NONE
    };


    enum GtkIMStatusStyle {
    GTK_IM_STATUS_NOTHING,
    GTK_IM_STATUS_CALLBACK,
    GTK_IM_STATUS_NONE
    };



    enum GtkAccelFlags {
    GTK_ACCEL_VISIBLE = 1 << 0,
    GTK_ACCEL_LOCKED = 1 << 1,
    GTK_ACCEL_MASK = 0x07
    };




    alias _GtkAccelGroup GtkAccelGroup;

    alias _GtkAccelGroupClass GtkAccelGroupClass;

    alias _GtkAccelKey GtkAccelKey;

    alias _GtkAccelGroupEntry GtkAccelGroupEntry;

    alias gboolean (*GtkAccelGroupActivate) (GtkAccelGroup *accel_group,
                        GObject *acceleratable,
                        guint keyval,
                        GdkModifierType modifier);

    alias gboolean (*GtkAccelGroupFindFunc) (GtkAccelKey *key,
                        GClosure *closure,
                        gpointer data);

    struct _GtkAccelGroup {
    GObject parent;
    guint lock_count;
    GdkModifierType modifier_mask;
    GSList *acceleratables;
    guint n_accels;
    GtkAccelGroupEntry *priv_accels;
    }

    struct _GtkAccelGroupClass {
    GObjectClass parent_class;

    void (*accel_changed) (GtkAccelGroup *accel_group,
                    guint keyval,
                    GdkModifierType modifier,
                    GClosure *accel_closure);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    struct _GtkAccelKey {
    guint accel_key;
    GdkModifierType accel_mods;
    guint accel_flags;
    }



    GType gtk_accel_group_get_type ();
    GtkAccelGroup* gtk_accel_group_new ();
    void gtk_accel_group_lock (GtkAccelGroup *accel_group);
    void gtk_accel_group_unlock (GtkAccelGroup *accel_group);
    void gtk_accel_group_connect (GtkAccelGroup *accel_group,
                            guint accel_key,
                            GdkModifierType accel_mods,
                            GtkAccelFlags accel_flags,
                            GClosure *closure);
    void gtk_accel_group_connect_by_path (GtkAccelGroup *accel_group,
                            gchar *accel_path,
                            GClosure *closure);
    gboolean gtk_accel_group_disconnect (GtkAccelGroup *accel_group,
                            GClosure *closure);
    gboolean gtk_accel_group_disconnect_key (GtkAccelGroup *accel_group,
                            guint accel_key,
                            GdkModifierType accel_mods);
    gboolean gtk_accel_group_activate (GtkAccelGroup *accel_group,
                            GQuark accel_quark,
                            GObject *acceleratable,
                            guint accel_key,
                            GdkModifierType accel_mods);



    void _gtk_accel_group_attach (GtkAccelGroup *accel_group,
                            GObject *object);
    void _gtk_accel_group_detach (GtkAccelGroup *accel_group,
                            GObject *object);
    gboolean gtk_accel_groups_activate (GObject *object,
                            guint accel_key,
                            GdkModifierType accel_mods);
    GSList* gtk_accel_groups_from_object (GObject *object);
    GtkAccelKey* gtk_accel_group_find (GtkAccelGroup *accel_group,
                            GtkAccelGroupFindFunc find_func,
                            gpointer data);
    GtkAccelGroup* gtk_accel_group_from_accel_closure (GClosure *closure);



    gboolean gtk_accelerator_valid (guint keyval,
                        GdkModifierType modifiers) ;
    void gtk_accelerator_parse ( gchar *accelerator,
                        guint *accelerator_key,
                        GdkModifierType *accelerator_mods);
    gchar* gtk_accelerator_name (guint accelerator_key,
                        GdkModifierType accelerator_mods);
    void gtk_accelerator_set_default_mod_mask (GdkModifierType default_mod_mask);
    guint gtk_accelerator_get_default_mod_mask ();



    GtkAccelGroupEntry* gtk_accel_group_query (GtkAccelGroup *accel_group,
                            guint accel_key,
                            GdkModifierType accel_mods,
                            guint *n_entries);

    void _gtk_accel_group_reconnect (GtkAccelGroup *accel_group,
                            GQuark accel_path_quark);

    struct _GtkAccelGroupEntry {
    GtkAccelKey key;
    GClosure *closure;
    GQuark accel_path_quark;
    }









    alias GType GtkFundamentalType;
    alias GType GtkType;



    alias GTypeInstance GtkTypeObject;
    alias GTypeClass GtkTypeClass;
    alias GBaseInitFunc GtkClassInitFunc;
    alias GInstanceInitFunc GtkObjectInitFunc;











    GType gtk_accel_flags_get_type ();




    GType gtk_calendar_display_options_get_type ();




    GType gtk_cell_renderer_state_get_type ();


    GType gtk_cell_renderer_mode_get_type ();




    GType gtk_cell_type_get_type ();


    GType gtk_clist_drag_pos_get_type ();


    GType gtk_button_action_get_type ();




    GType gtk_ctree_pos_get_type ();


    GType gtk_ctree_line_style_get_type ();


    GType gtk_ctree_expander_style_get_type ();


    GType gtk_ctree_expansion_type_get_type ();




    GType gtk_debug_flag_get_type ();




    GType gtk_dialog_flags_get_type ();


    GType gtk_response_type_get_type ();




    GType gtk_dest_defaults_get_type ();


    GType gtk_target_flags_get_type ();




    GType gtk_anchor_type_get_type ();


    GType gtk_arrow_type_get_type ();


    GType gtk_attach_options_get_type ();


    GType gtk_button_box_style_get_type ();


    GType gtk_curve_type_get_type ();


    GType gtk_delete_type_get_type ();


    GType gtk_direction_type_get_type ();


    GType gtk_expander_style_get_type ();


    GType gtk_icon_size_get_type ();


    GType gtk_side_type_get_type ();


    GType gtk_text_direction_get_type ();


    GType gtk_justification_get_type ();


    GType gtk_match_type_get_type ();


    GType gtk_menu_direction_type_get_type ();


    GType gtk_metric_type_get_type ();


    GType gtk_movement_step_get_type ();


    GType gtk_scroll_step_get_type ();


    GType gtk_orientation_get_type ();


    GType gtk_corner_type_get_type ();


    GType gtk_pack_type_get_type ();


    GType gtk_path_priority_type_get_type ();


    GType gtk_path_type_get_type ();


    GType gtk_policy_type_get_type ();


    GType gtk_position_type_get_type ();


    GType gtk_preview_type_get_type ();


    GType gtk_relief_style_get_type ();


    GType gtk_resize_mode_get_type ();


    GType gtk_signal_run_type_get_type ();


    GType gtk_scroll_type_get_type ();


    GType gtk_selection_mode_get_type ();


    GType gtk_shadow_type_get_type ();


    GType gtk_state_type_get_type ();


    GType gtk_submenu_direction_get_type ();


    GType gtk_submenu_placement_get_type ();


    GType gtk_toolbar_style_get_type ();


    GType gtk_update_type_get_type ();


    GType gtk_visibility_get_type ();


    GType gtk_window_position_get_type ();


    GType gtk_window_type_get_type ();


    GType gtk_wrap_mode_get_type ();


    GType gtk_sort_type_get_type ();


    GType gtk_im_preedit_style_get_type ();


    GType gtk_im_status_style_get_type ();




    GType gtk_file_chooser_action_get_type ();


    GType gtk_file_chooser_error_get_type ();




    GType gtk_file_filter_flags_get_type ();




    GType gtk_icon_lookup_flags_get_type ();


    GType gtk_icon_theme_error_get_type ();




    GType gtk_image_type_get_type ();




    GType gtk_message_type_get_type ();


    GType gtk_buttons_type_get_type ();




    GType gtk_notebook_tab_get_type ();




    GType gtk_object_flags_get_type ();


    GType gtk_arg_flags_get_type ();




    GType gtk_private_flags_get_type ();




    GType gtk_progress_bar_style_get_type ();


    GType gtk_progress_bar_orientation_get_type ();




    GType gtk_rc_flags_get_type ();


    GType gtk_rc_token_type_get_type ();




    GType gtk_size_group_mode_get_type ();




    GType gtk_spin_button_update_policy_get_type ();


    GType gtk_spin_type_get_type ();




    GType gtk_text_search_flags_get_type ();




    GType gtk_text_window_type_get_type ();




    GType gtk_toolbar_child_type_get_type ();


    GType gtk_toolbar_space_style_get_type ();




    GType gtk_tree_view_mode_get_type ();




    GType gtk_tree_model_flags_get_type ();




    GType gtk_tree_view_drop_position_get_type ();




    GType gtk_tree_view_column_sizing_get_type ();




    GType gtk_ui_manager_item_type_get_type ();




    GType gtk_widget_flags_get_type ();


    GType gtk_widget_help_type_get_type ();








    GType gtk_identifier_get_type ();





    alias _GtkArg GtkArg;

    alias _GtkObject GtkObject;

    alias gboolean (*GtkFunction) (gpointer data);
    alias void (*GtkDestroyNotify) (gpointer data);
    alias void (*GtkCallbackMarshal) (GtkObject *object,
                    gpointer data,
                    guint n_args,
                    GtkArg *args);
    alias void (*GtkSignalFunc) ();



    alias _GtkTypeInfo GtkTypeInfo;

    alias GSignalCMarshaller GtkSignalMarshaller;






    struct _GtkArg {
    GtkType type;
    gchar *name;







    union d_union  {

    gchar char_data;
    guchar uchar_data;
    gboolean int_data1;
    gint int_data2;
    guint uint_data;
    glong int_data3;
    gulong ulong_data;
    gfloat float_data;
    gdouble double_data;
    gchar *string_data;
    GtkObject *object_data;
    gpointer pointer_data;


    struct signal_data_struct  {
    GtkSignalFunc f;
    gpointer d;
    }
    }
    d_union d;
    }
    struct _GtkTypeInfo {
    gchar *type_name;
    guint object_size;
    guint class_size;
    GtkClassInitFunc class_init_func;
    GtkObjectInitFunc object_init_func;
    gpointer reserved_1;
    gpointer reserved_2;
    GtkClassInitFunc base_class_init_func;
    }



    gpointer gtk_type_class (GtkType type);



    GtkType gtk_type_unique (GtkType parent_type,
                    GtkTypeInfo *gtkinfo);
    gpointer gtk_type_new (GtkType type);
    alias GEnumValue GtkEnumValue;
    alias GFlagsValue GtkFlagValue;
    GtkEnumValue* gtk_type_enum_get_values (GtkType enum_type);
    GtkFlagValue* gtk_type_flags_get_values (GtkType flags_type);
    GtkEnumValue* gtk_type_enum_find_value (GtkType enum_type,
                            gchar *value_name);
    GtkFlagValue* gtk_type_flags_find_value (GtkType flags_type,
                            gchar *value_name);





    void gtk_type_init (GTypeDebugFlags debug_flags);





    enum GtkDebugFlag {
    GTK_DEBUG_MISC = 1 << 0,
    GTK_DEBUG_PLUGSOCKET = 1 << 1,
    GTK_DEBUG_TEXT = 1 << 2,
    GTK_DEBUG_TREE = 1 << 3,
    GTK_DEBUG_UPDATES = 1 << 4,
    GTK_DEBUG_KEYBINDINGS = 1 << 5,
    GTK_DEBUG_MULTIHEAD = 1 << 6
    };

    guint gtk_debug_flags;




    enum GtkObjectFlags {
    GTK_IN_DESTRUCTION = 1 << 0,
    GTK_FLOATING = 1 << 1,
    GTK_RESERVED_1 = 1 << 2,
    GTK_RESERVED_2 = 1 << 3
    };

    alias _GtkObjectClass GtkObjectClass;



    struct _GtkObject {
    GObject parent_instance;






    guint32 flags;
    }

    struct _GtkObjectClass {
    GObjectClass parent_class;


    void (*set_arg) (GtkObject *object,
            GtkArg *arg,
            guint arg_id);
    void (*get_arg) (GtkObject *object,
            GtkArg *arg,
            guint arg_id);
    void (*destroy) (GtkObject *object);
    }





    GtkType gtk_object_get_type () ;

    void gtk_object_sink (GtkObject *object);
    void gtk_object_destroy (GtkObject *object);





    GtkObject* gtk_object_new (GtkType type,
                        gchar *first_property_name,
                        ...);
    GtkObject* gtk_object_ref (GtkObject *object);
    void gtk_object_unref (GtkObject *object);
    void gtk_object_weakref (GtkObject *object,
                GtkDestroyNotify notify,
                gpointer data);
    void gtk_object_weakunref (GtkObject *object,
                GtkDestroyNotify notify,
                gpointer data);
    void gtk_object_set_data (GtkObject *object,
                    gchar *key,
                    gpointer data);
    void gtk_object_set_data_full (GtkObject *object,
                    gchar *key,
                    gpointer data,
                    GtkDestroyNotify destroy);
    void gtk_object_remove_data (GtkObject *object,
                    gchar *key);
    gpointer gtk_object_get_data (GtkObject *object,
                    gchar *key);
    void gtk_object_remove_no_notify (GtkObject *object,
                    gchar *key);






    void gtk_object_set_user_data (GtkObject *object,
                    gpointer data);
    gpointer gtk_object_get_user_data (GtkObject *object);





    void gtk_object_set_data_by_id (GtkObject *object,
                        GQuark data_id,
                        gpointer data);
    void gtk_object_set_data_by_id_full (GtkObject *object,
                        GQuark data_id,
                        gpointer data,
                        GtkDestroyNotify destroy);
    gpointer gtk_object_get_data_by_id (GtkObject *object,
                        GQuark data_id);
    void gtk_object_remove_data_by_id (GtkObject *object,
                        GQuark data_id);
    void gtk_object_remove_no_notify_by_id (GtkObject *object,
                        GQuark key_id);





    enum GtkArgFlags {
    GTK_ARG_READABLE = GParamFlags.G_PARAM_READABLE,
    GTK_ARG_WRITABLE = GParamFlags.G_PARAM_WRITABLE,
    GTK_ARG_CONSTRUCT = GParamFlags.G_PARAM_CONSTRUCT,
    GTK_ARG_CONSTRUCT_ONLY = GParamFlags.G_PARAM_CONSTRUCT_ONLY,
    GTK_ARG_CHILD_ARG = 1 << 4
    };


    void gtk_object_get (GtkObject *object,
                    gchar *first_property_name,
                    ...);
    void gtk_object_set (GtkObject *object,
                    gchar *first_property_name,
                    ...);
    void gtk_object_add_arg_type ( gchar *arg_name,
                        GtkType arg_type,
                        guint arg_flags,
                        guint arg_id);




    alias _GtkAdjustment GtkAdjustment;

    alias _GtkAdjustmentClass GtkAdjustmentClass;


    struct _GtkAdjustment {
    GtkObject parent_instance;

    gdouble lower;
    gdouble upper;
    gdouble value;
    gdouble step_increment;
    gdouble page_increment;
    gdouble page_size;
    }

    struct _GtkAdjustmentClass {
    GtkObjectClass parent_class;

    void (* changed) (GtkAdjustment *adjustment);
    void (* value_changed) (GtkAdjustment *adjustment);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_adjustment_get_type () ;
    GtkObject* gtk_adjustment_new (gdouble value,
                        gdouble lower,
                        gdouble upper,
                        gdouble step_increment,
                        gdouble page_increment,
                        gdouble page_size);
    void gtk_adjustment_changed (GtkAdjustment *adjustment);
    void gtk_adjustment_value_changed (GtkAdjustment *adjustment);
    void gtk_adjustment_clamp_page (GtkAdjustment *adjustment,
                        gdouble lower,
                        gdouble upper);
    gdouble gtk_adjustment_get_value (GtkAdjustment *adjustment);
    void gtk_adjustment_set_value (GtkAdjustment *adjustment,
                        gdouble value);

    void gtk_adjustment_goto_value (GtkAdjustment *adjustment,
                        gdouble value);
    void gtk_adjustment_home (GtkAdjustment *adjustment);
    void gtk_adjustment_end (GtkAdjustment *adjustment);
    void gtk_adjustment_step_up (GtkAdjustment *adjustment);
    void gtk_adjustment_step_down (GtkAdjustment *adjustment);
    void gtk_adjustment_wheel_up (GtkAdjustment *adjustment);
    void gtk_adjustment_wheel_down (GtkAdjustment *adjustment);
    void gtk_adjustment_page_up (GtkAdjustment *adjustment);
    void gtk_adjustment_page_down (GtkAdjustment *adjustment);
    alias _GtkBorder GtkBorder;

    alias _GtkStyle GtkStyle;

    alias _GtkStyleClass GtkStyleClass;

    alias _GtkThemeEngine GtkThemeEngine;
    alias void _GtkThemeEngine;

    alias _GtkRcStyle GtkRcStyle;

    alias _GtkIconSet GtkIconSet;
    alias void _GtkIconSet;

    alias _GtkIconSource GtkIconSource;
    alias void _GtkIconSource;

    alias _GtkRcProperty GtkRcProperty;

    alias _GtkSettings GtkSettings;

    alias gboolean (*GtkRcPropertyParser) ( GParamSpec *pspec,
                        GString *rc_string,
                        GValue *property_value);




    alias _GtkWidget GtkWidget;




align(1)    struct _GtkStyle {
    GObject parent_instance;



    GdkColor fg[5];
    GdkColor bg[5];
    GdkColor light[5];
    GdkColor dark[5];
    GdkColor mid[5];
    GdkColor text[5];
    GdkColor base[5];
    GdkColor text_aa[5];

    GdkColor black;
    GdkColor white;
    PangoFontDescription *font_desc;

    gint xthickness;
    gint ythickness;

    GdkGC *fg_gc[5];
    GdkGC *bg_gc[5];
    GdkGC *light_gc[5];
    GdkGC *dark_gc[5];
    GdkGC *mid_gc[5];
    GdkGC *text_gc[5];
    GdkGC *base_gc[5];
    GdkGC *text_aa_gc[5];
    GdkGC *black_gc;
    GdkGC *white_gc;

    GdkPixmap *bg_pixmap[5];



    gint attach_count;

    gint depth;
    GdkColormap *colormap;
    GdkFont *private_font;
    PangoFontDescription *private_font_desc;


    GtkRcStyle *rc_style;

    GSList *styles;
    GArray *property_cache;
    GSList *icon_factories;
    }

    struct _GtkStyleClass {
    GObjectClass parent_class;





    void (*realize) (GtkStyle *style);




    void (*unrealize) (GtkStyle *style);



    void (*copy) (GtkStyle *style,
                    GtkStyle *src);






    GtkStyle *(*clone) (GtkStyle *style);




    void (*init_from_rc) (GtkStyle *style,
                    GtkRcStyle *rc_style);

    void (*set_background) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type);


    GdkPixbuf * (* render_icon) (GtkStyle *style,
                    GtkIconSource *source,
                    GtkTextDirection direction,
                    GtkStateType state,
                    GtkIconSize size,
                    GtkWidget *widget,
                    gchar *detail);




    void (*draw_hline) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x1,
                    gint x2,
                    gint y);
    void (*draw_vline) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint y1_,
                    gint y2_,
                    gint x);
    void (*draw_shadow) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_polygon) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    GdkPoint *point,
                    gint npoints,
                    gboolean fill);
    void (*draw_arrow) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    GtkArrowType arrow_type,
                    gboolean fill,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_diamond) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_string) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gchar *string);
    void (*draw_box) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_flat_box) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_check) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_option) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_tab) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_shadow_gap) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height,
                    GtkPositionType gap_side,
                    gint gap_x,
                    gint gap_width);
    void (*draw_box_gap) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height,
                    GtkPositionType gap_side,
                    gint gap_x,
                    gint gap_width);
    void (*draw_extension) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height,
                    GtkPositionType gap_side);
    void (*draw_focus) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height);
    void (*draw_slider) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height,
                    GtkOrientation orientation);
    void (*draw_handle) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GtkShadowType shadow_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    gint width,
                    gint height,
                    GtkOrientation orientation);

    void (*draw_expander) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    GtkExpanderStyle expander_style);
    void (*draw_layout) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    gboolean use_text,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    gint x,
                    gint y,
                    PangoLayout *layout);
    void (*draw_resize_grip) (GtkStyle *style,
                    GdkWindow *window,
                    GtkStateType state_type,
                    GdkRectangle *area,
                    GtkWidget *widget,
                    gchar *detail,
                    GdkWindowEdge edge,
                    gint x,
                    gint y,
                    gint width,
                    gint height);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    void (*_gtk_reserved5) ();
    void (*_gtk_reserved6) ();
    void (*_gtk_reserved7) ();
    void (*_gtk_reserved8) ();
    void (*_gtk_reserved9) ();
    void (*_gtk_reserved10) ();
    void (*_gtk_reserved11) ();
    void (*_gtk_reserved12) ();
    }

    struct _GtkBorder {
    gint left;
    gint right;
    gint top;
    gint bottom;
    }

    GType gtk_style_get_type () ;
    GtkStyle* gtk_style_new ();
    GtkStyle* gtk_style_copy (GtkStyle *style);
    GtkStyle* gtk_style_attach (GtkStyle *style,
                        GdkWindow *window);
    void gtk_style_detach (GtkStyle *style);


    GtkStyle* gtk_style_ref (GtkStyle *style);
    void gtk_style_unref (GtkStyle *style);

    GdkFont * gtk_style_get_font (GtkStyle *style);
    void gtk_style_set_font (GtkStyle *style,
                        GdkFont *font);


    void gtk_style_set_background (GtkStyle *style,
                        GdkWindow *window,
                        GtkStateType state_type);
    void gtk_style_apply_default_background (GtkStyle *style,
                        GdkWindow *window,
                        gboolean set_bg,
                        GtkStateType state_type,
                        GdkRectangle *area,
                        gint x,
                        gint y,
                        gint width,
                        gint height);

    GtkIconSet* gtk_style_lookup_icon_set (GtkStyle *style,
                        gchar *stock_id);
    GdkPixbuf* gtk_style_render_icon (GtkStyle *style,
                        GtkIconSource *source,
                    GtkTextDirection direction,
                    GtkStateType state,
                    GtkIconSize size,
                    GtkWidget *widget,
                        gchar *detail);

    void gtk_draw_hline (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                gint x1,
                gint x2,
                gint y);
    void gtk_draw_vline (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                gint y1_,
                gint y2_,
                gint x);
    void gtk_draw_shadow (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_polygon (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkPoint *points,
                gint npoints,
                gboolean fill);
    void gtk_draw_arrow (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GtkArrowType arrow_type,
                gboolean fill,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_diamond (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_box (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_flat_box (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_check (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_option (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_tab (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_shadow_gap (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkPositionType gap_side,
                gint gap_x,
                gint gap_width);
    void gtk_draw_box_gap (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkPositionType gap_side,
                gint gap_x,
                gint gap_width);
    void gtk_draw_extension (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkPositionType gap_side);
    void gtk_draw_focus (GtkStyle *style,
                GdkWindow *window,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_draw_slider (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkOrientation orientation);
    void gtk_draw_handle (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkOrientation orientation);
    void gtk_draw_expander (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                gint x,
                gint y,
                GtkExpanderStyle expander_style);
    void gtk_draw_layout (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                gboolean use_text,
                gint x,
                gint y,
                PangoLayout *layout);
    void gtk_draw_resize_grip (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GdkWindowEdge edge,
                gint x,
                gint y,
                gint width,
                gint height);


    void gtk_paint_hline (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x1,
                gint x2,
                gint y);
    void gtk_paint_vline (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint y1_,
                gint y2_,
                gint x);
    void gtk_paint_shadow (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_polygon (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                GdkPoint *points,
                gint npoints,
                gboolean fill);
    void gtk_paint_arrow (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                GtkArrowType arrow_type,
                gboolean fill,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_diamond (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_box (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_flat_box (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_check (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_option (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_tab (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_shadow_gap (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkPositionType gap_side,
                gint gap_x,
                gint gap_width);
    void gtk_paint_box_gap (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkPositionType gap_side,
                gint gap_x,
                gint gap_width);
    void gtk_paint_extension (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkPositionType gap_side);
    void gtk_paint_focus (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height);
    void gtk_paint_slider (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkOrientation orientation);
    void gtk_paint_handle (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GtkShadowType shadow_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gint width,
                gint height,
                GtkOrientation orientation);
    void gtk_paint_expander (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                GtkExpanderStyle expander_style);
    void gtk_paint_layout (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                gboolean use_text,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                PangoLayout *layout);

    void gtk_paint_resize_grip (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                GdkWindowEdge edge,
                gint x,
                gint y,
                gint width,
                gint height);


    GType gtk_border_get_type ();
    GtkBorder *gtk_border_copy ( GtkBorder *border_);
    void gtk_border_free ( GtkBorder *border_);


    GValue* _gtk_style_peek_property_value (GtkStyle *style,
                        GType widget_type,
                        GParamSpec *pspec,
                        GtkRcPropertyParser parser);

    void _gtk_style_init_for_settings (GtkStyle *style,
                    GtkSettings *settings);




    void gtk_draw_string (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                gint x,
                gint y,
                gchar *string);
    void gtk_paint_string (GtkStyle *style,
                GdkWindow *window,
                GtkStateType state_type,
                GdkRectangle *area,
                GtkWidget *widget,
                gchar *detail,
                gint x,
                gint y,
                gchar *string);


    void gtk_draw_insertion_cursor (GtkWidget *widget,
                    GdkDrawable *drawable,
                    GdkRectangle *area,
                    GdkRectangle *location,
                    gboolean is_primary,
                    GtkTextDirection direction,
                    gboolean draw_arrow);
    alias _GtkIconFactory GtkIconFactory;

    alias _GtkRcContext GtkRcContext;
    alias void _GtkRcContext;


    alias _GtkRcStyleClass GtkRcStyleClass;

    enum GtkRcFlags {
    GTK_RC_FG = 1 << 0,
    GTK_RC_BG = 1 << 1,
    GTK_RC_TEXT = 1 << 2,
    GTK_RC_BASE = 1 << 3
    };


    struct _GtkRcStyle {
    GObject parent_instance;



    gchar *name;
    gchar *bg_pixmap_name[5];
    PangoFontDescription *font_desc;

    GtkRcFlags color_flags[5];
    GdkColor fg[5];
    GdkColor bg[5];
    GdkColor text[5];
    GdkColor base[5];

    gint xthickness;
    gint ythickness;


    GArray *rc_properties;


    GSList *rc_style_lists;

    GSList *icon_factories;

    guint engine_specified;
    }

    struct _GtkRcStyleClass {
    GObjectClass parent_class;






    GtkRcStyle * (*create_rc_style) (GtkRcStyle *rc_style);





    guint (*parse) (GtkRcStyle *rc_style,
            GtkSettings *settings,
            GScanner *scanner);




    void (*merge) (GtkRcStyle *dest,
            GtkRcStyle *src);



    GtkStyle * (*create_style) (GtkRcStyle *rc_style);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    void _gtk_rc_init ();
    void gtk_rc_add_default_file ( gchar *filename);
    void gtk_rc_set_default_files (gchar **filenames);
    gchar** gtk_rc_get_default_files ();
    GtkStyle* gtk_rc_get_style (GtkWidget *widget);
    GtkStyle* gtk_rc_get_style_by_paths (GtkSettings *settings,
                        char *widget_path,
                        char *class_path,
                        GType type);

    gboolean gtk_rc_reparse_all_for_settings (GtkSettings *settings,
                        gboolean force_load);
    void gtk_rc_reset_styles (GtkSettings *settings);

    gchar* gtk_rc_find_pixmap_in_path (GtkSettings *settings,
                    GScanner *scanner,
                    gchar *pixmap_file);

    void gtk_rc_parse ( gchar *filename);
    void gtk_rc_parse_string ( gchar *rc_string);
    gboolean gtk_rc_reparse_all ();


    void gtk_rc_add_widget_name_style (GtkRcStyle *rc_style,
                        gchar *pattern);
    void gtk_rc_add_widget_class_style (GtkRcStyle *rc_style,
                        gchar *pattern);
    void gtk_rc_add_class_style (GtkRcStyle *rc_style,
                        gchar *pattern);



    GType gtk_rc_style_get_type () ;
    GtkRcStyle* gtk_rc_style_new ();
    GtkRcStyle* gtk_rc_style_copy (GtkRcStyle *orig);
    void gtk_rc_style_ref (GtkRcStyle *rc_style);
    void gtk_rc_style_unref (GtkRcStyle *rc_style);

    gchar* gtk_rc_find_module_in_path ( gchar *module_file);
    gchar* gtk_rc_get_theme_dir ();
    gchar* gtk_rc_get_module_dir ();
    gchar* gtk_rc_get_im_module_path ();
    gchar* gtk_rc_get_im_module_file ();


    enum GtkRcTokenType {
    GTK_RC_TOKEN_INVALID = GTokenType.G_TOKEN_LAST,
    GTK_RC_TOKEN_INCLUDE,
    GTK_RC_TOKEN_NORMAL,
    GTK_RC_TOKEN_ACTIVE,
    GTK_RC_TOKEN_PRELIGHT,
    GTK_RC_TOKEN_SELECTED,
    GTK_RC_TOKEN_INSENSITIVE,
    GTK_RC_TOKEN_FG,
    GTK_RC_TOKEN_BG,
    GTK_RC_TOKEN_TEXT,
    GTK_RC_TOKEN_BASE,
    GTK_RC_TOKEN_XTHICKNESS,
    GTK_RC_TOKEN_YTHICKNESS,
    GTK_RC_TOKEN_FONT,
    GTK_RC_TOKEN_FONTSET,
    GTK_RC_TOKEN_FONT_NAME,
    GTK_RC_TOKEN_BG_PIXMAP,
    GTK_RC_TOKEN_PIXMAP_PATH,
    GTK_RC_TOKEN_STYLE,
    GTK_RC_TOKEN_BINDING,
    GTK_RC_TOKEN_BIND,
    GTK_RC_TOKEN_WIDGET,
    GTK_RC_TOKEN_WIDGET_CLASS,
    GTK_RC_TOKEN_CLASS,
    GTK_RC_TOKEN_LOWEST,
    GTK_RC_TOKEN_GTK,
    GTK_RC_TOKEN_APPLICATION,
    GTK_RC_TOKEN_THEME,
    GTK_RC_TOKEN_RC,
    GTK_RC_TOKEN_HIGHEST,
    GTK_RC_TOKEN_ENGINE,
    GTK_RC_TOKEN_MODULE_PATH,
    GTK_RC_TOKEN_IM_MODULE_PATH,
    GTK_RC_TOKEN_IM_MODULE_FILE,
    GTK_RC_TOKEN_STOCK,
    GTK_RC_TOKEN_LTR,
    GTK_RC_TOKEN_RTL,
    GTK_RC_TOKEN_LAST
    };


    GScanner* gtk_rc_scanner_new ();
    guint gtk_rc_parse_color (GScanner *scanner,
                    GdkColor *color);
    guint gtk_rc_parse_state (GScanner *scanner,
                    GtkStateType *state);
    guint gtk_rc_parse_priority (GScanner *scanner,
                    GtkPathPriorityType *priority);




    struct _GtkRcProperty {

    GQuark type_name;
    GQuark property_name;


    gchar *origin;
    GValue value;
    }
    GtkRcProperty* _gtk_rc_style_lookup_rc_property (GtkRcStyle *rc_style,
                            GQuark type_name,
                            GQuark property_name);

    gchar* _gtk_rc_context_get_default_font_name (GtkSettings *settings);


    alias _GtkSettingsClass GtkSettingsClass;

    alias _GtkSettingsValue GtkSettingsValue;

    alias _GtkSettingsPropertyValue GtkSettingsPropertyValue;
    alias void _GtkSettingsPropertyValue;


    struct _GtkSettings {
    GObject parent_instance;

    GData *queued_settings;
    GtkSettingsPropertyValue *property_values;

    GtkRcContext *rc_context;
    GdkScreen *screen;
    }
    struct _GtkSettingsClass {
    GObjectClass parent_class;

    }
    struct _GtkSettingsValue {



    gchar *origin;




    GValue value;
    }



    GType gtk_settings_get_type ();

    GtkSettings* gtk_settings_get_default ();

    GtkSettings* gtk_settings_get_for_screen (GdkScreen *screen);

    void gtk_settings_install_property (GParamSpec *pspec);
    void gtk_settings_install_property_parser (GParamSpec *pspec,
                            GtkRcPropertyParser parser);


    gboolean gtk_rc_property_parse_color ( GParamSpec *pspec,
                        GString *gstring,
                        GValue *property_value);
    gboolean gtk_rc_property_parse_enum ( GParamSpec *pspec,
                        GString *gstring,
                        GValue *property_value);
    gboolean gtk_rc_property_parse_flags ( GParamSpec *pspec,
                        GString *gstring,
                        GValue *property_value);
    gboolean gtk_rc_property_parse_requisition ( GParamSpec *pspec,
                        GString *gstring,
                        GValue *property_value);
    gboolean gtk_rc_property_parse_border ( GParamSpec *pspec,
                        GString *gstring,
                        GValue *property_value);


    void gtk_settings_set_property_value (GtkSettings *settings,
                            gchar *name,
                            GtkSettingsValue *svalue);
    void gtk_settings_set_string_property (GtkSettings *settings,
                            gchar *name,
                            gchar *v_string,
                            gchar *origin);
    void gtk_settings_set_long_property (GtkSettings *settings,
                            gchar *name,
                            glong v_long,
                            gchar *origin);
    void gtk_settings_set_double_property (GtkSettings *settings,
                            gchar *name,
                            gdouble v_double,
                            gchar *origin);



    void _gtk_settings_set_property_value_from_rc (GtkSettings *settings,
                            gchar *name,
                            GtkSettingsValue *svalue);
    void _gtk_settings_reset_rc_values (GtkSettings *settings);

    void _gtk_settings_handle_event (GdkEventSetting *event);
    GtkRcPropertyParser _gtk_rc_property_parser_from_type (GType type);
    gboolean _gtk_settings_parse_convert (GtkRcPropertyParser parser,
                                GValue *src_value,
                            GParamSpec *pspec,
                            GValue *dest_value);



    enum AtkStateType {
    ATK_STATE_INVALID,
    ATK_STATE_ACTIVE,
    ATK_STATE_ARMED,
    ATK_STATE_BUSY,
    ATK_STATE_CHECKED,
    ATK_STATE_DEFUNCT,
    ATK_STATE_EDITABLE,
    ATK_STATE_ENABLED,
    ATK_STATE_EXPANDABLE,
    ATK_STATE_EXPANDED,
    ATK_STATE_FOCUSABLE,
    ATK_STATE_FOCUSED,
    ATK_STATE_HORIZONTAL,
    ATK_STATE_ICONIFIED,
    ATK_STATE_MODAL,
    ATK_STATE_MULTI_LINE,
    ATK_STATE_MULTISELECTABLE,
    ATK_STATE_OPAQUE,
    ATK_STATE_PRESSED,
    ATK_STATE_RESIZABLE,
    ATK_STATE_SELECTABLE,
    ATK_STATE_SELECTED,
    ATK_STATE_SENSITIVE,
    ATK_STATE_SHOWING,
    ATK_STATE_SINGLE_LINE,
    ATK_STATE_STALE,
    ATK_STATE_TRANSIENT,
    ATK_STATE_VERTICAL,
    ATK_STATE_VISIBLE,
    ATK_STATE_MANAGES_DESCENDANTS,
    ATK_STATE_INDETERMINATE,
    ATK_STATE_LAST_DEFINED
    };


    alias guint64 AtkState;

    AtkStateType atk_state_type_register ( gchar *name);

    gchar* atk_state_type_get_name (AtkStateType type);
    AtkStateType atk_state_type_for_name ( gchar *name);
    enum AtkRelationType {
    ATK_RELATION_NULL = 0,
    ATK_RELATION_CONTROLLED_BY,
    ATK_RELATION_CONTROLLER_FOR,
    ATK_RELATION_LABEL_FOR,
    ATK_RELATION_LABELLED_BY,
    ATK_RELATION_MEMBER_OF,
    ATK_RELATION_NODE_CHILD_OF,
    ATK_RELATION_FLOWS_TO,
    ATK_RELATION_FLOWS_FROM,
    ATK_RELATION_SUBWINDOW_OF,
    ATK_RELATION_EMBEDS,
    ATK_RELATION_EMBEDDED_BY,
    ATK_RELATION_POPUP_FOR,
    ATK_RELATION_LAST_DEFINED
    };

    enum AtkRole {
    ATK_ROLE_INVALID = 0,
    ATK_ROLE_ACCEL_LABEL,
    ATK_ROLE_ALERT,
    ATK_ROLE_ANIMATION,
    ATK_ROLE_ARROW,
    ATK_ROLE_CALENDAR,
    ATK_ROLE_CANVAS,
    ATK_ROLE_CHECK_BOX,
    ATK_ROLE_CHECK_MENU_ITEM,
    ATK_ROLE_COLOR_CHOOSER,
    ATK_ROLE_COLUMN_HEADER,
    ATK_ROLE_COMBO_BOX,
    ATK_ROLE_DATE_EDITOR,
    ATK_ROLE_DESKTOP_ICON,
    ATK_ROLE_DESKTOP_FRAME,
    ATK_ROLE_DIAL,
    ATK_ROLE_DIALOG,
    ATK_ROLE_DIRECTORY_PANE,
    ATK_ROLE_DRAWING_AREA,
    ATK_ROLE_FILE_CHOOSER,
    ATK_ROLE_FILLER,
    ATK_ROLE_FONT_CHOOSER,
    ATK_ROLE_FRAME,
    ATK_ROLE_GLASS_PANE,
    ATK_ROLE_HTML_CONTAINER,
    ATK_ROLE_ICON,
    ATK_ROLE_IMAGE,
    ATK_ROLE_INTERNAL_FRAME,
    ATK_ROLE_LABEL,
    ATK_ROLE_LAYERED_PANE,
    ATK_ROLE_LIST,
    ATK_ROLE_LIST_ITEM,
    ATK_ROLE_MENU,
    ATK_ROLE_MENU_BAR,
    ATK_ROLE_MENU_ITEM,
    ATK_ROLE_OPTION_PANE,
    ATK_ROLE_PAGE_TAB,
    ATK_ROLE_PAGE_TAB_LIST,
    ATK_ROLE_PANEL,
    ATK_ROLE_PASSWORD_TEXT,
    ATK_ROLE_POPUP_MENU,
    ATK_ROLE_PROGRESS_BAR,
    ATK_ROLE_PUSH_BUTTON,
    ATK_ROLE_RADIO_BUTTON,
    ATK_ROLE_RADIO_MENU_ITEM,
    ATK_ROLE_ROOT_PANE,
    ATK_ROLE_ROW_HEADER,
    ATK_ROLE_SCROLL_BAR,
    ATK_ROLE_SCROLL_PANE,
    ATK_ROLE_SEPARATOR,
    ATK_ROLE_SLIDER,
    ATK_ROLE_SPLIT_PANE,
    ATK_ROLE_SPIN_BUTTON,
    ATK_ROLE_STATUSBAR,
    ATK_ROLE_TABLE,
    ATK_ROLE_TABLE_CELL,
    ATK_ROLE_TABLE_COLUMN_HEADER,
    ATK_ROLE_TABLE_ROW_HEADER,
    ATK_ROLE_TEAR_OFF_MENU_ITEM,
    ATK_ROLE_TERMINAL,
    ATK_ROLE_TEXT,
    ATK_ROLE_TOGGLE_BUTTON,
    ATK_ROLE_TOOL_BAR,
    ATK_ROLE_TOOL_TIP,
    ATK_ROLE_TREE,
    ATK_ROLE_TREE_TABLE,
    ATK_ROLE_UNKNOWN,
    ATK_ROLE_VIEWPORT,
    ATK_ROLE_WINDOW,
    ATK_ROLE_HEADER,
    ATK_ROLE_FOOTER,
    ATK_ROLE_PARAGRAPH,
    ATK_ROLE_RULER,
    ATK_ROLE_APPLICATION,
    ATK_ROLE_AUTOCOMPLETE,
    ATK_ROLE_EDITBAR,
    ATK_ROLE_LAST_DEFINED
    };


    AtkRole atk_role_register ( gchar *name);
    enum AtkLayer {
    ATK_LAYER_INVALID,
    ATK_LAYER_BACKGROUND,
    ATK_LAYER_CANVAS,
    ATK_LAYER_WIDGET,
    ATK_LAYER_MDI,
    ATK_LAYER_POPUP,
    ATK_LAYER_OVERLAY,
    ATK_LAYER_WINDOW
    };

    alias _AtkImplementor AtkImplementor;
    alias void _AtkImplementor;

    alias _AtkImplementorIface AtkImplementorIface;



    alias _AtkObject AtkObject;

    alias _AtkObjectClass AtkObjectClass;

    alias _AtkRelationSet AtkRelationSet;

    alias _AtkStateSet AtkStateSet;


    struct _AtkPropertyValues {
    gchar *property_name;
    GValue old_value;
    GValue new_value;
    }

    alias _AtkPropertyValues AtkPropertyValues;


    alias gboolean (*AtkFunction) (gpointer data);
    alias void (*AtkPropertyChangeHandler) (AtkObject*, AtkPropertyValues*);


    struct _AtkObject {
    GObject parent;

    gchar *description;
    gchar *name;
    AtkObject *accessible_parent;
    AtkRole role;
    AtkRelationSet *relation_set;
    AtkLayer layer;
    }

    struct _AtkObjectClass {
    GObjectClass parent;




    gchar* (* get_name) (AtkObject *accessible);



    gchar* (* get_description) (AtkObject *accessible);



    AtkObject* (*get_parent) (AtkObject *accessible);




    gint (* get_n_children) (AtkObject *accessible);





    AtkObject* (* ref_child) (AtkObject *accessible,
                            gint i);




    gint (* get_index_in_parent) (AtkObject *accessible);



    AtkRelationSet* (* ref_relation_set) (AtkObject *accessible);



    AtkRole (* get_role) (AtkObject *accessible);
    AtkLayer (* get_layer) (AtkObject *accessible);
    gint (* get_mdi_zorder) (AtkObject *accessible);



    AtkStateSet* (* ref_state_set) (AtkObject *accessible);



    void (* set_name) (AtkObject *accessible,
                            gchar *name);



    void (* set_description) (AtkObject *accessible,
                            gchar *description);



    void (* set_parent) (AtkObject *accessible,
                            AtkObject *parent);



    void (* set_role) (AtkObject *accessible,
                            AtkRole role);



    guint (* connect_property_change_handler) (AtkObject
            *accessible,
                                    AtkPropertyChangeHandler *handler);




    void (* remove_property_change_handler) (AtkObject
            *accessible,
                                    guint
            handler_id);
    void (* initialize) (AtkObject *accessible,
                                    gpointer data);




    void (* children_changed) (AtkObject *accessible,
                            guint change_index,
                            gpointer changed_child);




    void (* focus_event) (AtkObject *accessible,
                            gboolean focus_in);




    void (* property_change) (AtkObject *accessible,
                            AtkPropertyValues *values);




    void (* state_change) (AtkObject *accessible,
                            gchar *name,
                            gboolean state_set);




    void (*visible_data_changed) (AtkObject *accessible);







    void (*active_descendant_changed) (AtkObject *accessible,
                                gpointer *child);

    AtkFunction pad1;
    AtkFunction pad2;
    AtkFunction pad3;

    }

    GType atk_object_get_type ();

    struct _AtkImplementorIface {
    GTypeInterface parent;

    AtkObject* (*ref_accessible) (AtkImplementor *implementor);
    }
    GType atk_implementor_get_type ();
    AtkObject* atk_implementor_ref_accessible (AtkImplementor *implementor);





    gchar* atk_object_get_name (AtkObject *accessible);
    gchar* atk_object_get_description (AtkObject *accessible);
    AtkObject* atk_object_get_parent (AtkObject *accessible);
    gint atk_object_get_n_accessible_children (AtkObject *accessible);
    AtkObject* atk_object_ref_accessible_child (AtkObject *accessible,
                                    gint i);
    AtkRelationSet* atk_object_ref_relation_set (AtkObject *accessible);
    AtkRole atk_object_get_role (AtkObject *accessible);
    AtkLayer atk_object_get_layer (AtkObject *accessible);
    gint atk_object_get_mdi_zorder (AtkObject *accessible);
    AtkStateSet* atk_object_ref_state_set (AtkObject *accessible);
    gint atk_object_get_index_in_parent (AtkObject *accessible);
    void atk_object_set_name (AtkObject *accessible,
                                    gchar *name);
    void atk_object_set_description (AtkObject *accessible,
                                    gchar *description);
    void atk_object_set_parent (AtkObject *accessible,
                                    AtkObject *parent);
    void atk_object_set_role (AtkObject *accessible,
                                    AtkRole role);


    guint atk_object_connect_property_change_handler (AtkObject *accessible,
                                    AtkPropertyChangeHandler *handler);
    void atk_object_remove_property_change_handler (AtkObject *accessible,
                                    guint handler_id);

    void atk_object_notify_state_change (AtkObject *accessible,
                                    AtkState state,
                                    gboolean value);
    void atk_object_initialize (AtkObject *accessible,
                                    gpointer data);

    gchar* atk_role_get_name (AtkRole role);
    AtkRole atk_role_for_name ( gchar *name);



    gboolean atk_object_add_relationship (AtkObject *object,
                                    AtkRelationType relationship,
                                    AtkObject *target);
    gboolean atk_object_remove_relationship (AtkObject *object,
                                    AtkRelationType relationship,
                                    AtkObject *target);
    gchar* atk_role_get_localized_name (AtkRole role);
    enum GtkWidgetFlags {
    GTK_TOPLEVEL = 1 << 4,
    GTK_NO_WINDOW = 1 << 5,
    GTK_REALIZED = 1 << 6,
    GTK_MAPPED = 1 << 7,
    GTK_VISIBLE = 1 << 8,
    GTK_SENSITIVE = 1 << 9,
    GTK_PARENT_SENSITIVE = 1 << 10,
    GTK_CAN_FOCUS = 1 << 11,
    GTK_HAS_FOCUS = 1 << 12,




    GTK_CAN_DEFAULT = 1 << 13,




    GTK_HAS_DEFAULT = 1 << 14,

    GTK_HAS_GRAB = 1 << 15,
    GTK_RC_STYLE = 1 << 16,
    GTK_COMPOSITE_CHILD = 1 << 17,
    GTK_NO_REPARENT = 1 << 18,
    GTK_APP_PAINTABLE = 1 << 19,




    GTK_RECEIVES_DEFAULT = 1 << 20,

    GTK_DOUBLE_BUFFERED = 1 << 21,
    GTK_NO_SHOW_ALL = 1 << 22
    };



    enum GtkWidgetHelpType {
    GTK_WIDGET_HELP_TOOLTIP,
    GTK_WIDGET_HELP_WHATS_THIS
    };

    alias _GtkRequisition GtkRequisition;

    alias GdkRectangle GtkAllocation;
    alias _GtkSelectionData GtkSelectionData;

    alias _GtkWidgetClass GtkWidgetClass;

    alias _GtkWidgetAuxInfo GtkWidgetAuxInfo;

    alias _GtkWidgetShapeInfo GtkWidgetShapeInfo;

    alias _GtkClipboard GtkClipboard;
    alias void _GtkClipboard;

    alias void (*GtkCallback) (GtkWidget *widget,
                        gpointer data);




    struct _GtkRequisition {
    gint width;
    gint height;
    }






    struct _GtkWidget {






    GtkObject object;






    guint16 private_flags;




    guint8 state;







    guint8 saved_state;







    gchar *name;
    GtkStyle *style;



    GtkRequisition requisition;



    GtkAllocation allocation;





    GdkWindow *window;



    GtkWidget *parent;
    }

    struct _GtkWidgetClass {






    GtkObjectClass parent_class;



    guint activate_signal;

    guint set_scroll_adjustments_signal;




    void (*dispatch_child_properties_changed) (GtkWidget *widget,
                        guint n_pspecs,
                        GParamSpec **pspecs);


    void (* show) (GtkWidget *widget);
    void (* show_all) (GtkWidget *widget);
    void (* hide) (GtkWidget *widget);
    void (* hide_all) (GtkWidget *widget);
    void (* map) (GtkWidget *widget);
    void (* unmap) (GtkWidget *widget);
    void (* realize) (GtkWidget *widget);
    void (* unrealize) (GtkWidget *widget);
    void (* size_request) (GtkWidget *widget,
                    GtkRequisition *requisition);
    void (* size_allocate) (GtkWidget *widget,
                    GtkAllocation *allocation);
    void (* state_changed) (GtkWidget *widget,
                    GtkStateType previous_state);
    void (* parent_set) (GtkWidget *widget,
                    GtkWidget *previous_parent);
    void (* hierarchy_changed) (GtkWidget *widget,
                    GtkWidget *previous_toplevel);
    void (* style_set) (GtkWidget *widget,
                    GtkStyle *previous_style);
    void (* direction_changed) (GtkWidget *widget,
                    GtkTextDirection previous_direction);
    void (* grab_notify) (GtkWidget *widget,
                    gboolean was_grabbed);
    void (* child_notify) (GtkWidget *widget,
                    GParamSpec *pspec);


    gboolean (* mnemonic_activate) (GtkWidget *widget,
                    gboolean group_cycling);


    void (* grab_focus) (GtkWidget *widget);
    gboolean (* focus) (GtkWidget *widget,
                    GtkDirectionType direction);


    gboolean (* event) (GtkWidget *widget,
                        GdkEvent *event);
    gboolean (* button_press_event) (GtkWidget *widget,
                        GdkEventButton *event);
    gboolean (* button_release_event) (GtkWidget *widget,
                        GdkEventButton *event);
    gboolean (* scroll_event) (GtkWidget *widget,
                        GdkEventScroll *event);
    gboolean (* motion_notify_event) (GtkWidget *widget,
                        GdkEventMotion *event);
    gboolean (* delete_event) (GtkWidget *widget,
                        GdkEventAny *event);
    gboolean (* destroy_event) (GtkWidget *widget,
                        GdkEventAny *event);
    gboolean (* expose_event) (GtkWidget *widget,
                        GdkEventExpose *event);
    gboolean (* key_press_event) (GtkWidget *widget,
                        GdkEventKey *event);
    gboolean (* key_release_event) (GtkWidget *widget,
                        GdkEventKey *event);
    gboolean (* enter_notify_event) (GtkWidget *widget,
                        GdkEventCrossing *event);
    gboolean (* leave_notify_event) (GtkWidget *widget,
                        GdkEventCrossing *event);
    gboolean (* configure_event) (GtkWidget *widget,
                        GdkEventConfigure *event);
    gboolean (* focus_in_event) (GtkWidget *widget,
                        GdkEventFocus *event);
    gboolean (* focus_out_event) (GtkWidget *widget,
                        GdkEventFocus *event);
    gboolean (* map_event) (GtkWidget *widget,
                        GdkEventAny *event);
    gboolean (* unmap_event) (GtkWidget *widget,
                        GdkEventAny *event);
    gboolean (* property_notify_event) (GtkWidget *widget,
                        GdkEventProperty *event);
    gboolean (* selection_clear_event) (GtkWidget *widget,
                        GdkEventSelection *event);
    gboolean (* selection_request_event) (GtkWidget *widget,
                        GdkEventSelection *event);
    gboolean (* selection_notify_event) (GtkWidget *widget,
                        GdkEventSelection *event);
    gboolean (* proximity_in_event) (GtkWidget *widget,
                        GdkEventProximity *event);
    gboolean (* proximity_out_event) (GtkWidget *widget,
                        GdkEventProximity *event);
    gboolean (* visibility_notify_event) (GtkWidget *widget,
                        GdkEventVisibility *event);
    gboolean (* client_event) (GtkWidget *widget,
                        GdkEventClient *event);
    gboolean (* no_expose_event) (GtkWidget *widget,
                        GdkEventAny *event);
    gboolean (* window_state_event) (GtkWidget *widget,
                        GdkEventWindowState *event);


    void (* selection_get) (GtkWidget *widget,
                    GtkSelectionData *selection_data,
                    guint info,
                    guint time_);
    void (* selection_received) (GtkWidget *widget,
                    GtkSelectionData *selection_data,
                    guint time_);


    void (* drag_begin) (GtkWidget *widget,
                    GdkDragContext *context);
    void (* drag_end) (GtkWidget *widget,
                    GdkDragContext *context);
    void (* drag_data_get) (GtkWidget *widget,
                    GdkDragContext *context,
                    GtkSelectionData *selection_data,
                    guint info,
                    guint time_);
    void (* drag_data_delete) (GtkWidget *widget,
                    GdkDragContext *context);


    void (* drag_leave) (GtkWidget *widget,
                    GdkDragContext *context,
                    guint time_);
    gboolean (* drag_motion) (GtkWidget *widget,
                    GdkDragContext *context,
                    gint x,
                    gint y,
                    guint time_);
    gboolean (* drag_drop) (GtkWidget *widget,
                    GdkDragContext *context,
                    gint x,
                    gint y,
                    guint time_);
    void (* drag_data_received) (GtkWidget *widget,
                    GdkDragContext *context,
                    gint x,
                    gint y,
                    GtkSelectionData *selection_data,
                    guint info,
                    guint time_);


    gboolean (* popup_menu) (GtkWidget *widget);






    gboolean (* show_help) (GtkWidget *widget,
                    GtkWidgetHelpType help_type);



    AtkObject* (*get_accessible) (GtkWidget *widget);

    void (*screen_changed) (GtkWidget *widget,
                    GdkScreen *previous_screen);
    gboolean (*can_activate_accel) (GtkWidget *widget,
                    guint signal_id);


    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    void (*_gtk_reserved5) ();
    void (*_gtk_reserved6) ();
    void (*_gtk_reserved7) ();
    }

    struct _GtkWidgetAuxInfo {
    gint x;
    gint y;
    gint width;
    gint height;
    guint x_set;
    guint y_set;
    }

    struct _GtkWidgetShapeInfo {
    gint16 offset_x;
    gint16 offset_y;
    GdkBitmap *shape_mask;
    }

    GType gtk_widget_get_type () ;
    GtkWidget* gtk_widget_new (GType type,
                        gchar *first_property_name,
                        ...);
    GtkWidget* gtk_widget_ref (GtkWidget *widget);
    void gtk_widget_unref (GtkWidget *widget);
    void gtk_widget_destroy (GtkWidget *widget);
    void gtk_widget_destroyed (GtkWidget *widget,
                        GtkWidget **widget_pointer);

    void gtk_widget_set (GtkWidget *widget,
                        gchar *first_property_name,
                        ...);

    void gtk_widget_unparent (GtkWidget *widget);
    void gtk_widget_show (GtkWidget *widget);
    void gtk_widget_show_now (GtkWidget *widget);
    void gtk_widget_hide (GtkWidget *widget);
    void gtk_widget_show_all (GtkWidget *widget);
    void gtk_widget_hide_all (GtkWidget *widget);
    void gtk_widget_set_no_show_all (GtkWidget *widget,
                        gboolean no_show_all);
    gboolean gtk_widget_get_no_show_all (GtkWidget *widget);
    void gtk_widget_map (GtkWidget *widget);
    void gtk_widget_unmap (GtkWidget *widget);
    void gtk_widget_realize (GtkWidget *widget);
    void gtk_widget_unrealize (GtkWidget *widget);


    void gtk_widget_queue_draw (GtkWidget *widget);
    void gtk_widget_queue_draw_area (GtkWidget *widget,
                        gint x,
                        gint y,
                        gint width,
                        gint height);

    void gtk_widget_queue_clear (GtkWidget *widget);
    void gtk_widget_queue_clear_area (GtkWidget *widget,
                        gint x,
                        gint y,
                        gint width,
                        gint height);



    void gtk_widget_queue_resize (GtkWidget *widget);
    void gtk_widget_queue_resize_no_redraw (GtkWidget *widget);

    void gtk_widget_draw (GtkWidget *widget,
                        GdkRectangle *area);

    void gtk_widget_size_request (GtkWidget *widget,
                        GtkRequisition *requisition);
    void gtk_widget_size_allocate (GtkWidget *widget,
                        GtkAllocation *allocation);
    void gtk_widget_get_child_requisition (GtkWidget *widget,
                        GtkRequisition *requisition);
    void gtk_widget_add_accelerator (GtkWidget *widget,
                        gchar *accel_signal,
                        GtkAccelGroup *accel_group,
                        guint accel_key,
                        GdkModifierType accel_mods,
                        GtkAccelFlags accel_flags);
    gboolean gtk_widget_remove_accelerator (GtkWidget *widget,
                        GtkAccelGroup *accel_group,
                        guint accel_key,
                        GdkModifierType accel_mods);
    void gtk_widget_set_accel_path (GtkWidget *widget,
                        gchar *accel_path,
                        GtkAccelGroup *accel_group);
    gchar* _gtk_widget_get_accel_path (GtkWidget *widget,
                        gboolean *locked);
    GList* gtk_widget_list_accel_closures (GtkWidget *widget);
    gboolean gtk_widget_can_activate_accel (GtkWidget *widget,
                        guint signal_id);
    gboolean gtk_widget_mnemonic_activate (GtkWidget *widget,
                        gboolean group_cycling);
    gboolean gtk_widget_event (GtkWidget *widget,
                        GdkEvent *event);
    gint gtk_widget_send_expose (GtkWidget *widget,
                        GdkEvent *event);

    gboolean gtk_widget_activate (GtkWidget *widget);
    gboolean gtk_widget_set_scroll_adjustments (GtkWidget *widget,
                        GtkAdjustment *hadjustment,
                        GtkAdjustment *vadjustment);

    void gtk_widget_reparent (GtkWidget *widget,
                        GtkWidget *new_parent);
    gboolean gtk_widget_intersect (GtkWidget *widget,
                        GdkRectangle *area,
                        GdkRectangle *intersection);
    GdkRegion *gtk_widget_region_intersect (GtkWidget *widget,
                        GdkRegion *region);

    void gtk_widget_freeze_child_notify (GtkWidget *widget);
    void gtk_widget_child_notify (GtkWidget *widget,
                        gchar *child_property);
    void gtk_widget_thaw_child_notify (GtkWidget *widget);

    gboolean gtk_widget_is_focus (GtkWidget *widget);
    void gtk_widget_grab_focus (GtkWidget *widget);
    void gtk_widget_grab_default (GtkWidget *widget);

    void gtk_widget_set_name (GtkWidget *widget,
                                gchar *name);
    gchar* gtk_widget_get_name (GtkWidget *widget);
    void gtk_widget_set_state (GtkWidget *widget,
                                GtkStateType state);
    void gtk_widget_set_sensitive (GtkWidget *widget,
                                gboolean sensitive);
    void gtk_widget_set_app_paintable (GtkWidget *widget,
                                gboolean app_paintable);
    void gtk_widget_set_double_buffered (GtkWidget *widget,
                                gboolean double_buffered);
    void gtk_widget_set_redraw_on_allocate (GtkWidget *widget,
                                gboolean redraw_on_allocate);
    void gtk_widget_set_parent (GtkWidget *widget,
                                GtkWidget *parent);
    void gtk_widget_set_parent_window (GtkWidget *widget,
                                GdkWindow *parent_window);
    void gtk_widget_set_child_visible (GtkWidget *widget,
                                gboolean is_visible);
    gboolean gtk_widget_get_child_visible (GtkWidget *widget);

    GtkWidget *gtk_widget_get_parent (GtkWidget *widget);
    GdkWindow *gtk_widget_get_parent_window (GtkWidget *widget);

    gboolean gtk_widget_child_focus (GtkWidget *widget,
                        GtkDirectionType direction);

    void gtk_widget_set_size_request (GtkWidget *widget,
                        gint width,
                        gint height);
    void gtk_widget_get_size_request (GtkWidget *widget,
                        gint *width,
                        gint *height);

    void gtk_widget_set_uposition (GtkWidget *widget,
                        gint x,
                        gint y);
    void gtk_widget_set_usize (GtkWidget *widget,
                        gint width,
                        gint height);


    void gtk_widget_set_events (GtkWidget *widget,
                        gint events);
    void gtk_widget_add_events (GtkWidget *widget,
                        gint events);
    void gtk_widget_set_extension_events (GtkWidget *widget,
                        GdkExtensionMode mode);

    GdkExtensionMode gtk_widget_get_extension_events (GtkWidget *widget);
    GtkWidget* gtk_widget_get_toplevel (GtkWidget *widget);
    GtkWidget* gtk_widget_get_ancestor (GtkWidget *widget,
                        GType widget_type);
    GdkColormap* gtk_widget_get_colormap (GtkWidget *widget);
    GdkVisual* gtk_widget_get_visual (GtkWidget *widget);

    GdkScreen * gtk_widget_get_screen (GtkWidget *widget);
    gboolean gtk_widget_has_screen (GtkWidget *widget);
    GdkDisplay * gtk_widget_get_display (GtkWidget *widget);
    GdkWindow * gtk_widget_get_root_window (GtkWidget *widget);
    GtkSettings* gtk_widget_get_settings (GtkWidget *widget);
    GtkClipboard *gtk_widget_get_clipboard (GtkWidget *widget,
                        GdkAtom selection);
    AtkObject* gtk_widget_get_accessible (GtkWidget *widget);







    void gtk_widget_set_colormap (GtkWidget *widget,
                        GdkColormap *colormap);

    gint gtk_widget_get_events (GtkWidget *widget);
    void gtk_widget_get_pointer (GtkWidget *widget,
                        gint *x,
                        gint *y);

    gboolean gtk_widget_is_ancestor (GtkWidget *widget,
                        GtkWidget *ancestor);

    gboolean gtk_widget_translate_coordinates (GtkWidget *src_widget,
                        GtkWidget *dest_widget,
                        gint src_x,
                        gint src_y,
                        gint *dest_x,
                        gint *dest_y);



    gboolean gtk_widget_hide_on_delete (GtkWidget *widget);



    void gtk_widget_set_style (GtkWidget *widget,
                        GtkStyle *style);
    void gtk_widget_ensure_style (GtkWidget *widget);
    GtkStyle* gtk_widget_get_style (GtkWidget *widget);

    void gtk_widget_modify_style (GtkWidget *widget,
                        GtkRcStyle *style);
    GtkRcStyle *gtk_widget_get_modifier_style (GtkWidget *widget);
    void gtk_widget_modify_fg (GtkWidget *widget,
                        GtkStateType state,
                        GdkColor *color);
    void gtk_widget_modify_bg (GtkWidget *widget,
                        GtkStateType state,
                        GdkColor *color);
    void gtk_widget_modify_text (GtkWidget *widget,
                        GtkStateType state,
                        GdkColor *color);
    void gtk_widget_modify_base (GtkWidget *widget,
                        GtkStateType state,
                        GdkColor *color);
    void gtk_widget_modify_font (GtkWidget *widget,
                        PangoFontDescription *font_desc);






    PangoContext *gtk_widget_create_pango_context (GtkWidget *widget);
    PangoContext *gtk_widget_get_pango_context (GtkWidget *widget);
    PangoLayout *gtk_widget_create_pango_layout (GtkWidget *widget,
                            gchar *text);

    GdkPixbuf *gtk_widget_render_icon (GtkWidget *widget,
                            gchar *stock_id,
                        GtkIconSize size,
                            gchar *detail);




    void gtk_widget_set_composite_name (GtkWidget *widget,
                        gchar *name);
    gchar* gtk_widget_get_composite_name (GtkWidget *widget);


    void gtk_widget_reset_rc_styles (GtkWidget *widget);





    void gtk_widget_push_colormap (GdkColormap *cmap);
    void gtk_widget_push_composite_child ();
    void gtk_widget_pop_composite_child ();
    void gtk_widget_pop_colormap ();



    void gtk_widget_class_install_style_property (GtkWidgetClass *klass,
                            GParamSpec *pspec);
    void gtk_widget_class_install_style_property_parser (GtkWidgetClass *klass,
                            GParamSpec *pspec,
                            GtkRcPropertyParser parser);
    GParamSpec* gtk_widget_class_find_style_property (GtkWidgetClass *klass,
                            gchar *property_name);
    GParamSpec** gtk_widget_class_list_style_properties (GtkWidgetClass *klass,
                            guint *n_properties);
    void gtk_widget_style_get_property (GtkWidget *widget,
                    gchar *property_name,
                    GValue *value);
    void gtk_widget_style_get_valist (GtkWidget *widget,
                    gchar *first_property_name,
                    va_list var_args);
    void gtk_widget_style_get (GtkWidget *widget,
                    gchar *first_property_name,
                    ...);




    void gtk_widget_set_default_colormap (GdkColormap *colormap);
    GtkStyle* gtk_widget_get_default_style ();

    GdkColormap* gtk_widget_get_default_colormap ();
    GdkVisual* gtk_widget_get_default_visual ();





    void gtk_widget_set_direction (GtkWidget *widget,
                            GtkTextDirection dir);
    GtkTextDirection gtk_widget_get_direction (GtkWidget *widget);

    void gtk_widget_set_default_direction (GtkTextDirection dir);
    GtkTextDirection gtk_widget_get_default_direction ();



    void gtk_widget_shape_combine_mask (GtkWidget *widget,
                        GdkBitmap *shape_mask,
                        gint offset_x,
                        gint offset_y);


    void gtk_widget_reset_shapes (GtkWidget *widget);




    void gtk_widget_path (GtkWidget *widget,
                        guint *path_length,
                        gchar **path,
                        gchar **path_reversed);
    void gtk_widget_class_path (GtkWidget *widget,
                        guint *path_length,
                        gchar **path,
                        gchar **path_reversed);

    GList* gtk_widget_list_mnemonic_labels (GtkWidget *widget);
    void gtk_widget_add_mnemonic_label (GtkWidget *widget,
                        GtkWidget *label);
    void gtk_widget_remove_mnemonic_label (GtkWidget *widget,
                        GtkWidget *label);

    GType gtk_requisition_get_type ();
    GtkRequisition *gtk_requisition_copy ( GtkRequisition *requisition);
    void gtk_requisition_free (GtkRequisition *requisition);






    void _gtk_widget_grab_notify (GtkWidget *widget,
                                gboolean was_grabbed);

    GtkWidgetAuxInfo *_gtk_widget_get_aux_info (GtkWidget *widget,
                                gboolean create);
    void _gtk_widget_propagate_hierarchy_changed (GtkWidget *widget,
                                GtkWidget *previous_toplevel);
    void _gtk_widget_propagate_screen_changed (GtkWidget *widget,
                                GdkScreen *previous_screen);

    GdkColormap* _gtk_widget_peek_colormap ();
    alias _GtkMisc GtkMisc;

    alias _GtkMiscClass GtkMiscClass;


    struct _GtkMisc {
    GtkWidget widget;

    gfloat xalign;
    gfloat yalign;

    guint16 xpad;
    guint16 ypad;
    }

    struct _GtkMiscClass {
    GtkWidgetClass parent_class;
    }


    GType gtk_misc_get_type () ;
    void gtk_misc_set_alignment (GtkMisc *misc,
                    gfloat xalign,
                    gfloat yalign);
    void gtk_misc_get_alignment (GtkMisc *misc,
                    gfloat *xalign,
                    gfloat *yalign);
    void gtk_misc_set_padding (GtkMisc *misc,
                    gint xpad,
                    gint ypad);
    void gtk_misc_get_padding (GtkMisc *misc,
                    gint *xpad,
                    gint *ypad);
    alias _GtkContainer GtkContainer;

    alias _GtkContainerClass GtkContainerClass;


    struct _GtkContainer {
    GtkWidget widget;

    GtkWidget *focus_child;

    guint border_width;
      /* needs alignment work BVH
    guint need_resize;
    guint resize_mode;
    guint reallocate_redraws;
    guint has_focus_chain;
      */
    }

    struct _GtkContainerClass {
    GtkWidgetClass parent_class;

    void (*add) (GtkContainer *container,
                    GtkWidget *widget);
    void (*remove) (GtkContainer *container,
                    GtkWidget *widget);
    void (*check_resize) (GtkContainer *container);
    void (*forall) (GtkContainer *container,
                    gboolean include_internals,
                    GtkCallback callback,
                    gpointer callback_data);
    void (*set_focus_child) (GtkContainer *container,
                    GtkWidget *widget);
    GType (*child_type) (GtkContainer *container);
    gchar* (*composite_name) (GtkContainer *container,
                    GtkWidget *child);
    void (*set_child_property) (GtkContainer *container,
                    GtkWidget *child,
                    guint property_id,
                    GValue *value,
                    GParamSpec *pspec);
    void (*get_child_property) (GtkContainer *container,
                    GtkWidget *child,
                    guint property_id,
                    GValue *value,
                    GParamSpec *pspec);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }



    GType gtk_container_get_type () ;
    void gtk_container_set_border_width (GtkContainer *container,
                        guint border_width);
    guint gtk_container_get_border_width (GtkContainer *container);
    void gtk_container_add (GtkContainer *container,
                        GtkWidget *widget);
    void gtk_container_remove (GtkContainer *container,
                        GtkWidget *widget);

    void gtk_container_set_resize_mode (GtkContainer *container,
                        GtkResizeMode resize_mode);
    GtkResizeMode gtk_container_get_resize_mode (GtkContainer *container);

    void gtk_container_check_resize (GtkContainer *container);

    void gtk_container_foreach (GtkContainer *container,
                    GtkCallback callback,
                    gpointer callback_data);

    void gtk_container_foreach_full (GtkContainer *container,
                    GtkCallback callback,
                    GtkCallbackMarshal marshal,
                    gpointer callback_data,
                    GtkDestroyNotify notify);

    GList* gtk_container_get_children (GtkContainer *container);





    void gtk_container_propagate_expose (GtkContainer *container,
                        GtkWidget *child,
                        GdkEventExpose *event);

    void gtk_container_set_focus_chain (GtkContainer *container,
                        GList *focusable_widgets);
    gboolean gtk_container_get_focus_chain (GtkContainer *container,
                        GList **focusable_widgets);
    void gtk_container_unset_focus_chain (GtkContainer *container);



    void gtk_container_set_reallocate_redraws (GtkContainer *container,
                        gboolean needs_redraws);
    void gtk_container_set_focus_child (GtkContainer *container,
                        GtkWidget *child);
    void gtk_container_set_focus_vadjustment (GtkContainer *container,
                        GtkAdjustment *adjustment);
    GtkAdjustment *gtk_container_get_focus_vadjustment (GtkContainer *container);
    void gtk_container_set_focus_hadjustment (GtkContainer *container,
                        GtkAdjustment *adjustment);
    GtkAdjustment *gtk_container_get_focus_hadjustment (GtkContainer *container);

    void gtk_container_resize_children (GtkContainer *container);

    GType gtk_container_child_type (GtkContainer *container);


    void gtk_container_class_install_child_property (GtkContainerClass *cclass,
                                guint property_id,
                                GParamSpec *pspec);
    GParamSpec* gtk_container_class_find_child_property (GObjectClass *cclass,
                                gchar *property_name);
    GParamSpec** gtk_container_class_list_child_properties (GObjectClass *cclass,
                                guint *n_properties);
    void gtk_container_add_with_properties (GtkContainer *container,
                                GtkWidget *widget,
                                gchar *first_prop_name,
                                ...);
    void gtk_container_child_set (GtkContainer *container,
                                GtkWidget *child,
                                gchar *first_prop_name,
                                ...);
    void gtk_container_child_get (GtkContainer *container,
                                GtkWidget *child,
                                gchar *first_prop_name,
                                ...);
    void gtk_container_child_set_valist (GtkContainer *container,
                                GtkWidget *child,
                                gchar *first_property_name,
                                va_list var_args);
    void gtk_container_child_get_valist (GtkContainer *container,
                                GtkWidget *child,
                                gchar *first_property_name,
                                va_list var_args);
    void gtk_container_child_set_property (GtkContainer *container,
                                GtkWidget *child,
                                gchar *property_name,
                                GValue *value);
    void gtk_container_child_get_property (GtkContainer *container,
                                GtkWidget *child,
                                gchar *property_name,
                                GValue *value);





    void gtk_container_forall (GtkContainer *container,
                        GtkCallback callback,
                        gpointer callback_data);


    void _gtk_container_queue_resize (GtkContainer *container);
    void _gtk_container_clear_resize_widgets (GtkContainer *container);
    gchar* _gtk_container_child_composite_name (GtkContainer *container,
                        GtkWidget *child);
    void _gtk_container_dequeue_resize_handler (GtkContainer *container);
    GList *_gtk_container_focus_sort (GtkContainer *container,
                        GList *children,
                        GtkDirectionType direction,
                        GtkWidget *old_focus);
    alias _GtkBin GtkBin;

    alias _GtkBinClass GtkBinClass;


    struct _GtkBin {
    GtkContainer container;

    GtkWidget *child;
    }

    struct _GtkBinClass {
    GtkContainerClass parent_class;
    }


    GType gtk_bin_get_type () ;

    GtkWidget *gtk_bin_get_child (GtkBin *bin);
    alias _GtkWindow GtkWindow;

    alias _GtkWindowClass GtkWindowClass;

    alias _GtkWindowGeometryInfo GtkWindowGeometryInfo;
    alias void _GtkWindowGeometryInfo;

    alias _GtkWindowGroup GtkWindowGroup;

    alias _GtkWindowGroupClass GtkWindowGroupClass;


    struct _GtkWindow {
    GtkBin bin;

    gchar *title;
    gchar *wmclass_name;
    gchar *wmclass_class;
    gchar *wm_role;

    GtkWidget *focus_widget;
    GtkWidget *default_widget;
    GtkWindow *transient_parent;
    GtkWindowGeometryInfo *geometry_info;
    GdkWindow *frame;
    GtkWindowGroup *group;

    guint16 configure_request_count;
    guint allow_shrink;
    guint allow_grow;
    guint configure_notify_received;






    guint need_default_position;
    guint need_default_size;
    guint position;
    guint type;
    guint has_user_ref_count;
    guint has_focus;

    guint modal;
    guint destroy_with_parent;

    guint has_frame;


    guint iconify_initially;
    guint stick_initially;
    guint maximize_initially;
    guint decorated;

    guint type_hint;
    guint gravity;

    guint is_active;
    guint has_toplevel_focus;

    guint frame_left;
    guint frame_top;
    guint frame_right;
    guint frame_bottom;

    guint keys_changed_handler;

    GdkModifierType mnemonic_modifier;
    GdkScreen *screen;
    }

    struct _GtkWindowClass {
    GtkBinClass parent_class;

    void (* set_focus) (GtkWindow *window,
                GtkWidget *focus);
    gboolean (* frame_event) (GtkWindow *window,
                GdkEvent *event);



    void (* activate_focus) (GtkWindow *window);
    void (* activate_default) (GtkWindow *window);
    void (* move_focus) (GtkWindow *window,
                        GtkDirectionType direction);

    void (*keys_changed) (GtkWindow *window);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }
    struct _GtkWindowGroup {
    GObject parent_instance;

    GSList *grabs;
    }

    struct _GtkWindowGroupClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_window_get_type () ;
    GtkWidget* gtk_window_new (GtkWindowType type);
    void gtk_window_set_title (GtkWindow *window,
                            gchar *title);
    gchar *gtk_window_get_title (GtkWindow *window);
    void gtk_window_set_wmclass (GtkWindow *window,
                            gchar *wmclass_name,
                            gchar *wmclass_class);
    void gtk_window_set_role (GtkWindow *window,
                            gchar *role);
    gchar *gtk_window_get_role (GtkWindow *window);
    void gtk_window_add_accel_group (GtkWindow *window,
                            GtkAccelGroup *accel_group);
    void gtk_window_remove_accel_group (GtkWindow *window,
                            GtkAccelGroup *accel_group);
    void gtk_window_set_position (GtkWindow *window,
                            GtkWindowPosition position);
    gboolean gtk_window_activate_focus (GtkWindow *window);
    void gtk_window_set_focus (GtkWindow *window,
                            GtkWidget *focus);
    GtkWidget *gtk_window_get_focus (GtkWindow *window);
    void gtk_window_set_default (GtkWindow *window,
                            GtkWidget *default_widget);
    gboolean gtk_window_activate_default (GtkWindow *window);

    void gtk_window_set_transient_for (GtkWindow *window,
                            GtkWindow *parent);
    GtkWindow *gtk_window_get_transient_for (GtkWindow *window);
    void gtk_window_set_type_hint (GtkWindow *window,
                            GdkWindowTypeHint hint);
    GdkWindowTypeHint gtk_window_get_type_hint (GtkWindow *window);
    void gtk_window_set_skip_taskbar_hint (GtkWindow *window,
                            gboolean setting);
    gboolean gtk_window_get_skip_taskbar_hint (GtkWindow *window);
    void gtk_window_set_skip_pager_hint (GtkWindow *window,
                            gboolean setting);
    gboolean gtk_window_get_skip_pager_hint (GtkWindow *window);
    void gtk_window_set_accept_focus (GtkWindow *window,
                            gboolean setting);
    gboolean gtk_window_get_accept_focus (GtkWindow *window);
    void gtk_window_set_destroy_with_parent (GtkWindow *window,
                            gboolean setting);
    gboolean gtk_window_get_destroy_with_parent (GtkWindow *window);

    void gtk_window_set_resizable (GtkWindow *window,
                            gboolean resizable);
    gboolean gtk_window_get_resizable (GtkWindow *window);

    void gtk_window_set_gravity (GtkWindow *window,
                            GdkGravity gravity);
    GdkGravity gtk_window_get_gravity (GtkWindow *window);


    void gtk_window_set_geometry_hints (GtkWindow *window,
                            GtkWidget *geometry_widget,
                            GdkGeometry *geometry,
                            GdkWindowHints geom_mask);

    void gtk_window_set_screen (GtkWindow *window,
                            GdkScreen *screen);
    GdkScreen* gtk_window_get_screen (GtkWindow *window);

    gboolean gtk_window_is_active (GtkWindow *window);
    gboolean gtk_window_has_toplevel_focus (GtkWindow *window);




    void gtk_window_set_has_frame (GtkWindow *window,
                            gboolean setting);
    gboolean gtk_window_get_has_frame (GtkWindow *window);
    void gtk_window_set_frame_dimensions (GtkWindow *window,
                            gint left,
                            gint top,
                            gint right,
                            gint bottom);
    void gtk_window_get_frame_dimensions (GtkWindow *window,
                            gint *left,
                            gint *top,
                            gint *right,
                            gint *bottom);
    void gtk_window_set_decorated (GtkWindow *window,
                            gboolean setting);
    gboolean gtk_window_get_decorated (GtkWindow *window);

    void gtk_window_set_icon_list (GtkWindow *window,
                            GList *list);
    GList* gtk_window_get_icon_list (GtkWindow *window);
    void gtk_window_set_icon (GtkWindow *window,
                            GdkPixbuf *icon);
    gboolean gtk_window_set_icon_from_file (GtkWindow *window,
                            gchar *filename,
                            GError **err);
    GdkPixbuf* gtk_window_get_icon (GtkWindow *window);
    void gtk_window_set_default_icon_list (GList *list);
    GList* gtk_window_get_default_icon_list ();
    void gtk_window_set_default_icon (GdkPixbuf *icon);
    gboolean gtk_window_set_default_icon_from_file ( gchar *filename,
                            GError **err);

    void gtk_window_set_auto_startup_notification (gboolean setting);


    void gtk_window_set_modal (GtkWindow *window,
                    gboolean modal);
    gboolean gtk_window_get_modal (GtkWindow *window);
    GList* gtk_window_list_toplevels ();

    void gtk_window_add_mnemonic (GtkWindow *window,
                        guint keyval,
                        GtkWidget *target);
    void gtk_window_remove_mnemonic (GtkWindow *window,
                        guint keyval,
                        GtkWidget *target);
    gboolean gtk_window_mnemonic_activate (GtkWindow *window,
                        guint keyval,
                        GdkModifierType modifier);
    void gtk_window_set_mnemonic_modifier (GtkWindow *window,
                        GdkModifierType modifier);
    GdkModifierType gtk_window_get_mnemonic_modifier (GtkWindow *window);

    gboolean gtk_window_activate_key (GtkWindow *window,
                        GdkEventKey *event);
    gboolean gtk_window_propagate_key_event (GtkWindow *window,
                        GdkEventKey *event);

    void gtk_window_present (GtkWindow *window);
    void gtk_window_iconify (GtkWindow *window);
    void gtk_window_deiconify (GtkWindow *window);
    void gtk_window_stick (GtkWindow *window);
    void gtk_window_unstick (GtkWindow *window);
    void gtk_window_maximize (GtkWindow *window);
    void gtk_window_unmaximize (GtkWindow *window);
    void gtk_window_fullscreen (GtkWindow *window);
    void gtk_window_unfullscreen (GtkWindow *window);
    void gtk_window_set_keep_above (GtkWindow *window, gboolean setting);
    void gtk_window_set_keep_below (GtkWindow *window, gboolean setting);

    void gtk_window_begin_resize_drag (GtkWindow *window,
                    GdkWindowEdge edge,
                    gint button,
                    gint root_x,
                    gint root_y,
                    guint32 timestamp);
    void gtk_window_begin_move_drag (GtkWindow *window,
                    gint button,
                    gint root_x,
                    gint root_y,
                    guint32 timestamp);


    void gtk_window_set_policy (GtkWindow *window,
                            gint allow_shrink,
                            gint allow_grow,
                            gint auto_shrink);






    void gtk_window_set_default_size (GtkWindow *window,
                    gint width,
                    gint height);
    void gtk_window_get_default_size (GtkWindow *window,
                    gint *width,
                    gint *height);
    void gtk_window_resize (GtkWindow *window,
                    gint width,
                    gint height);
    void gtk_window_get_size (GtkWindow *window,
                    gint *width,
                    gint *height);
    void gtk_window_move (GtkWindow *window,
                    gint x,
                    gint y);
    void gtk_window_get_position (GtkWindow *window,
                    gint *root_x,
                    gint *root_y);
    gboolean gtk_window_parse_geometry (GtkWindow *window,
                    gchar *geometry);


    void gtk_window_reshow_with_initial_size (GtkWindow *window);



    GType gtk_window_group_get_type () ;

    GtkWindowGroup * gtk_window_group_new ();
    void gtk_window_group_add_window (GtkWindowGroup *window_group,
                            GtkWindow *window);
    void gtk_window_group_remove_window (GtkWindowGroup *window_group,
                            GtkWindow *window);


    void _gtk_window_internal_set_focus (GtkWindow *window,
                            GtkWidget *focus);
    void gtk_window_remove_embedded_xid (GtkWindow *window,
                            guint xid);
    void gtk_window_add_embedded_xid (GtkWindow *window,
                            guint xid);
    void _gtk_window_reposition (GtkWindow *window,
                            gint x,
                            gint y);
    void _gtk_window_rain_size (GtkWindow *window,
                            gint width,
                            gint height,
                            gint *new_width,
                            gint *new_height);
    GtkWindowGroup *_gtk_window_get_group (GtkWindow *window);

    void _gtk_window_set_has_toplevel_focus (GtkWindow *window,
                            gboolean has_toplevel_focus);
    void _gtk_window_unset_focus_and_default (GtkWindow *window,
                            GtkWidget *widget);

    void _gtk_window_set_is_active (GtkWindow *window,
                            gboolean is_active);

    alias void (*GtkWindowKeysForeachFunc) (GtkWindow *window,
                        guint keyval,
                        GdkModifierType modifiers,
                        gboolean is_mnemonic,
                        gpointer data);

    void _gtk_window_keys_foreach (GtkWindow *window,
                GtkWindowKeysForeachFunc func,
                gpointer func_data);


    gboolean _gtk_window_query_nonaccels (GtkWindow *window,
                            guint accel_key,
                            GdkModifierType accel_mods);
    alias _GtkMenuShell GtkMenuShell;

    alias _GtkMenuShellClass GtkMenuShellClass;


    struct _GtkMenuShell {
    GtkContainer container;

    GList *children;
    GtkWidget *active_menu_item;
    GtkWidget *parent_menu_shell;

    guint button;
    guint32 activate_time;

    guint active;
    guint have_grab;
    guint have_xgrab;
    guint ignore_leave;
    guint menu_flag;
    guint ignore_enter;
    }

    struct _GtkMenuShellClass {
    GtkContainerClass parent_class;

    guint submenu_placement;

    void (*deactivate) (GtkMenuShell *menu_shell);
    void (*selection_done) (GtkMenuShell *menu_shell);

    void (*move_current) (GtkMenuShell *menu_shell,
                GtkMenuDirectionType direction);
    void (*activate_current) (GtkMenuShell *menu_shell,
                gboolean force_hide);
    void (*cancel) (GtkMenuShell *menu_shell);
    void (*select_item) (GtkMenuShell *menu_shell,
                GtkWidget *menu_item);
    void (*insert) (GtkMenuShell *menu_shell,
                GtkWidget *child,
                gint position);
    gint (*get_popup_delay) (GtkMenuShell *menu_shell);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    }


    GType gtk_menu_shell_get_type () ;
    void gtk_menu_shell_append (GtkMenuShell *menu_shell,
                        GtkWidget *child);
    void gtk_menu_shell_prepend (GtkMenuShell *menu_shell,
                        GtkWidget *child);
    void gtk_menu_shell_insert (GtkMenuShell *menu_shell,
                        GtkWidget *child,
                        gint position);
    void gtk_menu_shell_deactivate (GtkMenuShell *menu_shell);
    void gtk_menu_shell_select_item (GtkMenuShell *menu_shell,
                        GtkWidget *menu_item);
    void gtk_menu_shell_deselect (GtkMenuShell *menu_shell);
    void gtk_menu_shell_activate_item (GtkMenuShell *menu_shell,
                        GtkWidget *menu_item,
                        gboolean force_deactivate);
    void gtk_menu_shell_select_first (GtkMenuShell *menu_shell,
                        gboolean search_sensitive);
    void _gtk_menu_shell_select_last (GtkMenuShell *menu_shell,
                        gboolean search_sensitive);
    void _gtk_menu_shell_activate (GtkMenuShell *menu_shell);
    gint _gtk_menu_shell_get_popup_delay (GtkMenuShell *menu_shell);
    void gtk_menu_shell_cancel (GtkMenuShell *menu_shell);
    alias _GtkMenu GtkMenu;

    alias _GtkMenuClass GtkMenuClass;


    alias void (*GtkMenuPositionFunc) (GtkMenu *menu,
                    gint *x,
                    gint *y,
                    gboolean *push_in,
                    gpointer user_data);
    alias void (*GtkMenuDetachFunc) (GtkWidget *attach_widget,
                    GtkMenu *menu);

    struct _GtkMenu {
    GtkMenuShell menu_shell;

    GtkWidget *parent_menu_item;
    GtkWidget *old_active_menu_item;

    GtkAccelGroup *accel_group;
    gchar *accel_path;
    GtkMenuPositionFunc position_func;
    gpointer position_func_data;

    guint toggle_size;




    GtkWidget *toplevel;

    GtkWidget *tearoff_window;
    GtkWidget *tearoff_hbox;
    GtkWidget *tearoff_scrollbar;
    GtkAdjustment *tearoff_adjustment;

    GdkWindow *view_window;
    GdkWindow *bin_window;

    gint scroll_offset;
    gint saved_scroll_offset;
    gint scroll_step;
    guint timeout_id;




    GdkRegion *navigation_region;
    guint navigation_timeout;

    guint torn_off;



    guint tearoff_active;

    guint scroll_fast;

    guint upper_arrow_visible;
    guint lower_arrow_visible;
    guint upper_arrow_prelight;
    guint lower_arrow_prelight;
    }

    struct _GtkMenuClass {
    GtkMenuShellClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_menu_get_type () ;
    GtkWidget* gtk_menu_new ();


    void gtk_menu_popup (GtkMenu *menu,
                        GtkWidget *parent_menu_shell,
                        GtkWidget *parent_menu_item,
                        GtkMenuPositionFunc func,
                        gpointer data,
                        guint button,
                        guint32 activate_time);




    void gtk_menu_reposition (GtkMenu *menu);

    void gtk_menu_popdown (GtkMenu *menu);




    GtkWidget* gtk_menu_get_active (GtkMenu *menu);
    void gtk_menu_set_active (GtkMenu *menu,
                        guint index_);




    void gtk_menu_set_accel_group (GtkMenu *menu,
                        GtkAccelGroup *accel_group);
    GtkAccelGroup* gtk_menu_get_accel_group (GtkMenu *menu);
    void gtk_menu_set_accel_path (GtkMenu *menu,
                        gchar *accel_path);





    void gtk_menu_attach_to_widget (GtkMenu *menu,
                        GtkWidget *attach_widget,
                        GtkMenuDetachFunc detacher);
    void gtk_menu_detach (GtkMenu *menu);





    GtkWidget* gtk_menu_get_attach_widget (GtkMenu *menu);

    void gtk_menu_set_tearoff_state (GtkMenu *menu,
                        gboolean torn_off);
    gboolean gtk_menu_get_tearoff_state (GtkMenu *menu);




    void gtk_menu_set_title (GtkMenu *menu,
                        gchar *title);
    gchar *gtk_menu_get_title (GtkMenu *menu);

    void gtk_menu_reorder_child (GtkMenu *menu,
                        GtkWidget *child,
                        gint position);

    void gtk_menu_set_screen (GtkMenu *menu,
                        GdkScreen *screen);

    void gtk_menu_attach (GtkMenu *menu,
                        GtkWidget *child,
                        guint left_attach,
                        guint right_attach,
                        guint top_attach,
                        guint bottom_attach);

    void gtk_menu_set_monitor (GtkMenu *menu,
                        gint monitor_num);
    alias _GtkLabel GtkLabel;

    alias _GtkLabelClass GtkLabelClass;


    alias _GtkLabelSelectionInfo GtkLabelSelectionInfo;
    alias void _GtkLabelSelectionInfo;


    struct _GtkLabel {
    GtkMisc misc;


    gchar *label;
    guint jtype;
    guint wrap;
    guint use_underline;
    guint use_markup;

    guint mnemonic_keyval;

    gchar *text;
    PangoAttrList *attrs;
    PangoAttrList *effective_attrs;

    PangoLayout *layout;

    GtkWidget *mnemonic_widget;
    GtkWindow *mnemonic_window;

    GtkLabelSelectionInfo *select_info;
    }

    struct _GtkLabelClass {
    GtkMiscClass parent_class;

    void (* move_cursor) (GtkLabel *label,
                GtkMovementStep step,
                gint count,
                gboolean extend_selection);
    void (* copy_clipboard) (GtkLabel *label);


    void (* populate_popup) (GtkLabel *label,
                GtkMenu *menu);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_label_get_type () ;
    GtkWidget* gtk_label_new ( char *str);
    GtkWidget* gtk_label_new_with_mnemonic ( char *str);
    void gtk_label_set_text (GtkLabel *label,
                            char *str);
    gchar* gtk_label_get_text (GtkLabel *label);
    void gtk_label_set_attributes (GtkLabel *label,
                            PangoAttrList *attrs);
    PangoAttrList *gtk_label_get_attributes (GtkLabel *label);
    void gtk_label_set_label (GtkLabel *label,
                            gchar *str);
    gchar *gtk_label_get_label (GtkLabel *label);
    void gtk_label_set_markup (GtkLabel *label,
                            gchar *str);
    void gtk_label_set_use_markup (GtkLabel *label,
                            gboolean setting);
    gboolean gtk_label_get_use_markup (GtkLabel *label);
    void gtk_label_set_use_underline (GtkLabel *label,
                            gboolean setting);
    gboolean gtk_label_get_use_underline (GtkLabel *label);

    void gtk_label_set_markup_with_mnemonic (GtkLabel *label,
                            gchar *str);
    guint gtk_label_get_mnemonic_keyval (GtkLabel *label);
    void gtk_label_set_mnemonic_widget (GtkLabel *label,
                            GtkWidget *widget);
    GtkWidget *gtk_label_get_mnemonic_widget (GtkLabel *label);
    void gtk_label_set_text_with_mnemonic (GtkLabel *label,
                            gchar *str);
    void gtk_label_set_justify (GtkLabel *label,
                            GtkJustification jtype);
    GtkJustification gtk_label_get_justify (GtkLabel *label);
    void gtk_label_set_pattern (GtkLabel *label,
                            gchar *pattern);
    void gtk_label_set_line_wrap (GtkLabel *label,
                            gboolean wrap);
    gboolean gtk_label_get_line_wrap (GtkLabel *label);
    void gtk_label_set_selectable (GtkLabel *label,
                            gboolean setting);
    gboolean gtk_label_get_selectable (GtkLabel *label);
    void gtk_label_select_region (GtkLabel *label,
                            gint start_offset,
                            gint end_offset);
    gboolean gtk_label_get_selection_bounds (GtkLabel *label,
                            gint *start,
                            gint *end);

    PangoLayout *gtk_label_get_layout (GtkLabel *label);
    void gtk_label_get_layout_offsets (GtkLabel *label,
                        gint *x,
                        gint *y);





    void gtk_label_get (GtkLabel *label,
                    char **str);





    guint gtk_label_parse_uline (GtkLabel *label,
                        gchar *string);
    alias _GtkAccelLabel GtkAccelLabel;

    alias _GtkAccelLabelClass GtkAccelLabelClass;


    struct _GtkAccelLabel {
    GtkLabel label;

    guint gtk_reserved;
    guint accel_padding;
    GtkWidget *accel_widget;
    GClosure *accel_closure;
    GtkAccelGroup *accel_group;
    gchar *accel_string;
    guint16 accel_string_width;
    }

    struct _GtkAccelLabelClass {
    GtkLabelClass parent_class;

    gchar *signal_quote1;
    gchar *signal_quote2;
    gchar *mod_name_shift;
    gchar *mod_name_control;
    gchar *mod_name_alt;
    gchar *mod_separator;
    gchar *accel_seperator;
    guint latin1_to_char;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }





    GType gtk_accel_label_get_type () ;
    GtkWidget* gtk_accel_label_new ( gchar *string);
    GtkWidget* gtk_accel_label_get_accel_widget (GtkAccelLabel *accel_label);
    guint gtk_accel_label_get_accel_width (GtkAccelLabel *accel_label);
    void gtk_accel_label_set_accel_widget (GtkAccelLabel *accel_label,
                        GtkWidget *accel_widget);
    void gtk_accel_label_set_accel_closure (GtkAccelLabel *accel_label,
                        GClosure *accel_closure);
    gboolean gtk_accel_label_refetch (GtkAccelLabel *accel_label);

    alias _GtkAccelMap GtkAccelMap;
    alias void _GtkAccelMap;

    alias _GtkAccelMapClass GtkAccelMapClass;
    alias void _GtkAccelMapClass;

    alias void (*GtkAccelMapForeach) (gpointer data,
                            gchar *accel_path,
                            guint accel_key,
                            GdkModifierType accel_mods,
                            gboolean changed);



    void gtk_accel_map_add_entry ( gchar *accel_path,
                        guint accel_key,
                        GdkModifierType accel_mods);
    gboolean gtk_accel_map_lookup_entry ( gchar *accel_path,
                        GtkAccelKey *key);
    gboolean gtk_accel_map_change_entry ( gchar *accel_path,
                        guint accel_key,
                        GdkModifierType accel_mods,
                        gboolean replace);
    void gtk_accel_map_load ( gchar *file_name);
    void gtk_accel_map_save ( gchar *file_name);
    void gtk_accel_map_foreach (gpointer data,
                        GtkAccelMapForeach foreach_func);
    void gtk_accel_map_load_fd (gint fd);
    void gtk_accel_map_load_scanner (GScanner *scanner);
    void gtk_accel_map_save_fd (gint fd);

    void gtk_accel_map_lock_path ( gchar *accel_path);
    void gtk_accel_map_unlock_path ( gchar *accel_path);


    void gtk_accel_map_add_filter ( gchar *filter_pattern);
    void gtk_accel_map_foreach_unfiltered (gpointer data,
                        GtkAccelMapForeach foreach_func);


    GType gtk_accel_map_get_type ();
    GtkAccelMap *gtk_accel_map_get ();



    void _gtk_accel_map_init ();

    void _gtk_accel_map_add_group ( gchar *accel_path,
                            GtkAccelGroup *accel_group);
    void _gtk_accel_map_remove_group ( gchar *accel_path,
                            GtkAccelGroup *accel_group);
    gboolean _gtk_accel_path_is_valid ( gchar *accel_path);



    alias _AtkAction AtkAction;
    alias void _AtkAction;


    alias _AtkActionIface AtkActionIface;


    struct _AtkActionIface {
    GTypeInterface parent;

    gboolean (*do_action) (AtkAction *action,
                            gint i);
    gint (*get_n_actions) (AtkAction *action);
    gchar* (*get_description) (AtkAction *action,
                            gint i);
    gchar* (*get_name) (AtkAction *action,
                            gint i);
    gchar* (*get_keybinding) (AtkAction *action,
                            gint i);
    gboolean (*set_description) (AtkAction *action,
                            gint i,
                            gchar *desc);
    gchar* (*get_localized_name)(AtkAction *action,
                            gint i);
    AtkFunction pad2;
    }

    GType atk_action_get_type ();
    gboolean atk_action_do_action (AtkAction *action,
                        gint i);
    gint atk_action_get_n_actions (AtkAction *action);
    gchar* atk_action_get_description (AtkAction *action,
                            gint i);
    gchar* atk_action_get_name (AtkAction *action,
                            gint i);
    gchar* atk_action_get_keybinding (AtkAction *action,
                            gint i);
    gboolean atk_action_set_description (AtkAction *action,
                            gint i,
                            gchar *desc);



    gchar* atk_action_get_localized_name (AtkAction *action,
                            gint i);
    alias _AtkUtil AtkUtil;

    alias _AtkUtilClass AtkUtilClass;

    alias _AtkKeyEventStruct AtkKeyEventStruct;







    alias void (*AtkEventListener) (AtkObject*);
    alias void (*AtkEventListenerInit) ();
    alias gint (*AtkKeySnoopFunc) (AtkKeyEventStruct *event,
                    gpointer func_data);

    struct _AtkKeyEventStruct {
    gint type;
    guint state;
    guint keyval;
    gint length;
    gchar *string;
    guint16 keycode;
    guint32 timestamp;
    }
    enum AtkKeyEventType {
    ATK_KEY_EVENT_PRESS,
    ATK_KEY_EVENT_RELEASE,
    ATK_KEY_EVENT_LAST_DEFINED
    };


    struct _AtkUtil {
    GObject parent;
    }

    struct _AtkUtilClass {
    GObjectClass parent;
    guint (* add_global_event_listener) (GSignalEmissionHook listener,
                            gchar *event_type);
    void (* remove_global_event_listener) (guint listener_id);
    guint (* add_key_event_listener) (AtkKeySnoopFunc listener,
                            gpointer data);
    void (* remove_key_event_listener) (guint listener_id);
    AtkObject* (* get_root) ();
    gchar* (* get_toolkit_name) ();
    gchar* (* get_toolkit_version) ();
    }
    GType atk_util_get_type ();
    enum AtkCoordType {
    ATK_XY_SCREEN,
    ATK_XY_WINDOW
    };






    guint atk_add_focus_tracker (AtkEventListener focus_tracker);





    void atk_remove_focus_tracker (guint tracker_id);







    void atk_focus_tracker_init (AtkEventListenerInit add_function);





    void atk_focus_tracker_notify (AtkObject *object);





    guint atk_add_global_event_listener (GSignalEmissionHook listener,
                        gchar *event_type);




    void atk_remove_global_event_listener (guint listener_id);





    guint atk_add_key_event_listener (AtkKeySnoopFunc listener, gpointer data);




    void atk_remove_key_event_listener (guint listener_id);




    AtkObject* atk_get_root();

    AtkObject* atk_get_focus_object ();




    gchar *atk_get_toolkit_name ();




    gchar *atk_get_toolkit_version ();
    alias _AtkComponent AtkComponent;
    alias void _AtkComponent;


    alias _AtkComponentIface AtkComponentIface;


    alias void (*AtkFocusHandler) (AtkObject*, gboolean);


    struct _AtkComponentIface {
    GTypeInterface parent;

    guint (* add_focus_handler) (AtkComponent *component,
                        AtkFocusHandler handler);

    gboolean (* contains) (AtkComponent *component,
                        gint x,
                        gint y,
                        AtkCoordType coord_type);

    AtkObject* (* ref_accessible_at_point) (AtkComponent *component,
                        gint x,
                        gint y,
                        AtkCoordType coord_type);
    void (* get_extents) (AtkComponent *component,
                        gint *x,
                        gint *y,
                        gint *width,
                        gint *height,
                        AtkCoordType coord_type);
    void (* get_position) (AtkComponent *component,
                            gint *x,
                            gint *y,
                            AtkCoordType coord_type);
    void (* get_size) (AtkComponent *component,
                                gint *width,
                                gint *height);
    gboolean (* grab_focus) (AtkComponent *component);
    void (* remove_focus_handler) (AtkComponent *component,
                                guint handler_id);
    gboolean (* set_extents) (AtkComponent *component,
                            gint x,
                            gint y,
                            gint width,
                            gint height,
                            AtkCoordType coord_type);
    gboolean (* set_position) (AtkComponent *component,
                            gint x,
                            gint y,
                            AtkCoordType coord_type);
    gboolean (* set_size) (AtkComponent *component,
                            gint width,
                            gint height);

    AtkLayer (* get_layer) (AtkComponent *component);
    gint (* get_mdi_zorder) (AtkComponent *component);

    AtkFunction pad1;
    AtkFunction pad2;
    }

    GType atk_component_get_type ();



    guint atk_component_add_focus_handler (AtkComponent *component,
                                AtkFocusHandler handler);
    gboolean atk_component_contains (AtkComponent *component,
                                gint x,
                                gint y,
                                AtkCoordType coord_type);
    AtkObject* atk_component_ref_accessible_at_point(AtkComponent *component,
                                gint x,
                                gint y,
                                AtkCoordType coord_type);
    void atk_component_get_extents (AtkComponent *component,
                                gint *x,
                                gint *y,
                                gint *width,
                                gint *height,
                                AtkCoordType coord_type);
    void atk_component_get_position (AtkComponent *component,
                                gint *x,
                                gint *y,
                                AtkCoordType coord_type);
    void atk_component_get_size (AtkComponent *component,
                                gint *width,
                                gint *height);
    AtkLayer atk_component_get_layer (AtkComponent *component);
    gint atk_component_get_mdi_zorder (AtkComponent *component);
    gboolean atk_component_grab_focus (AtkComponent *component);
    void atk_component_remove_focus_handler (AtkComponent *component,
                                guint handler_id);
    gboolean atk_component_set_extents (AtkComponent *component,
                                gint x,
                                gint y,
                                gint width,
                                gint height,
                                AtkCoordType coord_type);
    gboolean atk_component_set_position (AtkComponent *component,
                                gint x,
                                gint y,
                                AtkCoordType coord_type);
    gboolean atk_component_set_size (AtkComponent *component,
                                gint width,
                                gint height);
    alias _AtkDocument AtkDocument;
    alias void _AtkDocument;


    alias _AtkDocumentIface AtkDocumentIface;


    struct _AtkDocumentIface {
    GTypeInterface parent;
    gchar* ( *get_document_type) (AtkDocument *document);
    gpointer ( *get_document) (AtkDocument *document);

    AtkFunction pad1;
    AtkFunction pad2;
    AtkFunction pad3;
    AtkFunction pad4;
    AtkFunction pad5;
    AtkFunction pad6;
    AtkFunction pad7;
    AtkFunction pad8;
    }

    GType atk_document_get_type ();

    gchar* atk_document_get_document_type (AtkDocument *document);
    gpointer atk_document_get_document (AtkDocument *document);
    alias GSList AtkAttributeSet;
    alias _AtkAttribute AtkAttribute;


    struct _AtkAttribute {
    gchar* name;
    gchar* value;
    }
    enum AtkTextAttribute {
    ATK_TEXT_ATTR_INVALID = 0,
    ATK_TEXT_ATTR_LEFT_MARGIN,
    ATK_TEXT_ATTR_RIGHT_MARGIN,
    ATK_TEXT_ATTR_INDENT,
    ATK_TEXT_ATTR_INVISIBLE,
    ATK_TEXT_ATTR_EDITABLE,
    ATK_TEXT_ATTR_PIXELS_ABOVE_LINES,
    ATK_TEXT_ATTR_PIXELS_BELOW_LINES,
    ATK_TEXT_ATTR_PIXELS_INSIDE_WRAP,
    ATK_TEXT_ATTR_BG_FULL_HEIGHT,
    ATK_TEXT_ATTR_RISE,
    ATK_TEXT_ATTR_UNDERLINE,
    ATK_TEXT_ATTR_STRIKETHROUGH,
    ATK_TEXT_ATTR_SIZE,
    ATK_TEXT_ATTR_SCALE,
    ATK_TEXT_ATTR_WEIGHT,
    ATK_TEXT_ATTR_LANGUAGE,
    ATK_TEXT_ATTR_FAMILY_NAME,
    ATK_TEXT_ATTR_BG_COLOR,
    ATK_TEXT_ATTR_FG_COLOR,
    ATK_TEXT_ATTR_BG_STIPPLE,
    ATK_TEXT_ATTR_FG_STIPPLE,
    ATK_TEXT_ATTR_WRAP_MODE,
    ATK_TEXT_ATTR_DIRECTION,
    ATK_TEXT_ATTR_JUSTIFICATION,
    ATK_TEXT_ATTR_STRETCH,
    ATK_TEXT_ATTR_VARIANT,
    ATK_TEXT_ATTR_STYLE,
    ATK_TEXT_ATTR_LAST_DEFINED
    };


    AtkTextAttribute atk_text_attribute_register ( gchar *name);
    alias _AtkText AtkText;
    alias void _AtkText;


    alias _AtkTextIface AtkTextIface;

    enum AtkTextBoundary {
    ATK_TEXT_BOUNDARY_CHAR,
    ATK_TEXT_BOUNDARY_WORD_START,
    ATK_TEXT_BOUNDARY_WORD_END,
    ATK_TEXT_BOUNDARY_SENTENCE_START,
    ATK_TEXT_BOUNDARY_SENTENCE_END,
    ATK_TEXT_BOUNDARY_LINE_START,
    ATK_TEXT_BOUNDARY_LINE_END
    };

    alias _AtkTextRectangle AtkTextRectangle;


    struct _AtkTextRectangle {
    gint x;
    gint y;
    gint width;
    gint height;
    }
    alias _AtkTextRange AtkTextRange;


    struct _AtkTextRange {
    AtkTextRectangle bounds;
    gint start_offset;
    gint end_offset;
    gchar* content;
    }
    enum AtkTextClipType {
    ATK_TEXT_CLIP_NONE,
    ATK_TEXT_CLIP_MIN,
    ATK_TEXT_CLIP_MAX,
    ATK_TEXT_CLIP_BOTH
    };


    struct _AtkTextIface {
    GTypeInterface parent;

    gchar* (* get_text) (AtkText *text,
                            gint start_offset,
                            gint end_offset);
    gchar* (* get_text_after_offset) (AtkText *text,
                            gint offset,
                            AtkTextBoundary boundary_type,
                            gint *start_offset,
                            gint *end_offset);
    gchar* (* get_text_at_offset) (AtkText *text,
                            gint offset,
                            AtkTextBoundary boundary_type,
                            gint *start_offset,
                            gint *end_offset);
    gunichar (* get_character_at_offset) (AtkText *text,
                            gint offset);
    gchar* (* get_text_before_offset) (AtkText *text,
                            gint offset,
                            AtkTextBoundary boundary_type,
                            gint *start_offset,
                            gint *end_offset);
    gint (* get_caret_offset) (AtkText *text);
    AtkAttributeSet* (* get_run_attributes) (AtkText *text,
                            gint offset,
                            gint *start_offset,
                            gint *end_offset);
    AtkAttributeSet* (* get_default_attributes) (AtkText *text);
    void (* get_character_extents) (AtkText *text,
                            gint offset,
                            gint *x,
                            gint *y,
                            gint *width,
                            gint *height,
                            AtkCoordType coords);
    gint (* get_character_count) (AtkText *text);
    gint (* get_offset_at_point) (AtkText *text,
                            gint x,
                            gint y,
                            AtkCoordType coords);
    gint (* get_n_selections) (AtkText *text);
    gchar* (* get_selection) (AtkText *text,
                            gint selection_num,
                            gint *start_offset,
                            gint *end_offset);
    gboolean (* add_selection) (AtkText *text,
                            gint start_offset,
                            gint end_offset);
    gboolean (* remove_selection) (AtkText *text,
                            gint selection_num);
    gboolean (* set_selection) (AtkText *text,
                            gint selection_num,
                            gint start_offset,
                            gint end_offset);
    gboolean (* set_caret_offset) (AtkText *text,
                            gint offset);




    void (* text_changed) (AtkText *text,
                            gint position,
                            gint length);
    void (* text_caret_moved) (AtkText *text,
                            gint location);
    void (* text_selection_changed) (AtkText *text);

    void (* text_attributes_changed) (AtkText *text);


    void (* get_range_extents) (AtkText *text,
                            gint start_offset,
                            gint end_offset,
                            AtkCoordType coord_type,
                            AtkTextRectangle *rect);

    AtkTextRange** (* get_bounded_ranges) (AtkText *text,
                            AtkTextRectangle *rect,
                            AtkCoordType coord_type,
                            AtkTextClipType x_clip_type,
                            AtkTextClipType y_clip_type);


    AtkFunction pad4;
    }

    GType atk_text_get_type ();
    gchar* atk_text_get_text (AtkText *text,
                                gint start_offset,
                                gint end_offset);
    gunichar atk_text_get_character_at_offset (AtkText *text,
                                gint offset);
    gchar* atk_text_get_text_after_offset (AtkText *text,
                                gint offset,
                                AtkTextBoundary boundary_type,
                                gint *start_offset,
                                gint *end_offset);
    gchar* atk_text_get_text_at_offset (AtkText *text,
                                gint offset,
                                AtkTextBoundary boundary_type,
                                gint *start_offset,
                                gint *end_offset);
    gchar* atk_text_get_text_before_offset (AtkText *text,
                                gint offset,
                                AtkTextBoundary boundary_type,
                                gint *start_offset,
                                gint *end_offset);
    gint atk_text_get_caret_offset (AtkText *text);
    void atk_text_get_character_extents (AtkText *text,
                                gint offset,
                                gint *x,
                                gint *y,
                                gint *width,
                                gint *height,
                                AtkCoordType coords);
    AtkAttributeSet* atk_text_get_run_attributes (AtkText *text,
                                gint offset,
                                gint *start_offset,
                                gint *end_offset);
    AtkAttributeSet* atk_text_get_default_attributes (AtkText *text);
    gint atk_text_get_character_count (AtkText *text);
    gint atk_text_get_offset_at_point (AtkText *text,
                                gint x,
                                gint y,
                                AtkCoordType coords);
    gint atk_text_get_n_selections (AtkText *text);
    gchar* atk_text_get_selection (AtkText *text,
                                gint selection_num,
                                gint *start_offset,
                                gint *end_offset);
    gboolean atk_text_add_selection (AtkText *text,
                                gint start_offset,
                                gint end_offset);
    gboolean atk_text_remove_selection (AtkText *text,
                                gint selection_num);
    gboolean atk_text_set_selection (AtkText *text,
                                gint selection_num,
                                gint start_offset,
                                gint end_offset);
    gboolean atk_text_set_caret_offset (AtkText *text,
                                gint offset);
    void atk_text_get_range_extents (AtkText *text,

                                gint start_offset,
                                gint end_offset,
                                AtkCoordType coord_type,
                                AtkTextRectangle *rect);
    AtkTextRange** atk_text_get_bounded_ranges (AtkText *text,
                                AtkTextRectangle *rect,
                                AtkCoordType coord_type,
                                AtkTextClipType x_clip_type,
                                AtkTextClipType y_clip_type);
    void atk_text_free_ranges (AtkTextRange **ranges);
    void atk_attribute_set_free (AtkAttributeSet *attrib_set);
    gchar* atk_text_attribute_get_name (AtkTextAttribute attr);
    AtkTextAttribute atk_text_attribute_for_name ( gchar *name);
    gchar* atk_text_attribute_get_value (AtkTextAttribute attr,
                                gint index_);
    alias _AtkEditableText AtkEditableText;
    alias void _AtkEditableText;


    alias _AtkEditableTextIface AtkEditableTextIface;


    struct _AtkEditableTextIface {
    GTypeInterface parent_interface;

    gboolean (* set_run_attributes) (AtkEditableText *text,
                    AtkAttributeSet *attrib_set,
                    gint start_offset,
                    gint end_offset);
    void (* set_text_contents) (AtkEditableText *text,
                    gchar *string);
    void (* insert_text) (AtkEditableText *text,
                    gchar *string,
                    gint length,
                    gint *position);
    void (* copy_text) (AtkEditableText *text,
                    gint start_pos,
                    gint end_pos);
    void (* cut_text) (AtkEditableText *text,
                    gint start_pos,
                    gint end_pos);
    void (* delete_text) (AtkEditableText *text,
                    gint start_pos,
                    gint end_pos);
    void (* paste_text) (AtkEditableText *text,
                    gint position);

    AtkFunction pad1;
    AtkFunction pad2;
    }
    GType atk_editable_text_get_type ();


    gboolean atk_editable_text_set_run_attributes (AtkEditableText *text,
                        AtkAttributeSet *attrib_set,
                        gint start_offset,
                        gint end_offset);
    void atk_editable_text_set_text_contents (AtkEditableText *text,
                        gchar *string);
    void atk_editable_text_insert_text (AtkEditableText *text,
                        gchar *string,
                        gint length,
                        gint *position);
    void atk_editable_text_copy_text (AtkEditableText *text,
                        gint start_pos,
                        gint end_pos);
    void atk_editable_text_cut_text (AtkEditableText *text,
                        gint start_pos,
                        gint end_pos);
    void atk_editable_text_delete_text (AtkEditableText *text,
                        gint start_pos,
                        gint end_pos);
    void atk_editable_text_paste_text (AtkEditableText *text,
                        gint position);
    alias _AtkGObjectAccessible AtkGObjectAccessible;

    alias _AtkGObjectAccessibleClass AtkGObjectAccessibleClass;


    struct _AtkGObjectAccessible {
    AtkObject parent;
    }

    GType atk_gobject_accessible_get_type ();

    struct _AtkGObjectAccessibleClass {
    AtkObjectClass parent_class;

    AtkFunction pad1;
    AtkFunction pad2;
    }

    AtkObject *atk_gobject_accessible_for_object (GObject *obj);
    GObject *atk_gobject_accessible_get_object (AtkGObjectAccessible *obj);
    enum AtkHyperlinkStateFlags {
    ATK_HYPERLINK_IS_INLINE = 1 << 0
    };

    alias _AtkHyperlink AtkHyperlink;

    alias _AtkHyperlinkClass AtkHyperlinkClass;


    struct _AtkHyperlink {
    GObject parent;
    }

    struct _AtkHyperlinkClass {
    GObjectClass parent;

    gchar* (* get_uri) (AtkHyperlink *link_,
                        gint i);
    AtkObject* (* get_object) (AtkHyperlink *link_,
                        gint i);
    gint (* get_end_index) (AtkHyperlink *link_);
    gint (* get_start_index) (AtkHyperlink *link_);
    gboolean (* is_valid) (AtkHyperlink *link_);
    gint (* get_n_anchors) (AtkHyperlink *link_);
    guint (* link_state) (AtkHyperlink *link_);
    gboolean (* is_selected_link) (AtkHyperlink *link_);


    void ( *link_activated) (AtkHyperlink *link_);
    AtkFunction pad1;
    }

    GType atk_hyperlink_get_type ();

    gchar* atk_hyperlink_get_uri (AtkHyperlink *link_,
                            gint i);

    AtkObject* atk_hyperlink_get_object (AtkHyperlink *link_,
                            gint i);

    gint atk_hyperlink_get_end_index (AtkHyperlink *link_);

    gint atk_hyperlink_get_start_index (AtkHyperlink *link_);

    gboolean atk_hyperlink_is_valid (AtkHyperlink *link_);

    gboolean atk_hyperlink_is_inline (AtkHyperlink *link_);

    gint atk_hyperlink_get_n_anchors (AtkHyperlink *link_);
    gboolean atk_hyperlink_is_selected_link (AtkHyperlink *link_);
    alias _AtkHypertext AtkHypertext;
    alias void _AtkHypertext;


    alias _AtkHypertextIface AtkHypertextIface;


    struct _AtkHypertextIface {
    GTypeInterface parent;

    AtkHyperlink*(* get_link) (AtkHypertext *hypertext,
                        gint link_index);
    gint (* get_n_links) (AtkHypertext *hypertext);
    gint (* get_link_index) (AtkHypertext *hypertext,
                        gint char_index);




    void (* link_selected) (AtkHypertext *hypertext,
                        gint link_index);

    AtkFunction pad1;
    AtkFunction pad2;
    AtkFunction pad3;
    }
    GType atk_hypertext_get_type ();

    AtkHyperlink* atk_hypertext_get_link (AtkHypertext *hypertext,
                        gint link_index);
    gint atk_hypertext_get_n_links (AtkHypertext *hypertext);
    gint atk_hypertext_get_link_index (AtkHypertext *hypertext,
                        gint char_index);
    alias _AtkImage AtkImage;
    alias void _AtkImage;


    alias _AtkImageIface AtkImageIface;


    struct _AtkImageIface {
    GTypeInterface parent;
    void ( *get_image_position) (AtkImage *image,
                            gint *x,
                            gint *y,
                            AtkCoordType coord_type);
    gchar* ( *get_image_description) (AtkImage *image);
    void ( *get_image_size) (AtkImage *image,
                            gint *width,
                            gint *height);
    gboolean ( *set_image_description) (AtkImage *image,
                            gchar *description);

    AtkFunction pad1;
    AtkFunction pad2;
    }

    GType atk_image_get_type ();

    gchar* atk_image_get_image_description (AtkImage *image);

    void atk_image_get_image_size (AtkImage *image,
                        gint *width,
                        gint *height);

    gboolean atk_image_set_image_description (AtkImage *image,
                        gchar *description);
    void atk_image_get_image_position (AtkImage *image,
                        gint *x,
                        gint *y,
                        AtkCoordType coord_type);

    alias _AtkNoOpObject AtkNoOpObject;

    alias _AtkNoOpObjectClass AtkNoOpObjectClass;


    struct _AtkNoOpObject {
    AtkObject parent;
    }

    GType atk_no_op_object_get_type ();

    struct _AtkNoOpObjectClass {
    AtkObjectClass parent_class;
    }

    AtkObject *atk_no_op_object_new (GObject *obj);


    alias _AtkObjectFactory AtkObjectFactory;

    alias _AtkObjectFactoryClass AtkObjectFactoryClass;


    struct _AtkObjectFactory {
    GObject parent;
    }

    struct _AtkObjectFactoryClass {
    GObjectClass parent_class;

    AtkObject* (* create_accessible) (GObject *obj);
    void (* invalidate) (AtkObjectFactory *factory);
    GType (* get_accessible_type) ();

    AtkFunction pad1;
    AtkFunction pad2;
    }

    GType atk_object_factory_get_type();

    AtkObject* atk_object_factory_create_accessible (AtkObjectFactory *factory, GObject *obj);
    void atk_object_factory_invalidate (AtkObjectFactory *factory);
    GType atk_object_factory_get_accessible_type (AtkObjectFactory *factory);
    alias _AtkNoOpObjectFactory AtkNoOpObjectFactory;

    alias _AtkNoOpObjectFactoryClass AtkNoOpObjectFactoryClass;


    struct _AtkNoOpObjectFactory {
    AtkObjectFactory parent;
    }

    struct _AtkNoOpObjectFactoryClass {
    AtkObjectFactoryClass parent_class;
    }

    GType atk_no_op_object_factory_get_type();

    AtkObjectFactory *atk_no_op_object_factory_new();

    struct _AtkRegistry {
    GObject parent;
    GHashTable *factory_type_registry;
    GHashTable *factory_singleton_cache;
    }

    struct _AtkRegistryClass {
    GObjectClass parent_class;
    }

    alias _AtkRegistry AtkRegistry;

    alias _AtkRegistryClass AtkRegistryClass;



    GType atk_registry_get_type ();
    void atk_registry_set_factory_type (AtkRegistry *registry,
                            GType type,
                            GType factory_type);
    GType atk_registry_get_factory_type (AtkRegistry *registry,
                            GType type);
    AtkObjectFactory* atk_registry_get_factory (AtkRegistry *registry,
                            GType type);

    AtkRegistry* atk_get_default_registry ();
    alias _AtkRelation AtkRelation;

    alias _AtkRelationClass AtkRelationClass;


    struct _AtkRelation {
    GObject parent;

    GPtrArray *target;
    AtkRelationType relationship;
    }

    struct _AtkRelationClass {
    GObjectClass parent;
    }

    GType atk_relation_get_type ();

    AtkRelationType atk_relation_type_register ( gchar *name);
    gchar* atk_relation_type_get_name (AtkRelationType type);
    AtkRelationType atk_relation_type_for_name ( gchar *name);





    AtkRelation* atk_relation_new (AtkObject **targets,
                            gint n_targets,
                            AtkRelationType relationship);



    AtkRelationType atk_relation_get_relation_type (AtkRelation *relation);



    GPtrArray* atk_relation_get_target (AtkRelation *relation);
    alias _AtkRelationSetClass AtkRelationSetClass;



    struct _AtkRelationSet {
    GObject parent;

    GPtrArray *relations;
    }

    struct _AtkRelationSetClass {
    GObjectClass parent;

    AtkFunction pad1;
    AtkFunction pad2;
    }

    GType atk_relation_set_get_type ();

    AtkRelationSet* atk_relation_set_new ();
    gboolean atk_relation_set_contains (AtkRelationSet *set,
                            AtkRelationType relationship);
    void atk_relation_set_remove (AtkRelationSet *set,
                            AtkRelation *relation);
    void atk_relation_set_add (AtkRelationSet *set,
                            AtkRelation *relation);
    gint atk_relation_set_get_n_relations (AtkRelationSet *set);
    AtkRelation* atk_relation_set_get_relation (AtkRelationSet *set,
                            gint i);
    AtkRelation* atk_relation_set_get_relation_by_type (AtkRelationSet *set,
                            AtkRelationType relationship);

    alias _AtkSelection AtkSelection;
    alias void _AtkSelection;


    alias _AtkSelectionIface AtkSelectionIface;


    struct _AtkSelectionIface {
    GTypeInterface parent;

    gboolean (* add_selection) (AtkSelection *selection,
                        gint i);
    gboolean (* clear_selection) (AtkSelection *selection);
    AtkObject* (* ref_selection) (AtkSelection *selection,
                        gint i);
    gint (* get_selection_count) (AtkSelection *selection);
    gboolean (* is_child_selected) (AtkSelection *selection,
                        gint i);
    gboolean (* remove_selection) (AtkSelection *selection,
                        gint i);
    gboolean (* select_all_selection) (AtkSelection *selection);



    void (*selection_changed) (AtkSelection *selection);

    AtkFunction pad1;
    AtkFunction pad2;
    }

    GType atk_selection_get_type ();

    gboolean atk_selection_add_selection (AtkSelection *selection,
                            gint i);

    gboolean atk_selection_clear_selection (AtkSelection *selection);

    AtkObject* atk_selection_ref_selection (AtkSelection *selection,
                            gint i);

    gint atk_selection_get_selection_count (AtkSelection *selection);

    gboolean atk_selection_is_child_selected (AtkSelection *selection,
                            gint i);

    gboolean atk_selection_remove_selection (AtkSelection *selection,
                            gint i);

    gboolean atk_selection_select_all_selection (AtkSelection *selection);

    alias _AtkStateSetClass AtkStateSetClass;



    struct _AtkStateSet {
    GObject parent;

    }

    struct _AtkStateSetClass {
    GObjectClass parent;
    }

    GType atk_state_set_get_type ();

    AtkStateSet* atk_state_set_new ();
    gboolean atk_state_set_is_empty (AtkStateSet *set);
    gboolean atk_state_set_add_state (AtkStateSet *set,
                            AtkStateType type);
    void atk_state_set_add_states (AtkStateSet *set,
                            AtkStateType *types,
                            gint n_types);
    void atk_state_set_clear_states (AtkStateSet *set);
    gboolean atk_state_set_contains_state (AtkStateSet *set,
                            AtkStateType type);
    gboolean atk_state_set_contains_states (AtkStateSet *set,
                            AtkStateType *types,
                            gint n_types);
    gboolean atk_state_set_remove_state (AtkStateSet *set,
                            AtkStateType type);
    AtkStateSet* atk_state_set_and_sets (AtkStateSet *set,
                            AtkStateSet *compare_set);
    AtkStateSet* atk_state_set_or_sets (AtkStateSet *set,
                            AtkStateSet *compare_set);
    AtkStateSet* atk_state_set_xor_sets (AtkStateSet *set,
                            AtkStateSet *compare_set);
    alias _AtkStreamableContent AtkStreamableContent;
    alias void _AtkStreamableContent;


    alias _AtkStreamableContentIface AtkStreamableContentIface;


    struct _AtkStreamableContentIface {
    GTypeInterface parent;




    gint (* get_n_mime_types) (AtkStreamableContent *streamable);
    gchar* (* get_mime_type) (AtkStreamableContent *streamable,
                            gint i);






    GIOChannel* (* get_stream) (AtkStreamableContent *streamable,
                            gchar *mime_type);

    AtkFunction pad1;
    AtkFunction pad2;
    AtkFunction pad3;
    AtkFunction pad4;
    }
    GType atk_streamable_content_get_type ();

    gint atk_streamable_content_get_n_mime_types (AtkStreamableContent *streamable);

    gchar* atk_streamable_content_get_mime_type (AtkStreamableContent *streamable,
                                    gint i);
    GIOChannel* atk_streamable_content_get_stream (AtkStreamableContent *streamable,
                                    gchar *mime_type);
    alias _AtkTable AtkTable;
    alias void _AtkTable;


    alias _AtkTableIface AtkTableIface;


    struct _AtkTableIface {
    GTypeInterface parent;

    AtkObject* (* ref_at) (AtkTable *table,
                            gint row,
                            gint column);
    gint (* get_index_at) (AtkTable *table,
                            gint row,
                            gint column);
    gint (* get_column_at_index) (AtkTable *table,
                            gint index_);
    gint (* get_row_at_index) (AtkTable *table,
                            gint index_);
    gint (* get_n_columns) (AtkTable *table);
    gint (* get_n_rows) (AtkTable *table);
    gint (* get_column_extent_at) (AtkTable *table,
                            gint row,
                            gint column);
    gint (* get_row_extent_at) (AtkTable *table,
                            gint row,
                            gint column);
    AtkObject*
            (* get_caption) (AtkTable *table);
    gchar*
            (* get_column_description) (AtkTable *table,
                            gint column);
    AtkObject* (* get_column_header) (AtkTable *table,
                            gint column);
    gchar*
            (* get_row_description) (AtkTable *table,
                            gint row);
    AtkObject* (* get_row_header) (AtkTable *table,
                            gint row);
    AtkObject* (* get_summary) (AtkTable *table);
    void (* set_caption) (AtkTable *table,
                            AtkObject *caption);
    void (* set_column_description) (AtkTable *table,
                            gint column,
                            gchar *description);
    void (* set_column_header) (AtkTable *table,
                            gint column,
                            AtkObject *header);
    void (* set_row_description) (AtkTable *table,
                            gint row,
                            gchar *description);
    void (* set_row_header) (AtkTable *table,
                            gint row,
                            AtkObject *header);
    void (* set_summary) (AtkTable *table,
                            AtkObject *accessible);
    gint (* get_selected_columns) (AtkTable *table,
                            gint **selected);
    gint (* get_selected_rows) (AtkTable *table,
                            gint **selected);
    gboolean (* is_column_selected) (AtkTable *table,
                            gint column);
    gboolean (* is_row_selected) (AtkTable *table,
                            gint row);
    gboolean (* is_selected) (AtkTable *table,
                            gint row,
                            gint column);
    gboolean (* add_row_selection) (AtkTable *table,
                            gint row);
    gboolean (* remove_row_selection) (AtkTable *table,
                            gint row);
    gboolean (* add_column_selection) (AtkTable *table,
                            gint column);
    gboolean (* remove_column_selection) (AtkTable *table,
                            gint column);




    void (* row_inserted) (AtkTable *table,
                            gint row,
                            gint num_inserted);
    void (* column_inserted) (AtkTable *table,
                            gint column,
                            gint num_inserted);
    void (* row_deleted) (AtkTable *table,
                            gint row,
                            gint num_deleted);
    void (* column_deleted) (AtkTable *table,
                            gint column,
                            gint num_deleted);
    void (* row_reordered) (AtkTable *table);
    void (* column_reordered) (AtkTable *table);
    void (* model_changed) (AtkTable *table);

    AtkFunction pad1;
    AtkFunction pad2;
    AtkFunction pad3;
    AtkFunction pad4;
    }

    GType atk_table_get_type ();

    AtkObject* atk_table_ref_at (AtkTable *table,
                            gint row,
                            gint column);
    gint atk_table_get_index_at (AtkTable *table,
                            gint row,
                            gint column);
    gint atk_table_get_column_at_index (AtkTable *table,
                            gint index_);
    gint atk_table_get_row_at_index (AtkTable *table,
                            gint index_);
    gint atk_table_get_n_columns (AtkTable *table);
    gint atk_table_get_n_rows (AtkTable *table);
    gint atk_table_get_column_extent_at (AtkTable *table,
                            gint row,
                            gint column);
    gint atk_table_get_row_extent_at (AtkTable *table,
                            gint row,
                            gint column);
    AtkObject*
            atk_table_get_caption (AtkTable *table);
    gchar*
            atk_table_get_column_description (AtkTable *table,
                            gint column);
    AtkObject* atk_table_get_column_header (AtkTable *table,
                            gint column);
    gchar*
            atk_table_get_row_description (AtkTable *table,
                            gint row);
    AtkObject* atk_table_get_row_header (AtkTable *table,
                            gint row);
    AtkObject* atk_table_get_summary (AtkTable *table);
    void atk_table_set_caption (AtkTable *table,
                            AtkObject *caption);
    void atk_table_set_column_description
                            (AtkTable *table,
                            gint column,
                            gchar *description);
    void atk_table_set_column_header (AtkTable *table,
                            gint column,
                            AtkObject *header);
    void atk_table_set_row_description (AtkTable *table,
                            gint row,
                            gchar *description);
    void atk_table_set_row_header (AtkTable *table,
                            gint row,
                            AtkObject *header);
    void atk_table_set_summary (AtkTable *table,
                            AtkObject *accessible);
    gint atk_table_get_selected_columns (AtkTable *table,
                            gint **selected);
    gint atk_table_get_selected_rows (AtkTable *table,
                            gint **selected);
    gboolean atk_table_is_column_selected (AtkTable *table,
                            gint column);
    gboolean atk_table_is_row_selected (AtkTable *table,
                            gint row);
    gboolean atk_table_is_selected (AtkTable *table,
                            gint row,
                            gint column);
    gboolean atk_table_add_row_selection (AtkTable *table,
                            gint row);
    gboolean atk_table_remove_row_selection (AtkTable *table,
                            gint row);
    gboolean atk_table_add_column_selection (AtkTable *table,
                            gint column);
    gboolean atk_table_remove_column_selection
                            (AtkTable *table,
                            gint column);


    alias _AtkValue AtkValue;
    alias void _AtkValue;


    alias _AtkValueIface AtkValueIface;


    struct _AtkValueIface {
    GTypeInterface parent;

    void (* get_current_value) (AtkValue *obj,
                    GValue *value);
    void (* get_maximum_value) (AtkValue *obj,
                    GValue *value);
    void (* get_minimum_value) (AtkValue *obj,
                    GValue *value);
    gboolean (* set_current_value) (AtkValue *obj,
                    GValue *value);

    AtkFunction pad1;
    AtkFunction pad2;
    }

    GType atk_value_get_type ();

    void atk_value_get_current_value (AtkValue *obj,
                    GValue *value);


    void atk_value_get_maximum_value (AtkValue *obj,
                    GValue *value);

    void atk_value_get_minimum_value (AtkValue *obj,
                    GValue *value);

    gboolean atk_value_set_current_value (AtkValue *obj,
                        GValue *value);
    alias _GtkAccessible GtkAccessible;

    alias _GtkAccessibleClass GtkAccessibleClass;






    struct _GtkAccessible {
    AtkObject parent;





    GtkWidget *widget;
    }

    struct _GtkAccessibleClass {
    AtkObjectClass parent_class;

    void (*connect_widget_destroyed) (GtkAccessible *accessible);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_accessible_get_type ();

    void gtk_accessible_connect_widget_destroyed (GtkAccessible *accessible);

    alias _GtkAction GtkAction;

    alias _GtkActionClass GtkActionClass;

    alias _GtkActionPrivate GtkActionPrivate;
    alias void _GtkActionPrivate;


    struct _GtkAction {
    GObject object;



    GtkActionPrivate *private_data;
    }

    struct _GtkActionClass {
    GObjectClass parent_class;


    void (* activate) (GtkAction *action);

    GType menu_item_type;
    GType toolbar_item_type;


    GtkWidget *(* create_menu_item) (GtkAction *action);
    GtkWidget *(* create_tool_item) (GtkAction *action);
    void (* connect_proxy) (GtkAction *action,
                    GtkWidget *proxy);
    void (* disconnect_proxy) (GtkAction *action,
                    GtkWidget *proxy);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_action_get_type ();
    GtkAction *gtk_action_new ( gchar *name,
                            gchar *label,
                            gchar *tooltip,
                            gchar *stock_id);
    gchar* gtk_action_get_name (GtkAction *action);
    gboolean gtk_action_is_sensitive (GtkAction *action);
    gboolean gtk_action_get_sensitive (GtkAction *action);
    gboolean gtk_action_is_visible (GtkAction *action);
    gboolean gtk_action_get_visible (GtkAction *action);
    void gtk_action_activate (GtkAction *action);
    GtkWidget* gtk_action_create_icon (GtkAction *action,
                            GtkIconSize icon_size);
    GtkWidget* gtk_action_create_menu_item (GtkAction *action);
    GtkWidget* gtk_action_create_tool_item (GtkAction *action);
    void gtk_action_connect_proxy (GtkAction *action,
                            GtkWidget *proxy);
    void gtk_action_disconnect_proxy (GtkAction *action,
                            GtkWidget *proxy);
    GSList* gtk_action_get_proxies (GtkAction *action);
    void gtk_action_connect_accelerator (GtkAction *action);
    void gtk_action_disconnect_accelerator (GtkAction *action);


    void gtk_action_block_activate_from (GtkAction *action,
                            GtkWidget *proxy);
    void gtk_action_unblock_activate_from (GtkAction *action,
                            GtkWidget *proxy);
    void _gtk_action_emit_activate (GtkAction *action);


    void gtk_action_set_accel_path (GtkAction *action,
                            gchar *accel_path);
    void gtk_action_set_accel_group (GtkAction *action,
                            GtkAccelGroup *accel_group);



    alias gchar * (*GtkTranslateFunc) ( gchar *path,
                        gpointer func_data);



    alias void (*GtkPrintFunc) (gpointer func_data,
                        gchar *str);





    alias void (*GtkItemFactoryCallback) ();
    alias void (*GtkItemFactoryCallback1) (gpointer callback_data,
                        guint callback_action,
                        GtkWidget *widget);
    alias _GtkItemFactory GtkItemFactory;

    alias _GtkItemFactoryClass GtkItemFactoryClass;

    alias _GtkItemFactoryEntry GtkItemFactoryEntry;

    alias _GtkItemFactoryItem GtkItemFactoryItem;


    struct _GtkItemFactory {
    GtkObject object;

    gchar *path;
    GtkAccelGroup *accel_group;
    GtkWidget *widget;
    GSList *items;

    GtkTranslateFunc translate_func;
    gpointer translate_data;
    GtkDestroyNotify translate_notify;
    }

    struct _GtkItemFactoryClass {
    GtkObjectClass object_class;

    GHashTable *item_ht;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    struct _GtkItemFactoryEntry {
    gchar *path;
    gchar *accelerator;

    GtkItemFactoryCallback callback;
    guint callback_action;
    gchar *item_type;





    gpointer extra_data;
    }

    struct _GtkItemFactoryItem {
    gchar *path;
    GSList *widgets;
    }


    GType gtk_item_factory_get_type () ;




    GtkItemFactory* gtk_item_factory_new (GType container_type,
                        gchar *path,
                        GtkAccelGroup *accel_group);
    void gtk_item_factory_ruct (GtkItemFactory *ifactory,
                        GType container_type,
                        gchar *path,
                        GtkAccelGroup *accel_group);



    void gtk_item_factory_add_foreign (GtkWidget *accel_widget,
                            gchar *full_path,
                            GtkAccelGroup *accel_group,
                            guint keyval,
                            GdkModifierType modifiers);

    GtkItemFactory* gtk_item_factory_from_widget (GtkWidget *widget);
    gchar* gtk_item_factory_path_from_widget (GtkWidget *widget);

    GtkWidget* gtk_item_factory_get_item (GtkItemFactory *ifactory,
                                gchar *path);
    GtkWidget* gtk_item_factory_get_widget (GtkItemFactory *ifactory,
                                gchar *path);
    GtkWidget* gtk_item_factory_get_widget_by_action (GtkItemFactory *ifactory,
                            guint action);
    GtkWidget* gtk_item_factory_get_item_by_action (GtkItemFactory *ifactory,
                            guint action);

    void gtk_item_factory_create_item (GtkItemFactory *ifactory,
                        GtkItemFactoryEntry *entry,
                        gpointer callback_data,
                        guint callback_type);
    void gtk_item_factory_create_items (GtkItemFactory *ifactory,
                        guint n_entries,
                        GtkItemFactoryEntry *entries,
                        gpointer callback_data);
    void gtk_item_factory_delete_item (GtkItemFactory *ifactory,
                        gchar *path);
    void gtk_item_factory_delete_entry (GtkItemFactory *ifactory,
                        GtkItemFactoryEntry *entry);
    void gtk_item_factory_delete_entries (GtkItemFactory *ifactory,
                        guint n_entries,
                        GtkItemFactoryEntry *entries);
    void gtk_item_factory_popup (GtkItemFactory *ifactory,
                        guint x,
                        guint y,
                        guint mouse_button,
                        guint32 time_);
    void gtk_item_factory_popup_with_data(GtkItemFactory *ifactory,
                        gpointer popup_data,
                        GtkDestroyNotify destroy,
                        guint x,
                        guint y,
                        guint mouse_button,
                        guint32 time_);
    gpointer gtk_item_factory_popup_data (GtkItemFactory *ifactory);
    gpointer gtk_item_factory_popup_data_from_widget (GtkWidget *widget);
    void gtk_item_factory_set_translate_func (GtkItemFactory *ifactory,
                        GtkTranslateFunc func,
                        gpointer data,
                        GtkDestroyNotify notify);





    alias void (*GtkMenuCallback) (GtkWidget *widget,
                    gpointer user_data);
    struct GtkMenuEntry {
    gchar *path;
    gchar *accelerator;
    GtkMenuCallback callback;
    gpointer callback_data;
    GtkWidget *widget;
    };



    alias void (*GtkItemFactoryCallback2) (GtkWidget *widget,
                        gpointer callback_data,
                        guint callback_action);


    void gtk_item_factory_create_items_ac (GtkItemFactory *ifactory,
                        guint n_entries,
                        GtkItemFactoryEntry *entries,
                        gpointer callback_data,
                        guint callback_type);

    GtkItemFactory* gtk_item_factory_from_path ( gchar *path);
    void gtk_item_factory_create_menu_entries (guint n_entries,
                        GtkMenuEntry *entries);
    void gtk_item_factories_path_delete ( gchar *ifactory_path,
                        gchar *path);


    alias _GtkActionGroup GtkActionGroup;

    alias _GtkActionGroupPrivate GtkActionGroupPrivate;
    alias void _GtkActionGroupPrivate;

    alias _GtkActionGroupClass GtkActionGroupClass;

    alias _GtkActionEntry GtkActionEntry;

    alias _GtkToggleActionEntry GtkToggleActionEntry;

    alias _GtkRadioActionEntry GtkRadioActionEntry;


    struct _GtkActionGroup {
    GObject parent;



    GtkActionGroupPrivate *private_data;
    }

    struct _GtkActionGroupClass {
    GObjectClass parent_class;

    GtkAction *(* get_action) (GtkActionGroup *action_group,
                gchar *action_name);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    struct _GtkActionEntry {
    gchar *name;
    gchar *stock_id;
    gchar *label;
    gchar *accelerator;
    gchar *tooltip;
    GCallback callback;
    }

    struct _GtkToggleActionEntry {
    gchar *name;
    gchar *stock_id;
    gchar *label;
    gchar *accelerator;
    gchar *tooltip;
    GCallback callback;
    gboolean is_active;
    }

    struct _GtkRadioActionEntry {
    gchar *name;
    gchar *stock_id;
    gchar *label;
    gchar *accelerator;
    gchar *tooltip;
    gint value;
    }

    GType gtk_action_group_get_type ();
    GtkActionGroup *gtk_action_group_new ( gchar *name);
    gchar *gtk_action_group_get_name (GtkActionGroup *action_group);
    gboolean gtk_action_group_get_sensitive (GtkActionGroup *action_group);
    void gtk_action_group_set_sensitive (GtkActionGroup *action_group,
                                gboolean sensitive);
    gboolean gtk_action_group_get_visible (GtkActionGroup *action_group);
    void gtk_action_group_set_visible (GtkActionGroup *action_group,
                                gboolean visible);
    GtkAction *gtk_action_group_get_action (GtkActionGroup *action_group,
                                gchar *action_name);
    GList *gtk_action_group_list_actions (GtkActionGroup *action_group);
    void gtk_action_group_add_action (GtkActionGroup *action_group,
                                GtkAction *action);
    void gtk_action_group_add_action_with_accel (GtkActionGroup *action_group,
                                GtkAction *action,
                                gchar *accelerator);

    void gtk_action_group_remove_action (GtkActionGroup *action_group,
                                GtkAction *action);
    void gtk_action_group_add_actions (GtkActionGroup *action_group,
                                GtkActionEntry *entries,
                                guint n_entries,
                                gpointer user_data);
    void gtk_action_group_add_toggle_actions (GtkActionGroup *action_group,
                                GtkToggleActionEntry *entries,
                                guint n_entries,
                                gpointer user_data);
    void gtk_action_group_add_radio_actions (GtkActionGroup *action_group,
                                GtkRadioActionEntry *entries,
                                guint n_entries,
                                gint value,
                                GCallback on_change,
                                gpointer user_data);
    void gtk_action_group_add_actions_full (GtkActionGroup *action_group,
                                GtkActionEntry *entries,
                                guint n_entries,
                                gpointer user_data,
                                GDestroyNotify destroy);
    void gtk_action_group_add_toggle_actions_full (GtkActionGroup *action_group,
                                GtkToggleActionEntry *entries,
                                guint n_entries,
                                gpointer user_data,
                                GDestroyNotify destroy);
    void gtk_action_group_add_radio_actions_full (GtkActionGroup *action_group,
                                GtkRadioActionEntry *entries,
                                guint n_entries,
                                gint value,
                                GCallback on_change,
                                gpointer user_data,
                                GDestroyNotify destroy);
    void gtk_action_group_set_translate_func (GtkActionGroup *action_group,
                                GtkTranslateFunc func,
                                gpointer data,
                                GtkDestroyNotify notify);
    void gtk_action_group_set_translation_domain (GtkActionGroup *action_group,
                                gchar *domain);


    void _gtk_action_group_emit_connect_proxy (GtkActionGroup *action_group,
                        GtkAction *action,
                        GtkWidget *proxy);
    void _gtk_action_group_emit_disconnect_proxy (GtkActionGroup *action_group,
                        GtkAction *action,
                        GtkWidget *proxy);
    void _gtk_action_group_emit_pre_activate (GtkActionGroup *action_group,
                        GtkAction *action);
    void _gtk_action_group_emit_post_activate (GtkActionGroup *action_group,
                        GtkAction *action);



    alias _GtkAlignment GtkAlignment;

    alias _GtkAlignmentClass GtkAlignmentClass;

    alias _GtkAlignmentPrivate GtkAlignmentPrivate;
    alias void _GtkAlignmentPrivate;


    struct _GtkAlignment {
    GtkBin bin;

    gfloat xalign;
    gfloat yalign;
    gfloat xscale;
    gfloat yscale;
    }

    struct _GtkAlignmentClass {
    GtkBinClass parent_class;
    }


    GType gtk_alignment_get_type () ;
    GtkWidget* gtk_alignment_new (gfloat xalign,
                    gfloat yalign,
                    gfloat xscale,
                    gfloat yscale);
    void gtk_alignment_set (GtkAlignment *alignment,
                    gfloat xalign,
                    gfloat yalign,
                    gfloat xscale,
                    gfloat yscale);

    void gtk_alignment_set_padding (GtkAlignment *alignment,
                    guint padding_top,
                    guint padding_bottom,
                    guint padding_left,
                    guint padding_right);

    void gtk_alignment_get_padding (GtkAlignment *alignment,
                    guint *padding_top,
                    guint *padding_bottom,
                    guint *padding_left,
                    guint *padding_right);
    alias _GtkArrow GtkArrow;

    alias _GtkArrowClass GtkArrowClass;


    struct _GtkArrow {
    GtkMisc misc;

    gint16 arrow_type;
    gint16 shadow_type;
    }

    struct _GtkArrowClass {
    GtkMiscClass parent_class;
    }


    GType gtk_arrow_get_type () ;
    GtkWidget* gtk_arrow_new (GtkArrowType arrow_type,
                    GtkShadowType shadow_type);
    void gtk_arrow_set (GtkArrow *arrow,
                    GtkArrowType arrow_type,
                    GtkShadowType shadow_type);
    alias _GtkFrame GtkFrame;

    alias _GtkFrameClass GtkFrameClass;


    struct _GtkFrame {
    GtkBin bin;

    GtkWidget *label_widget;
    gint16 shadow_type;
    gfloat label_xalign;
    gfloat label_yalign;

    GtkAllocation child_allocation;
    }

    struct _GtkFrameClass {
    GtkBinClass parent_class;

    void (*compute_child_allocation) (GtkFrame *frame, GtkAllocation *allocation);
    }


    GType gtk_frame_get_type () ;
    GtkWidget* gtk_frame_new ( gchar *label);

    void gtk_frame_set_label (GtkFrame *frame,
                        gchar *label);
    gchar *gtk_frame_get_label (GtkFrame *frame);

    void gtk_frame_set_label_widget (GtkFrame *frame,
                    GtkWidget *label_widget);
    GtkWidget *gtk_frame_get_label_widget (GtkFrame *frame);
    void gtk_frame_set_label_align (GtkFrame *frame,
                    gfloat xalign,
                    gfloat yalign);
    void gtk_frame_get_label_align (GtkFrame *frame,
                    gfloat *xalign,
                    gfloat *yalign);
    void gtk_frame_set_shadow_type (GtkFrame *frame,
                    GtkShadowType type);
    GtkShadowType gtk_frame_get_shadow_type (GtkFrame *frame);
    alias _GtkAspectFrame GtkAspectFrame;

    alias _GtkAspectFrameClass GtkAspectFrameClass;


    struct _GtkAspectFrame {
    GtkFrame frame;

    gfloat xalign;
    gfloat yalign;
    gfloat ratio;
    gboolean obey_child;

    GtkAllocation center_allocation;
    }

    struct _GtkAspectFrameClass {
    GtkFrameClass parent_class;
    }


    GType gtk_aspect_frame_get_type () ;
    GtkWidget* gtk_aspect_frame_new ( gchar *label,
                        gfloat xalign,
                        gfloat yalign,
                        gfloat ratio,
                        gboolean obey_child);
    void gtk_aspect_frame_set (GtkAspectFrame *aspect_frame,
                        gfloat xalign,
                        gfloat yalign,
                        gfloat ratio,
                        gboolean obey_child);
    alias _GtkBox GtkBox;

    alias _GtkBoxClass GtkBoxClass;

    alias _GtkBoxChild GtkBoxChild;


    struct _GtkBox {
    GtkContainer container;


    GList *children;
    gint16 spacing;
    guint homogeneous;
    }

    struct _GtkBoxClass {
    GtkContainerClass parent_class;
    }

    struct _GtkBoxChild {
    GtkWidget *widget;
    guint16 padding;
    guint expand;
    guint fill;
    guint pack;
    guint is_secondary;
    }


    GType gtk_box_get_type () ;
    void gtk_box_pack_start (GtkBox *box,
                        GtkWidget *child,
                        gboolean expand,
                        gboolean fill,
                        guint padding);
    void gtk_box_pack_end (GtkBox *box,
                        GtkWidget *child,
                        gboolean expand,
                        gboolean fill,
                        guint padding);
    void gtk_box_pack_start_defaults (GtkBox *box,
                        GtkWidget *widget);
    void gtk_box_pack_end_defaults (GtkBox *box,
                        GtkWidget *widget);
    void gtk_box_set_homogeneous (GtkBox *box,
                        gboolean homogeneous);
    gboolean gtk_box_get_homogeneous (GtkBox *box);
    void gtk_box_set_spacing (GtkBox *box,
                        gint spacing);
    gint gtk_box_get_spacing (GtkBox *box);
    void gtk_box_reorder_child (GtkBox *box,
                        GtkWidget *child,
                        gint position);
    void gtk_box_query_child_packing (GtkBox *box,
                        GtkWidget *child,
                        gboolean *expand,
                        gboolean *fill,
                        guint *padding,
                        GtkPackType *pack_type);
    void gtk_box_set_child_packing (GtkBox *box,
                        GtkWidget *child,
                        gboolean expand,
                        gboolean fill,
                        guint padding,
                        GtkPackType pack_type);
    alias _GtkButtonBox GtkButtonBox;

    alias _GtkButtonBoxClass GtkButtonBoxClass;


    struct _GtkButtonBox {
    GtkBox box;
    gint child_min_width;
    gint child_min_height;
    gint child_ipad_x;
    gint child_ipad_y;
    GtkButtonBoxStyle layout_style;
    }

    struct _GtkButtonBoxClass {
    GtkBoxClass parent_class;
    }


    GType gtk_button_box_get_type () ;

    GtkButtonBoxStyle gtk_button_box_get_layout (GtkButtonBox *widget);
    void gtk_button_box_set_layout (GtkButtonBox *widget,
                            GtkButtonBoxStyle layout_style);
    gboolean gtk_button_box_get_child_secondary (GtkButtonBox *widget,
                            GtkWidget *child);
    void gtk_button_box_set_child_secondary (GtkButtonBox *widget,
                            GtkWidget *child,
                            gboolean is_secondary);





    void gtk_button_box_set_child_size (GtkButtonBox *widget,
                        gint min_width,
                        gint min_height);
    void gtk_button_box_set_child_ipadding (GtkButtonBox *widget,
                        gint ipad_x,
                        gint ipad_y);
    void gtk_button_box_get_child_size (GtkButtonBox *widget,
                        gint *min_width,
                        gint *min_height);
    void gtk_button_box_get_child_ipadding (GtkButtonBox *widget,
                        gint *ipad_x,
                        gint *ipad_y);



    void _gtk_button_box_child_requisition (GtkWidget *widget,
                        int *nvis_children,
                        int *nvis_secondaries,
                        int *width,
                        int *height);

    alias _GtkBindingSet GtkBindingSet;

    alias _GtkBindingEntry GtkBindingEntry;

    alias _GtkBindingSignal GtkBindingSignal;

    alias _GtkBindingArg GtkBindingArg;


    struct _GtkBindingSet {
    gchar *set_name;
    gint priority;
    GSList *widget_path_pspecs;
    GSList *widget_class_pspecs;
    GSList *class_branch_pspecs;
    GtkBindingEntry *entries;
    GtkBindingEntry *current;
    guint parsed;
    }

    struct _GtkBindingEntry {


    guint keyval;
    GdkModifierType modifiers;

    GtkBindingSet *binding_set;
    guint destroyed;
    guint in_emission;
    GtkBindingEntry *set_next;
    GtkBindingEntry *hash_next;
    GtkBindingSignal *signals;
    }

    struct _GtkBindingSignal {
    GtkBindingSignal *next;
    gchar *signal_name;
    guint n_args;
    GtkBindingArg *args;
    }

    struct _GtkBindingArg {
    GType arg_type;
    union d_union  {
    glong int_data;
    gdouble double_data;
    gchar *string_data;
    }
    d_union d;
    }




    GtkBindingSet* gtk_binding_set_new ( gchar *set_name);
    GtkBindingSet* gtk_binding_set_by_class(gpointer object_class);
    GtkBindingSet* gtk_binding_set_find ( gchar *set_name);
    gboolean gtk_bindings_activate (GtkObject *object,
                        guint keyval,
                        GdkModifierType modifiers);
    gboolean gtk_bindings_activate_event (GtkObject *object,
                        GdkEventKey *event);
    gboolean gtk_binding_set_activate (GtkBindingSet *binding_set,
                        guint keyval,
                        GdkModifierType modifiers,
                        GtkObject *object);

    void gtk_binding_entry_clear (GtkBindingSet *binding_set,
                        guint keyval,
                        GdkModifierType modifiers);
    void gtk_binding_entry_add_signal (GtkBindingSet *binding_set,
                        guint keyval,
                        GdkModifierType modifiers,
                        gchar *signal_name,
                        guint n_args,
                        ...);
    void gtk_binding_set_add_path (GtkBindingSet *binding_set,
                        GtkPathType path_type,
                        gchar *path_pattern,
                        GtkPathPriorityType priority);




    void gtk_binding_entry_remove (GtkBindingSet *binding_set,
                        guint keyval,
                        GdkModifierType modifiers);
    void gtk_binding_entry_add_signall (GtkBindingSet *binding_set,
                        guint keyval,
                        GdkModifierType modifiers,
                        gchar *signal_name,
                        GSList *binding_args);
    guint gtk_binding_parse_binding (GScanner *scanner);


    void _gtk_binding_reset_parsed ();




    guint _gtk_binding_signal_new ( gchar *signal_name,
                GType itype,
                GSignalFlags signal_flags,
                GCallback handler,
                GSignalAccumulator accumulator,
                gpointer accu_data,
                GSignalCMarshaller c_marshaller,
                GType return_type,
                guint n_params,
                ...);

    alias _GtkButton GtkButton;

    alias _GtkButtonClass GtkButtonClass;


    struct _GtkButton {
    GtkBin bin;

    GdkWindow *event_window;

    gchar *label_text;

    guint activate_timeout;

    guint in_button;
    guint button_down;
    guint relief;
    guint use_underline;
    guint use_stock;
    guint depressed;
    guint depress_on_activate;
    guint focus_on_click;
    }

    struct _GtkButtonClass {
    GtkBinClass parent_class;

    void (* pressed) (GtkButton *button);
    void (* released) (GtkButton *button);
    void (* clicked) (GtkButton *button);
    void (* enter) (GtkButton *button);
    void (* leave) (GtkButton *button);
    void (* activate) (GtkButton *button);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_button_get_type () ;
    GtkWidget* gtk_button_new ();
    GtkWidget* gtk_button_new_with_label ( gchar *label);
    GtkWidget* gtk_button_new_from_stock ( gchar *stock_id);
    GtkWidget* gtk_button_new_with_mnemonic ( gchar *label);
    void gtk_button_pressed (GtkButton *button);
    void gtk_button_released (GtkButton *button);
    void gtk_button_clicked (GtkButton *button);
    void gtk_button_enter (GtkButton *button);
    void gtk_button_leave (GtkButton *button);

    void gtk_button_set_relief (GtkButton *button,
                            GtkReliefStyle newstyle);
    GtkReliefStyle gtk_button_get_relief (GtkButton *button);
    void gtk_button_set_label (GtkButton *button,
                            gchar *label);
    gchar *gtk_button_get_label (GtkButton *button);
    void gtk_button_set_use_underline (GtkButton *button,
                            gboolean use_underline);
    gboolean gtk_button_get_use_underline (GtkButton *button);
    void gtk_button_set_use_stock (GtkButton *button,
                            gboolean use_stock);
    gboolean gtk_button_get_use_stock (GtkButton *button);
    void gtk_button_set_focus_on_click (GtkButton *button,
                            gboolean focus_on_click);
    gboolean gtk_button_get_focus_on_click (GtkButton *button);
    void gtk_button_set_alignment (GtkButton *button,
                            gfloat xalign,
                            gfloat yalign);
    void gtk_button_get_alignment (GtkButton *button,
                            gfloat *xalign,
                            gfloat *yalign);


    void _gtk_button_set_depressed (GtkButton *button,
                        gboolean depressed);
    void _gtk_button_paint (GtkButton *button,
                        GdkRectangle *area,
                        GtkStateType state_type,
                        GtkShadowType shadow_type,
                        gchar *main_detail,
                        gchar *default_detail);










    void gtk_marshal_BOOLEAN__VOID (GClosure *closure,
                    GValue *return_value,
                    guint n_param_values,
                        GValue *param_values,
                    gpointer invocation_hint,
                    gpointer marshal_data);



    void gtk_marshal_BOOLEAN__POINTER (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);



    void gtk_marshal_BOOLEAN__POINTER_POINTER_INT_INT (GClosure *closure,
                                GValue *return_value,
                                guint n_param_values,
                                GValue *param_values,
                                gpointer invocation_hint,
                                gpointer marshal_data);



    void gtk_marshal_BOOLEAN__POINTER_INT_INT (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);



    void gtk_marshal_BOOLEAN__POINTER_INT_INT_UINT (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                                GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);



    void gtk_marshal_BOOLEAN__POINTER_STRING_STRING_POINTER (GClosure *closure,
                                    GValue *return_value,
                                    guint n_param_values,
                                    GValue *param_values,
                                    gpointer invocation_hint,
                                    gpointer marshal_data);



    void gtk_marshal_ENUM__ENUM (GClosure *closure,
                    GValue *return_value,
                    guint n_param_values,
                    GValue *param_values,
                    gpointer invocation_hint,
                    gpointer marshal_data);


    void gtk_marshal_INT__POINTER (GClosure *closure,
                    GValue *return_value,
                    guint n_param_values,
                    GValue *param_values,
                    gpointer invocation_hint,
                    gpointer marshal_data);


    void gtk_marshal_INT__POINTER_CHAR_CHAR (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);
    void gtk_marshal_VOID__ENUM_FLOAT (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);



    void gtk_marshal_VOID__ENUM_FLOAT_BOOLEAN (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);







    void gtk_marshal_VOID__INT_INT (GClosure *closure,
                    GValue *return_value,
                    guint n_param_values,
                        GValue *param_values,
                    gpointer invocation_hint,
                    gpointer marshal_data);



    void gtk_marshal_VOID__INT_INT_POINTER (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                            GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);
    void gtk_marshal_VOID__POINTER_INT (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_POINTER (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                            GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_POINTER_POINTER (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                                GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_STRING_STRING (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_UINT (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_UINT_ENUM (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_POINTER_UINT_UINT (GClosure *closure,
                                GValue *return_value,
                                guint n_param_values,
                                GValue *param_values,
                                gpointer invocation_hint,
                                gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_INT_INT_POINTER_UINT_UINT (GClosure *closure,
                                    GValue *return_value,
                                    guint n_param_values,
                                    GValue *param_values,
                                    gpointer invocation_hint,
                                    gpointer marshal_data);



    void gtk_marshal_VOID__POINTER_UINT_UINT (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);
    void gtk_marshal_VOID__STRING_INT_POINTER (GClosure *closure,
                            GValue *return_value,
                            guint n_param_values,
                            GValue *param_values,
                            gpointer invocation_hint,
                            gpointer marshal_data);







    void gtk_marshal_VOID__UINT_POINTER_UINT_ENUM_ENUM_POINTER (GClosure *closure,
                                    GValue *return_value,
                                    guint n_param_values,
                                    GValue *param_values,
                                    gpointer invocation_hint,
                                    gpointer marshal_data);



    void gtk_marshal_VOID__UINT_POINTER_UINT_UINT_ENUM (GClosure *closure,
                                GValue *return_value,
                                guint n_param_values,
                                GValue *param_values,
                                gpointer invocation_hint,
                                gpointer marshal_data);



    void gtk_marshal_VOID__UINT_STRING (GClosure *closure,
                        GValue *return_value,
                        guint n_param_values,
                        GValue *param_values,
                        gpointer invocation_hint,
                        gpointer marshal_data);





    guint gtk_signal_newv ( gchar *name,
                            GtkSignalRunType signal_flags,
                            GtkType object_type,
                            guint function_offset,
                            GtkSignalMarshaller marshaller,
                            GtkType return_val,
                            guint n_args,
                            GtkType *args);
    guint gtk_signal_new ( gchar *name,
                            GtkSignalRunType signal_flags,
                            GtkType object_type,
                            guint function_offset,
                            GtkSignalMarshaller marshaller,
                            GtkType return_val,
                            guint n_args,
                            ...);
    void gtk_signal_emit_stop_by_name (GtkObject *object,
                            gchar *name);
    void gtk_signal_connect_object_while_alive (GtkObject *object,
                            gchar *name,
                            GtkSignalFunc func,
                            GtkObject *alive_object);
    void gtk_signal_connect_while_alive (GtkObject *object,
                            gchar *name,
                            GtkSignalFunc func,
                            gpointer func_data,
                            GtkObject *alive_object);
    gulong gtk_signal_connect_full (GtkObject *object,
                            gchar *name,
                            GtkSignalFunc func,
                            GtkCallbackMarshal unsupported,
                            gpointer data,
                            GtkDestroyNotify destroy_func,
                            gint object_signal,
                            gint after);
    void gtk_signal_emitv (GtkObject *object,
                            guint signal_id,
                            GtkArg *args);
    void gtk_signal_emit (GtkObject *object,
                            guint signal_id,
                            ...);
    void gtk_signal_emit_by_name (GtkObject *object,
                            gchar *name,
                            ...);
    void gtk_signal_emitv_by_name (GtkObject *object,
                            gchar *name,
                            GtkArg *args);
    void gtk_signal_compat_matched (GtkObject *object,
                            GtkSignalFunc func,
                            gpointer data,
                            GSignalMatchType match,
                            guint action);




    alias _GtkCalendar GtkCalendar;

    alias _GtkCalendarClass GtkCalendarClass;


    enum GtkCalendarDisplayOptions {
    GTK_CALENDAR_SHOW_HEADING = 1 << 0,
    GTK_CALENDAR_SHOW_DAY_NAMES = 1 << 1,
    GTK_CALENDAR_NO_MONTH_CHANGE = 1 << 2,
    GTK_CALENDAR_SHOW_WEEK_NUMBERS = 1 << 3,
    GTK_CALENDAR_WEEK_START_MONDAY = 1 << 4
    };


    struct _GtkCalendar {
    GtkWidget widget;

    GtkStyle *header_style;
    GtkStyle *label_style;

    gint month;
    gint year;
    gint selected_day;

    gint day_month[6][7];
    gint day[6][7];

    gint num_marked_dates;
    gint marked_date[31];
    GtkCalendarDisplayOptions display_flags;
    GdkColor marked_date_color[31];

    GdkGC *gc;
    GdkGC *xor_gc;

    gint focus_row;
    gint focus_col;

    gint highlight_row;
    gint highlight_col;

    gpointer private_data;
    gchar grow_space [32];


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    struct _GtkCalendarClass {
    GtkWidgetClass parent_class;


    void (* month_changed) (GtkCalendar *calendar);
    void (* day_selected) (GtkCalendar *calendar);
    void (* day_selected_double_click) (GtkCalendar *calendar);
    void (* prev_month) (GtkCalendar *calendar);
    void (* next_month) (GtkCalendar *calendar);
    void (* prev_year) (GtkCalendar *calendar);
    void (* next_year) (GtkCalendar *calendar);

    }


    GType gtk_calendar_get_type () ;
    GtkWidget* gtk_calendar_new ();

    gboolean gtk_calendar_select_month (GtkCalendar *calendar,
                        guint month,
                        guint year);
    void gtk_calendar_select_day (GtkCalendar *calendar,
                        guint day);

    gboolean gtk_calendar_mark_day (GtkCalendar *calendar,
                        guint day);
    gboolean gtk_calendar_unmark_day (GtkCalendar *calendar,
                        guint day);
    void gtk_calendar_clear_marks (GtkCalendar *calendar);


    void gtk_calendar_set_display_options (GtkCalendar *calendar,
                        GtkCalendarDisplayOptions flags);
    GtkCalendarDisplayOptions
        gtk_calendar_get_display_options (GtkCalendar *calendar);

    void gtk_calendar_display_options (GtkCalendar *calendar,
                        GtkCalendarDisplayOptions flags);


    void gtk_calendar_get_date (GtkCalendar *calendar,
                        guint *year,
                        guint *month,
                        guint *day);
    void gtk_calendar_freeze (GtkCalendar *calendar);
    void gtk_calendar_thaw (GtkCalendar *calendar);








    alias _GtkCellEditable GtkCellEditable;
    alias void _GtkCellEditable;

    alias _GtkCellEditableIface GtkCellEditableIface;


    struct _GtkCellEditableIface {
    GTypeInterface g_iface;


    void (* editing_done) (GtkCellEditable *cell_editable);
    void (* remove_widget) (GtkCellEditable *cell_editable);


    void (* start_editing) (GtkCellEditable *cell_editable,
                GdkEvent *event);
    }


    GType gtk_cell_editable_get_type () ;

    void gtk_cell_editable_start_editing (GtkCellEditable *cell_editable,
                    GdkEvent *event);
    void gtk_cell_editable_editing_done (GtkCellEditable *cell_editable);
    void gtk_cell_editable_remove_widget (GtkCellEditable *cell_editable);






    enum GtkCellRendererState {
    GTK_CELL_RENDERER_SELECTED = 1 << 0,
    GTK_CELL_RENDERER_PRELIT = 1 << 1,
    GTK_CELL_RENDERER_INSENSITIVE = 1 << 2,

    GTK_CELL_RENDERER_SORTED = 1 << 3,
    GTK_CELL_RENDERER_FOCUSED = 1 << 4
    };


    enum GtkCellRendererMode {
    GTK_CELL_RENDERER_MODE_INERT,
    GTK_CELL_RENDERER_MODE_ACTIVATABLE,
    GTK_CELL_RENDERER_MODE_EDITABLE
    };

    alias _GtkCellRenderer GtkCellRenderer;

    alias _GtkCellRendererClass GtkCellRendererClass;


    struct _GtkCellRenderer {
    GtkObject parent;

    gfloat xalign;
    gfloat yalign;

    gint width;
    gint height;

    guint16 xpad;
    guint16 ypad;

    guint mode;
    guint visible;
    guint is_expander;
    guint is_expanded;
    guint cell_background_set;
    }

    struct _GtkCellRendererClass {
    GtkObjectClass parent_class;


    void (* get_size) (GtkCellRenderer *cell,
                    GtkWidget *widget,
                    GdkRectangle *cell_area,
                    gint *x_offset,
                    gint *y_offset,
                    gint *width,
                    gint *height);
    void (* render) (GtkCellRenderer *cell,
                    GdkDrawable *window,
                    GtkWidget *widget,
                    GdkRectangle *background_area,
                    GdkRectangle *cell_area,
                    GdkRectangle *expose_area,
                    GtkCellRendererState flags);
    gboolean (* activate) (GtkCellRenderer *cell,
                    GdkEvent *event,
                    GtkWidget *widget,
                    gchar *path,
                    GdkRectangle *background_area,
                    GdkRectangle *cell_area,
                    GtkCellRendererState flags);
    GtkCellEditable *(* start_editing) (GtkCellRenderer *cell,
                    GdkEvent *event,
                    GtkWidget *widget,
                    gchar *path,
                    GdkRectangle *background_area,
                    GdkRectangle *cell_area,
                    GtkCellRendererState flags);


    void (* editing_canceled) (GtkCellRenderer *cell);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    }

    GType gtk_cell_renderer_get_type () ;

    void gtk_cell_renderer_get_size (GtkCellRenderer *cell,
                            GtkWidget *widget,
                            GdkRectangle *cell_area,
                            gint *x_offset,
                            gint *y_offset,
                            gint *width,
                            gint *height);
    void gtk_cell_renderer_render (GtkCellRenderer *cell,
                            GdkWindow *window,
                            GtkWidget *widget,
                            GdkRectangle *background_area,
                            GdkRectangle *cell_area,
                            GdkRectangle *expose_area,
                            GtkCellRendererState flags);
    gboolean gtk_cell_renderer_activate (GtkCellRenderer *cell,
                            GdkEvent *event,
                            GtkWidget *widget,
                            gchar *path,
                            GdkRectangle *background_area,
                            GdkRectangle *cell_area,
                            GtkCellRendererState flags);
    GtkCellEditable *gtk_cell_renderer_start_editing (GtkCellRenderer *cell,
                            GdkEvent *event,
                            GtkWidget *widget,
                            gchar *path,
                            GdkRectangle *background_area,
                            GdkRectangle *cell_area,
                            GtkCellRendererState flags);
    void gtk_cell_renderer_set_fixed_size (GtkCellRenderer *cell,
                            gint width,
                            gint height);
    void gtk_cell_renderer_get_fixed_size (GtkCellRenderer *cell,
                            gint *width,
                            gint *height);


    void gtk_cell_renderer_editing_canceled (GtkCellRenderer *cell);




    alias _GtkTreeIter GtkTreeIter;

    alias _GtkTreePath GtkTreePath;
    alias void _GtkTreePath;

    alias _GtkTreeRowReference GtkTreeRowReference;
    alias void _GtkTreeRowReference;

    alias _GtkTreeModel GtkTreeModel;
    alias void _GtkTreeModel;

    alias _GtkTreeModelIface GtkTreeModelIface;

    alias gboolean (* GtkTreeModelForeachFunc) (GtkTreeModel *model, GtkTreePath *path, GtkTreeIter *iter, gpointer data);


    enum GtkTreeModelFlags {
    GTK_TREE_MODEL_ITERS_PERSIST = 1 << 0,
    GTK_TREE_MODEL_LIST_ONLY = 1 << 1
    };


    struct _GtkTreeIter {
    gint stamp;
    gpointer user_data;
    gpointer user_data2;
    gpointer user_data3;
    }

    struct _GtkTreeModelIface {
    GTypeInterface g_iface;


    void (* row_changed) (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter);
    void (* row_inserted) (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter);
    void (* row_has_child_toggled) (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter);
    void (* row_deleted) (GtkTreeModel *tree_model,
                        GtkTreePath *path);
    void (* rows_reordered) (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter,
                        gint *new_order);


    GtkTreeModelFlags (* get_flags) (GtkTreeModel *tree_model);

    gint (* get_n_columns) (GtkTreeModel *tree_model);
    GType (* get_column_type) (GtkTreeModel *tree_model,
                    gint index_);
    gboolean (* get_iter) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter,
                    GtkTreePath *path);
    GtkTreePath *(* get_path) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter);
    void (* get_value) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter,
                    gint column,
                    GValue *value);
    gboolean (* iter_next) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter);
    gboolean (* iter_children) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter,
                    GtkTreeIter *parent);
    gboolean (* iter_has_child) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter);
    gint (* iter_n_children) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter);
    gboolean (* iter_nth_child) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter,
                    GtkTreeIter *parent,
                    gint n);
    gboolean (* iter_parent) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter,
                    GtkTreeIter *child);
    void (* ref_node) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter);
    void (* unref_node) (GtkTreeModel *tree_model,
                    GtkTreeIter *iter);
    }



    GtkTreePath *gtk_tree_path_new ();
    GtkTreePath *gtk_tree_path_new_from_string ( gchar *path);
    GtkTreePath *gtk_tree_path_new_from_indices (gint first_index,
                        ...);
    gchar *gtk_tree_path_to_string (GtkTreePath *path);
    GtkTreePath *gtk_tree_path_new_first ();
    void gtk_tree_path_append_index (GtkTreePath *path,
                        gint index_);
    void gtk_tree_path_prepend_index (GtkTreePath *path,
                        gint index_);
    gint gtk_tree_path_get_depth (GtkTreePath *path);
    gint *gtk_tree_path_get_indices (GtkTreePath *path);
    void gtk_tree_path_free (GtkTreePath *path);
    GtkTreePath *gtk_tree_path_copy ( GtkTreePath *path);
    GType gtk_tree_path_get_type ();
    gint gtk_tree_path_compare ( GtkTreePath *a,
                        GtkTreePath *b);
    void gtk_tree_path_next (GtkTreePath *path);
    gboolean gtk_tree_path_prev (GtkTreePath *path);
    gboolean gtk_tree_path_up (GtkTreePath *path);
    void gtk_tree_path_down (GtkTreePath *path);

    gboolean gtk_tree_path_is_ancestor (GtkTreePath *path,
                        GtkTreePath *descendant);
    gboolean gtk_tree_path_is_descendant (GtkTreePath *path,
                        GtkTreePath *ancestor);
    GType gtk_tree_row_reference_get_type ();
    GtkTreeRowReference *gtk_tree_row_reference_new (GtkTreeModel *model,
                            GtkTreePath *path);
    GtkTreeRowReference *gtk_tree_row_reference_new_proxy (GObject *proxy,
                            GtkTreeModel *model,
                            GtkTreePath *path);
    GtkTreePath *gtk_tree_row_reference_get_path (GtkTreeRowReference *reference);
    gboolean gtk_tree_row_reference_valid (GtkTreeRowReference *reference);
    GtkTreeRowReference *gtk_tree_row_reference_copy (GtkTreeRowReference *reference);
    void gtk_tree_row_reference_free (GtkTreeRowReference *reference);


    void gtk_tree_row_reference_inserted (GObject *proxy,
                            GtkTreePath *path);
    void gtk_tree_row_reference_deleted (GObject *proxy,
                            GtkTreePath *path);
    void gtk_tree_row_reference_reordered (GObject *proxy,
                            GtkTreePath *path,
                            GtkTreeIter *iter,
                            gint *new_order);


    GtkTreeIter * gtk_tree_iter_copy (GtkTreeIter *iter);
    void gtk_tree_iter_free (GtkTreeIter *iter);
    GType gtk_tree_iter_get_type ();

    GType gtk_tree_model_get_type () ;
    GtkTreeModelFlags gtk_tree_model_get_flags (GtkTreeModel *tree_model);
    gint gtk_tree_model_get_n_columns (GtkTreeModel *tree_model);
    GType gtk_tree_model_get_column_type (GtkTreeModel *tree_model,
                            gint index_);



    gboolean gtk_tree_model_get_iter (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                            GtkTreePath *path);
    gboolean gtk_tree_model_get_iter_from_string (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                                gchar *path_string);
    gchar * gtk_tree_model_get_string_from_iter (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    gboolean gtk_tree_model_get_iter_first (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    GtkTreePath * gtk_tree_model_get_path (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    void gtk_tree_model_get_value (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                            gint column,
                            GValue *value);
    gboolean gtk_tree_model_iter_next (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    gboolean gtk_tree_model_iter_children (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                            GtkTreeIter *parent);
    gboolean gtk_tree_model_iter_has_child (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    gint gtk_tree_model_iter_n_children (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    gboolean gtk_tree_model_iter_nth_child (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                            GtkTreeIter *parent,
                            gint n);
    gboolean gtk_tree_model_iter_parent (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                            GtkTreeIter *child);
    void gtk_tree_model_ref_node (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    void gtk_tree_model_unref_node (GtkTreeModel *tree_model,
                            GtkTreeIter *iter);
    void gtk_tree_model_get (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                            ...);
    void gtk_tree_model_get_valist (GtkTreeModel *tree_model,
                            GtkTreeIter *iter,
                            va_list var_args);


    void gtk_tree_model_foreach (GtkTreeModel *model,
                            GtkTreeModelForeachFunc func,
                            gpointer user_data);







    void gtk_tree_model_row_changed (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter);
    void gtk_tree_model_row_inserted (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter);
    void gtk_tree_model_row_has_child_toggled (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter);
    void gtk_tree_model_row_deleted (GtkTreeModel *tree_model,
                        GtkTreePath *path);
    void gtk_tree_model_rows_reordered (GtkTreeModel *tree_model,
                        GtkTreePath *path,
                        GtkTreeIter *iter,
                        gint *new_order);













    enum {
    GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID = -1
    };

    alias _GtkTreeSortable GtkTreeSortable;
    alias void _GtkTreeSortable;

    alias _GtkTreeSortableIface GtkTreeSortableIface;


    alias gint (* GtkTreeIterCompareFunc) (GtkTreeModel *model,
                        GtkTreeIter *a,
                        GtkTreeIter *b,
                        gpointer user_data);


    struct _GtkTreeSortableIface {
    GTypeInterface g_iface;


    void (* sort_column_changed) (GtkTreeSortable *sortable);


    gboolean (* get_sort_column_id) (GtkTreeSortable *sortable,
                    gint *sort_column_id,
                    GtkSortType *order);
    void (* set_sort_column_id) (GtkTreeSortable *sortable,
                    gint sort_column_id,
                    GtkSortType order);
    void (* set_sort_func) (GtkTreeSortable *sortable,
                    gint sort_column_id,
                    GtkTreeIterCompareFunc func,
                    gpointer data,
                    GtkDestroyNotify destroy);
    void (* set_default_sort_func) (GtkTreeSortable *sortable,
                    GtkTreeIterCompareFunc func,
                    gpointer data,
                    GtkDestroyNotify destroy);
    gboolean (* has_default_sort_func) (GtkTreeSortable *sortable);
    }


    GType gtk_tree_sortable_get_type () ;

    void gtk_tree_sortable_sort_column_changed (GtkTreeSortable *sortable);
    gboolean gtk_tree_sortable_get_sort_column_id (GtkTreeSortable *sortable,
                            gint *sort_column_id,
                            GtkSortType *order);
    void gtk_tree_sortable_set_sort_column_id (GtkTreeSortable *sortable,
                            gint sort_column_id,
                            GtkSortType order);
    void gtk_tree_sortable_set_sort_func (GtkTreeSortable *sortable,
                            gint sort_column_id,
                            GtkTreeIterCompareFunc sort_func,
                            gpointer user_data,
                            GtkDestroyNotify destroy);
    void gtk_tree_sortable_set_default_sort_func (GtkTreeSortable *sortable,
                            GtkTreeIterCompareFunc sort_func,
                            gpointer user_data,
                            GtkDestroyNotify destroy);
    gboolean gtk_tree_sortable_has_default_sort_func (GtkTreeSortable *sortable);



    enum GtkTreeViewColumnSizing {
    GTK_TREE_VIEW_COLUMN_GROW_ONLY,
    GTK_TREE_VIEW_COLUMN_AUTOSIZE,
    GTK_TREE_VIEW_COLUMN_FIXED
    };


    alias _GtkTreeViewColumn GtkTreeViewColumn;

    alias _GtkTreeViewColumnClass GtkTreeViewColumnClass;


    alias void (* GtkTreeCellDataFunc) (GtkTreeViewColumn *tree_column,
                    GtkCellRenderer *cell,
                    GtkTreeModel *tree_model,
                    GtkTreeIter *iter,
                    gpointer data);


    struct _GtkTreeViewColumn {
    GtkObject parent;

    GtkWidget *tree_view;
    GtkWidget *button;
    GtkWidget *child;
    GtkWidget *arrow;
    GtkWidget *alignment;
    GdkWindow *window;
    GtkCellEditable *editable_widget;
    gfloat xalign;
    guint property_changed_signal;
    gint spacing;



    GtkTreeViewColumnSizing column_type;
    gint requested_width;
    gint button_request;
    gint resized_width;
    gint width;
    gint fixed_width;
    gint min_width;
    gint max_width;


    gint drag_x;
    gint drag_y;

    gchar *title;
    GList *cell_list;


    guint sort_clicked_signal;
    guint sort_column_changed_signal;
    gint sort_column_id;
    GtkSortType sort_order;


    guint visible;
    guint resizable;
    guint clickable;
    guint dirty;
    guint show_sort_indicator;
    guint maybe_reordered;
    guint reorderable;
    guint use_resized_width;
    guint expand;
    }

    struct _GtkTreeViewColumnClass {
    GtkObjectClass parent_class;

    void (*clicked) (GtkTreeViewColumn *tree_column);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_tree_view_column_get_type ();
    GtkTreeViewColumn *gtk_tree_view_column_new ();
    GtkTreeViewColumn *gtk_tree_view_column_new_with_attributes ( gchar *title,
                                    GtkCellRenderer *cell,
                                    ...);
    void gtk_tree_view_column_pack_start (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell,
                                    gboolean expand);
    void gtk_tree_view_column_pack_end (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell,
                                    gboolean expand);
    void gtk_tree_view_column_clear (GtkTreeViewColumn *tree_column);
    GList *gtk_tree_view_column_get_cell_renderers (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_add_attribute (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell_renderer,
                                    gchar *attribute,
                                    gint column);
    void gtk_tree_view_column_set_attributes (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell_renderer,
                                    ...);
    void gtk_tree_view_column_set_cell_data_func (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell_renderer,
                                    GtkTreeCellDataFunc func,
                                    gpointer func_data,
                                    GtkDestroyNotify destroy);
    void gtk_tree_view_column_clear_attributes (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell_renderer);
    void gtk_tree_view_column_set_spacing (GtkTreeViewColumn *tree_column,
                                    gint spacing);
    gint gtk_tree_view_column_get_spacing (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_visible (GtkTreeViewColumn *tree_column,
                                    gboolean visible);
    gboolean gtk_tree_view_column_get_visible (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_resizable (GtkTreeViewColumn *tree_column,
                                    gboolean resizable);
    gboolean gtk_tree_view_column_get_resizable (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_sizing (GtkTreeViewColumn *tree_column,
                                    GtkTreeViewColumnSizing type);
    GtkTreeViewColumnSizing gtk_tree_view_column_get_sizing (GtkTreeViewColumn *tree_column);
    gint gtk_tree_view_column_get_width (GtkTreeViewColumn *tree_column);
    gint gtk_tree_view_column_get_fixed_width (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_fixed_width (GtkTreeViewColumn *tree_column,
                                    gint fixed_width);
    void gtk_tree_view_column_set_min_width (GtkTreeViewColumn *tree_column,
                                    gint min_width);
    gint gtk_tree_view_column_get_min_width (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_max_width (GtkTreeViewColumn *tree_column,
                                    gint max_width);
    gint gtk_tree_view_column_get_max_width (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_clicked (GtkTreeViewColumn *tree_column);





    void gtk_tree_view_column_set_title (GtkTreeViewColumn *tree_column,
                                    gchar *title);
    gchar *gtk_tree_view_column_get_title (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_expand (GtkTreeViewColumn *tree_column,
                                    gboolean expand);
    gboolean gtk_tree_view_column_get_expand (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_clickable (GtkTreeViewColumn *tree_column,
                                    gboolean clickable);
    gboolean gtk_tree_view_column_get_clickable (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_widget (GtkTreeViewColumn *tree_column,
                                    GtkWidget *widget);
    GtkWidget *gtk_tree_view_column_get_widget (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_alignment (GtkTreeViewColumn *tree_column,
                                    gfloat xalign);
    gfloat gtk_tree_view_column_get_alignment (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_reorderable (GtkTreeViewColumn *tree_column,
                                    gboolean reorderable);
    gboolean gtk_tree_view_column_get_reorderable (GtkTreeViewColumn *tree_column);






    void gtk_tree_view_column_set_sort_column_id (GtkTreeViewColumn *tree_column,
                                    gint sort_column_id);
    gint gtk_tree_view_column_get_sort_column_id (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_sort_indicator (GtkTreeViewColumn *tree_column,
                                    gboolean setting);
    gboolean gtk_tree_view_column_get_sort_indicator (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_set_sort_order (GtkTreeViewColumn *tree_column,
                                    GtkSortType order);
    GtkSortType gtk_tree_view_column_get_sort_order (GtkTreeViewColumn *tree_column);




    void gtk_tree_view_column_cell_set_cell_data (GtkTreeViewColumn *tree_column,
                                    GtkTreeModel *tree_model,
                                    GtkTreeIter *iter,
                                    gboolean is_expander,
                                    gboolean is_expanded);
    void gtk_tree_view_column_cell_get_size (GtkTreeViewColumn *tree_column,
                                    GdkRectangle *cell_area,
                                    gint *x_offset,
                                    gint *y_offset,
                                    gint *width,
                                    gint *height);
    gboolean gtk_tree_view_column_cell_is_visible (GtkTreeViewColumn *tree_column);
    void gtk_tree_view_column_focus_cell (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell);
    gboolean gtk_tree_view_column_cell_get_position (GtkTreeViewColumn *tree_column,
                                    GtkCellRenderer *cell_renderer,
                                    gint *start_pos,
                                    gint *width);








    alias _GtkCellLayout GtkCellLayout;
    alias void _GtkCellLayout;

    alias _GtkCellLayoutIface GtkCellLayoutIface;



    alias void (* GtkCellLayoutDataFunc) (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell,
                        GtkTreeModel *tree_model,
                        GtkTreeIter *iter,
                        gpointer data);

    struct _GtkCellLayoutIface {
    GTypeInterface g_iface;


    void (* pack_start) (GtkCellLayout *cell_layout,
                GtkCellRenderer *cell,
                gboolean expand);
    void (* pack_end) (GtkCellLayout *cell_layout,
                GtkCellRenderer *cell,
                gboolean expand);
    void (* clear) (GtkCellLayout *cell_layout);
    void (* add_attribute) (GtkCellLayout *cell_layout,
                GtkCellRenderer *cell,
                    gchar *attribute,
                gint column);
    void (* set_cell_data_func) (GtkCellLayout *cell_layout,
                GtkCellRenderer *cell,
                GtkCellLayoutDataFunc func,
                gpointer func_data,
                GDestroyNotify destroy);
    void (* clear_attributes) (GtkCellLayout *cell_layout,
                GtkCellRenderer *cell);
    void (* reorder) (GtkCellLayout *cell_layout,
                GtkCellRenderer *cell,
                gint position);
    }

    GType gtk_cell_layout_get_type ();
    void gtk_cell_layout_pack_start (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell,
                        gboolean expand);
    void gtk_cell_layout_pack_end (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell,
                        gboolean expand);
    void gtk_cell_layout_clear (GtkCellLayout *cell_layout);
    void gtk_cell_layout_set_attributes (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell,
                        ...);
    void gtk_cell_layout_add_attribute (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell,
                        gchar *attribute,
                        gint column);
    void gtk_cell_layout_set_cell_data_func (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell,
                        GtkCellLayoutDataFunc func,
                        gpointer func_data,
                        GDestroyNotify destroy);
    void gtk_cell_layout_clear_attributes (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell);
    void gtk_cell_layout_reorder (GtkCellLayout *cell_layout,
                        GtkCellRenderer *cell,
                        gint position);




    alias _GtkCellRendererPixbuf GtkCellRendererPixbuf;

    alias _GtkCellRendererPixbufClass GtkCellRendererPixbufClass;


    struct _GtkCellRendererPixbuf {
    GtkCellRenderer parent;


    GdkPixbuf *pixbuf;
    GdkPixbuf *pixbuf_expander_open;
    GdkPixbuf *pixbuf_expander_closed;
    }

    struct _GtkCellRendererPixbufClass {
    GtkCellRendererClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_cell_renderer_pixbuf_get_type ();
    GtkCellRenderer *gtk_cell_renderer_pixbuf_new ();
    alias _GtkCellRendererText GtkCellRendererText;

    alias _GtkCellRendererTextClass GtkCellRendererTextClass;


    struct _GtkCellRendererText {
    GtkCellRenderer parent;


    gchar *text;
    PangoFontDescription *font;
    gdouble font_scale;
    PangoColor foreground;
    PangoColor background;

    PangoAttrList *extra_attrs;

    PangoUnderline underline_style;

    gint rise;
    gint fixed_height_rows;

    guint strikethrough;

    guint editable;

    guint scale_set;

    guint foreground_set;
    guint background_set;

    guint underline_set;

    guint rise_set;

    guint strikethrough_set;

    guint editable_set;
    guint calc_fixed_height;
    }

    struct _GtkCellRendererTextClass {
    GtkCellRendererClass parent_class;

    void (* edited) (GtkCellRendererText *cell_renderer_text,
            gchar *path,
            gchar *new_text);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_cell_renderer_text_get_type ();
    GtkCellRenderer *gtk_cell_renderer_text_new ();

    void gtk_cell_renderer_text_set_fixed_height_from_font (GtkCellRendererText *renderer,
                                    gint number_of_rows);
    alias _GtkCellRendererToggle GtkCellRendererToggle;

    alias _GtkCellRendererToggleClass GtkCellRendererToggleClass;


    struct _GtkCellRendererToggle {
    GtkCellRenderer parent;


    guint active;
    guint activatable;
    guint radio;
    }

    struct _GtkCellRendererToggleClass {
    GtkCellRendererClass parent_class;

    void (* toggled) (GtkCellRendererToggle *cell_renderer_toggle,
            gchar *path);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_cell_renderer_toggle_get_type ();
    GtkCellRenderer *gtk_cell_renderer_toggle_new ();

    gboolean gtk_cell_renderer_toggle_get_radio (GtkCellRendererToggle *toggle);
    void gtk_cell_renderer_toggle_set_radio (GtkCellRendererToggle *toggle,
                            gboolean radio);

    gboolean gtk_cell_renderer_toggle_get_active (GtkCellRendererToggle *toggle);
    void gtk_cell_renderer_toggle_set_active (GtkCellRendererToggle *toggle,
                            gboolean setting);
    alias _GtkToggleButton GtkToggleButton;

    alias _GtkToggleButtonClass GtkToggleButtonClass;


    struct _GtkToggleButton {
    GtkButton button;

    guint active;
    guint draw_indicator;
    guint inconsistent;
    }

    struct _GtkToggleButtonClass {
    GtkButtonClass parent_class;

    void (* toggled) (GtkToggleButton *toggle_button);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_toggle_button_get_type () ;

    GtkWidget* gtk_toggle_button_new ();
    GtkWidget* gtk_toggle_button_new_with_label ( gchar *label);
    GtkWidget* gtk_toggle_button_new_with_mnemonic ( gchar *label);
    void gtk_toggle_button_set_mode (GtkToggleButton *toggle_button,
                            gboolean draw_indicator);
    gboolean gtk_toggle_button_get_mode (GtkToggleButton *toggle_button);
    void gtk_toggle_button_set_active (GtkToggleButton *toggle_button,
                            gboolean is_active);
    gboolean gtk_toggle_button_get_active (GtkToggleButton *toggle_button);
    void gtk_toggle_button_toggled (GtkToggleButton *toggle_button);
    void gtk_toggle_button_set_inconsistent (GtkToggleButton *toggle_button,
                            gboolean setting);
    gboolean gtk_toggle_button_get_inconsistent (GtkToggleButton *toggle_button);
    alias _GtkCheckButton GtkCheckButton;

    alias _GtkCheckButtonClass GtkCheckButtonClass;


    struct _GtkCheckButton {
    GtkToggleButton toggle_button;
    }

    struct _GtkCheckButtonClass {
    GtkToggleButtonClass parent_class;

    void (* draw_indicator) (GtkCheckButton *check_button,
                GdkRectangle *area);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_check_button_get_type () ;
    GtkWidget* gtk_check_button_new ();
    GtkWidget* gtk_check_button_new_with_label ( gchar *label);
    GtkWidget* gtk_check_button_new_with_mnemonic ( gchar *label);

    void _gtk_check_button_get_props (GtkCheckButton *check_button,
                    gint *indicator_size,
                    gint *indicator_spacing);
    alias _GtkItem GtkItem;

    alias _GtkItemClass GtkItemClass;


    struct _GtkItem {
    GtkBin bin;
    }

    struct _GtkItemClass {
    GtkBinClass parent_class;

    void (* select) (GtkItem *item);
    void (* deselect) (GtkItem *item);
    void (* toggle) (GtkItem *item);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_item_get_type () ;
    void gtk_item_select (GtkItem *item);
    void gtk_item_deselect (GtkItem *item);
    void gtk_item_toggle (GtkItem *item);
    alias _GtkMenuItem GtkMenuItem;

    alias _GtkMenuItemClass GtkMenuItemClass;


    struct _GtkMenuItem {
    GtkItem item;

    GtkWidget *submenu;
    GdkWindow *event_window;

    guint16 toggle_size;
    guint16 accelerator_width;
    gchar *accel_path;

    guint show_submenu_indicator;
    guint submenu_placement;
    guint submenu_direction;
    guint right_justify;
    guint timer_from_keypress;
    guint timer;
    }

    struct _GtkMenuItemClass {
    GtkItemClass parent_class;







    guint hide_on_activate;

    void (* activate) (GtkMenuItem *menu_item);
    void (* activate_item) (GtkMenuItem *menu_item);
    void (* toggle_size_request) (GtkMenuItem *menu_item,
                    gint *requisition);
    void (* toggle_size_allocate) (GtkMenuItem *menu_item,
                    gint allocation);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_menu_item_get_type () ;
    GtkWidget* gtk_menu_item_new ();
    GtkWidget* gtk_menu_item_new_with_label ( gchar *label);
    GtkWidget* gtk_menu_item_new_with_mnemonic ( gchar *label);
    void gtk_menu_item_set_submenu (GtkMenuItem *menu_item,
                        GtkWidget *submenu);
    GtkWidget* gtk_menu_item_get_submenu (GtkMenuItem *menu_item);
    void gtk_menu_item_remove_submenu (GtkMenuItem *menu_item);
    void gtk_menu_item_select (GtkMenuItem *menu_item);
    void gtk_menu_item_deselect (GtkMenuItem *menu_item);
    void gtk_menu_item_activate (GtkMenuItem *menu_item);
    void gtk_menu_item_toggle_size_request (GtkMenuItem *menu_item,
                        gint *requisition);
    void gtk_menu_item_toggle_size_allocate (GtkMenuItem *menu_item,
                        gint allocation);
    void gtk_menu_item_set_right_justified (GtkMenuItem *menu_item,
                        gboolean right_justified);
    gboolean gtk_menu_item_get_right_justified (GtkMenuItem *menu_item);
    void gtk_menu_item_set_accel_path (GtkMenuItem *menu_item,
                            gchar *accel_path);


    void _gtk_menu_item_refresh_accel_path (GtkMenuItem *menu_item,
                            gchar *prefix,
                        GtkAccelGroup *accel_group,
                        gboolean group_changed);
    gboolean _gtk_menu_item_is_selectable (GtkWidget *menu_item);
    alias _GtkCheckMenuItem GtkCheckMenuItem;

    alias _GtkCheckMenuItemClass GtkCheckMenuItemClass;


    struct _GtkCheckMenuItem {
    GtkMenuItem menu_item;

    guint active;
    guint always_show_toggle;
    guint inconsistent;
    guint draw_as_radio;
    }

    struct _GtkCheckMenuItemClass {
    GtkMenuItemClass parent_class;

    void (* toggled) (GtkCheckMenuItem *check_menu_item);
    void (* draw_indicator) (GtkCheckMenuItem *check_menu_item,
                GdkRectangle *area);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_check_menu_item_get_type () ;

    GtkWidget* gtk_check_menu_item_new ();
    GtkWidget* gtk_check_menu_item_new_with_label ( gchar *label);
    GtkWidget* gtk_check_menu_item_new_with_mnemonic ( gchar *label);
    void gtk_check_menu_item_set_active (GtkCheckMenuItem *check_menu_item,
                            gboolean is_active);
    gboolean gtk_check_menu_item_get_active (GtkCheckMenuItem *check_menu_item);
    void gtk_check_menu_item_toggled (GtkCheckMenuItem *check_menu_item);
    void gtk_check_menu_item_set_inconsistent (GtkCheckMenuItem *check_menu_item,
                            gboolean setting);
    gboolean gtk_check_menu_item_get_inconsistent (GtkCheckMenuItem *check_menu_item);
    void gtk_check_menu_item_set_draw_as_radio (GtkCheckMenuItem *check_menu_item,
                            gboolean draw_as_radio);
    gboolean gtk_check_menu_item_get_draw_as_radio (GtkCheckMenuItem *check_menu_item);



    void gtk_check_menu_item_set_show_toggle (GtkCheckMenuItem *menu_item,
                            gboolean always);
    alias _GtkTargetList GtkTargetList;

    alias _GtkTargetEntry GtkTargetEntry;

    struct _GtkSelectionData {
    GdkAtom selection;
    GdkAtom target;
    GdkAtom type;
    gint format;
    guchar *data;
    gint length;
    GdkDisplay *display;
    }

    struct _GtkTargetEntry {
    gchar *target;
    guint flags;
    guint info;
    }





    alias _GtkTargetPair GtkTargetPair;



    struct _GtkTargetList {
    GList *list;
    guint ref_count;
    }

    struct _GtkTargetPair {
    GdkAtom target;
    guint flags;
    guint info;
    }

    GtkTargetList *gtk_target_list_new ( GtkTargetEntry *targets,
                        guint ntargets);
    void gtk_target_list_ref (GtkTargetList *list);
    void gtk_target_list_unref (GtkTargetList *list);
    void gtk_target_list_add (GtkTargetList *list,
                        GdkAtom target,
                        guint flags,
                        guint info);
    void gtk_target_list_add_table (GtkTargetList *list,
                        GtkTargetEntry *targets,
                        guint ntargets);
    void gtk_target_list_remove (GtkTargetList *list,
                        GdkAtom target);
    gboolean gtk_target_list_find (GtkTargetList *list,
                        GdkAtom target,
                        guint *info);



    gboolean gtk_selection_owner_set (GtkWidget *widget,
                        GdkAtom selection,
                        guint32 time_);
    gboolean gtk_selection_owner_set_for_display (GdkDisplay *display,
                        GtkWidget *widget,
                        GdkAtom selection,
                        guint32 time_);

    void gtk_selection_add_target (GtkWidget *widget,
                    GdkAtom selection,
                    GdkAtom target,
                    guint info);
    void gtk_selection_add_targets (GtkWidget *widget,
                    GdkAtom selection,
                    GtkTargetEntry *targets,
                    guint ntargets);
    void gtk_selection_clear_targets (GtkWidget *widget,
                    GdkAtom selection);
    gboolean gtk_selection_convert (GtkWidget *widget,
                    GdkAtom selection,
                    GdkAtom target,
                    guint32 time_);
    void gtk_selection_data_set (GtkSelectionData *selection_data,
                    GdkAtom type,
                    gint format,
                    guchar *data,
                    gint length);
    gboolean gtk_selection_data_set_text (GtkSelectionData *selection_data,
                    gchar *str,
                    gint len);
    guchar * gtk_selection_data_get_text (GtkSelectionData *selection_data);

    gboolean gtk_selection_data_get_targets (GtkSelectionData *selection_data,
                            GdkAtom **targets,
                            gint *n_atoms);
    gboolean gtk_selection_data_targets_include_text (GtkSelectionData *selection_data);



    void gtk_selection_remove_all (GtkWidget *widget);



    gboolean gtk_selection_clear (GtkWidget *widget,
                        GdkEventSelection *event);

    gboolean _gtk_selection_request (GtkWidget *widget,
                        GdkEventSelection *event);
    gboolean _gtk_selection_incr_event (GdkWindow *window,
                        GdkEventProperty *event);
    gboolean _gtk_selection_notify (GtkWidget *widget,
                        GdkEventSelection *event);
    gboolean _gtk_selection_property_notify (GtkWidget *widget,
                        GdkEventProperty *event);

    GType gtk_selection_data_get_type ();
    GtkSelectionData *gtk_selection_data_copy (GtkSelectionData *data);
    void gtk_selection_data_free (GtkSelectionData *data);





    alias void (* GtkClipboardReceivedFunc) (GtkClipboard *clipboard,
                            GtkSelectionData *selection_data,
                            gpointer data);
    alias void (* GtkClipboardTextReceivedFunc) (GtkClipboard *clipboard,
                            gchar *text,
                            gpointer data);
    alias void (* GtkClipboardTargetsReceivedFunc) (GtkClipboard *clipboard,
                            GdkAtom *atoms,
                            gint n_atoms,
                            gpointer data);





    alias void (* GtkClipboardGetFunc) (GtkClipboard *clipboard,
                        GtkSelectionData *selection_data,
                        guint info,
                        gpointer user_data_or_owner);
    alias void (* GtkClipboardClearFunc) (GtkClipboard *clipboard,
                        gpointer user_data_or_owner);

    GType gtk_clipboard_get_type ();

    GtkClipboard *gtk_clipboard_get_for_display (GdkDisplay *display,
                        GdkAtom selection);

    GtkClipboard *gtk_clipboard_get (GdkAtom selection);


    GdkDisplay *gtk_clipboard_get_display (GtkClipboard *clipboard);


    gboolean gtk_clipboard_set_with_data (GtkClipboard *clipboard,
                        GtkTargetEntry *targets,
                    guint n_targets,
                    GtkClipboardGetFunc get_func,
                    GtkClipboardClearFunc clear_func,
                    gpointer user_data);
    gboolean gtk_clipboard_set_with_owner (GtkClipboard *clipboard,
                        GtkTargetEntry *targets,
                    guint n_targets,
                    GtkClipboardGetFunc get_func,
                    GtkClipboardClearFunc clear_func,
                    GObject *owner);
    GObject *gtk_clipboard_get_owner (GtkClipboard *clipboard);
    void gtk_clipboard_clear (GtkClipboard *clipboard);
    void gtk_clipboard_set_text (GtkClipboard *clipboard,
                        gchar *text,
                    gint len);

    void gtk_clipboard_request_contents (GtkClipboard *clipboard,
                    GdkAtom target,
                    GtkClipboardReceivedFunc callback,
                    gpointer user_data);
    void gtk_clipboard_request_text (GtkClipboard *clipboard,
                    GtkClipboardTextReceivedFunc callback,
                    gpointer user_data);
    void gtk_clipboard_request_targets (GtkClipboard *clipboard,
                    GtkClipboardTargetsReceivedFunc callback,
                    gpointer user_data);

    GtkSelectionData *gtk_clipboard_wait_for_contents (GtkClipboard *clipboard,
                            GdkAtom target);
    gchar * gtk_clipboard_wait_for_text (GtkClipboard *clipboard);

    gboolean gtk_clipboard_wait_is_text_available (GtkClipboard *clipboard);

    gboolean gtk_clipboard_wait_for_targets (GtkClipboard *clipboard,
                        GdkAtom **targets,
                        gint *n_targets);
    alias _GtkRangeLayout GtkRangeLayout;
    alias void _GtkRangeLayout;

    alias _GtkRangeStepTimer GtkRangeStepTimer;
    alias void _GtkRangeStepTimer;


    alias _GtkRange GtkRange;

    alias _GtkRangeClass GtkRangeClass;


    struct _GtkRange {
    GtkWidget widget;

    GtkAdjustment *adjustment;
    GtkUpdateType update_policy;
    guint inverted;



    guint flippable;





    guint has_stepper_a;
    guint has_stepper_b;
    guint has_stepper_c;
    guint has_stepper_d;

    guint need_recalc;

    guint slider_size_fixed;

    gint min_slider_size;

    GtkOrientation orientation;


    GdkRectangle range_rect;

    gint slider_start, slider_end;


    gint round_digits;


    guint trough_click_forward;
    guint update_pending;
    GtkRangeLayout *layout;
    GtkRangeStepTimer *timer;
    gint slide_initial_slider_position;
    gint slide_initial_coordinate;
    guint update_timeout_id;
    GdkWindow *event_window;
    }

    struct _GtkRangeClass {
    GtkWidgetClass parent_class;


    gchar *slider_detail;
    gchar *stepper_detail;

    void (* value_changed) (GtkRange *range);
    void (* adjust_bounds) (GtkRange *range,
                gdouble new_value);


    void (* move_slider) (GtkRange *range,
                GtkScrollType scroll);


    void (* get_range_border) (GtkRange *range,
                GtkBorder *border_);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_range_get_type () ;

    void gtk_range_set_update_policy (GtkRange *range,
                        GtkUpdateType policy);
    GtkUpdateType gtk_range_get_update_policy (GtkRange *range);
    void gtk_range_set_adjustment (GtkRange *range,
                        GtkAdjustment *adjustment);
    GtkAdjustment* gtk_range_get_adjustment (GtkRange *range);
    void gtk_range_set_inverted (GtkRange *range,
                        gboolean setting);
    gboolean gtk_range_get_inverted (GtkRange *range);
    void gtk_range_set_increments (GtkRange *range,
                        gdouble step,
                        gdouble page);
    void gtk_range_set_range (GtkRange *range,
                        gdouble min,
                        gdouble max);
    void gtk_range_set_value (GtkRange *range,
                        gdouble value);
    gdouble gtk_range_get_value (GtkRange *range);
    alias _GtkScrollbar GtkScrollbar;

    alias _GtkScrollbarClass GtkScrollbarClass;


    struct _GtkScrollbar {
    GtkRange range;
    }

    struct _GtkScrollbarClass {
    GtkRangeClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_scrollbar_get_type () ;
    alias _GtkHScrollbar GtkHScrollbar;

    alias _GtkHScrollbarClass GtkHScrollbarClass;


    struct _GtkHScrollbar {
    GtkScrollbar scrollbar;
    }

    struct _GtkHScrollbarClass {
    GtkScrollbarClass parent_class;
    }


    GType gtk_hscrollbar_get_type () ;
    GtkWidget* gtk_hscrollbar_new (GtkAdjustment *adjustment);
    alias _GtkVScrollbar GtkVScrollbar;

    alias _GtkVScrollbarClass GtkVScrollbarClass;


    struct _GtkVScrollbar {
    GtkScrollbar scrollbar;
    }

    struct _GtkVScrollbarClass {
    GtkScrollbarClass parent_class;
    }







    GType gtk_vscrollbar_get_type () ;
    GtkWidget* gtk_vscrollbar_new (GtkAdjustment *adjustment);







    enum {
    GTK_CLIST_IN_DRAG = 1 << 0,
    GTK_CLIST_ROW_HEIGHT_SET = 1 << 1,
    GTK_CLIST_SHOW_TITLES = 1 << 2,

    GTK_CLIST_ADD_MODE = 1 << 4,
    GTK_CLIST_AUTO_SORT = 1 << 5,
    GTK_CLIST_AUTO_RESIZE_BLOCKED = 1 << 6,
    GTK_CLIST_REORDERABLE = 1 << 7,
    GTK_CLIST_USE_DRAG_ICONS = 1 << 8,
    GTK_CLIST_DRAW_DRAG_LINE = 1 << 9,
    GTK_CLIST_DRAW_DRAG_RECT = 1 << 10
    };


    enum GtkCellType {
    GTK_CELL_EMPTY,
    GTK_CELL_TEXT,
    GTK_CELL_PIXMAP,
    GTK_CELL_PIXTEXT,
    GTK_CELL_WIDGET
    };


    enum GtkCListDragPos {
    GTK_CLIST_DRAG_NONE,
    GTK_CLIST_DRAG_BEFORE,
    GTK_CLIST_DRAG_INTO,
    GTK_CLIST_DRAG_AFTER
    };


    enum GtkButtonAction {
    GTK_BUTTON_IGNORED = 0,
    GTK_BUTTON_SELECTS = 1 << 0,
    GTK_BUTTON_DRAGS = 1 << 1,
    GTK_BUTTON_EXPANDS = 1 << 2
    };

    alias _GtkCList GtkCList;

    alias _GtkCListClass GtkCListClass;

    alias _GtkCListColumn GtkCListColumn;

    alias _GtkCListRow GtkCListRow;


    alias _GtkCell GtkCell;

    alias _GtkCellText GtkCellText;

    alias _GtkCellPixmap GtkCellPixmap;

    alias _GtkCellPixText GtkCellPixText;

    alias _GtkCellWidget GtkCellWidget;


    alias gint (*GtkCListCompareFunc) (GtkCList *clist,
                    gpointer ptr1,
                    gpointer ptr2);

    alias _GtkCListCellInfo GtkCListCellInfo;

    alias _GtkCListDestInfo GtkCListDestInfo;


    struct _GtkCListCellInfo {
    gint row;
    gint column;
    }

    struct _GtkCListDestInfo {
    GtkCListCellInfo cell;
    GtkCListDragPos insert_pos;
    }

    struct _GtkCList {
    GtkContainer container;

    guint16 flags;


    GMemChunk *row_mem_chunk;
    GMemChunk *cell_mem_chunk;

    guint freeze_count;



    GdkRectangle internal_allocation;


    gint rows;
    gint row_height;
    GList *row_list;
    GList *row_list_end;


    gint columns;
    GdkRectangle column_title_area;
    GdkWindow *title_window;


    GtkCListColumn *column;



    GdkWindow *clist_window;
    gint clist_window_width;
    gint clist_window_height;


    gint hoffset;
    gint voffset;


    GtkShadowType shadow_type;


    GtkSelectionMode selection_mode;


    GList *selection;
    GList *selection_end;

    GList *undo_selection;
    GList *undo_unselection;
    gint undo_anchor;


    guint8 button_actions[5];

    guint8 drag_button;


    GtkCListCellInfo click_cell;


    GtkAdjustment *hadjustment;
    GtkAdjustment *vadjustment;


    GdkGC *xor_gc;


    GdkGC *fg_gc;
    GdkGC *bg_gc;


    GdkCursor *cursor_drag;


    gint x_drag;


    gint focus_row;

    gint focus_header_column;


    gint anchor;
    GtkStateType anchor_state;
    gint drag_pos;
    gint htimer;
    gint vtimer;

    GtkSortType sort_type;
    GtkCListCompareFunc compare;
    gint sort_column;

    gint drag_highlight_row;
    GtkCListDragPos drag_highlight_pos;
    }

    struct _GtkCListClass {
    GtkContainerClass parent_class;

    void (*set_scroll_adjustments) (GtkCList *clist,
                    GtkAdjustment *hadjustment,
                    GtkAdjustment *vadjustment);
    void (*refresh) (GtkCList *clist);
    void (*select_row) (GtkCList *clist,
                    gint row,
                    gint column,
                    GdkEvent *event);
    void (*unselect_row) (GtkCList *clist,
                    gint row,
                    gint column,
                    GdkEvent *event);
    void (*row_move) (GtkCList *clist,
                    gint source_row,
                    gint dest_row);
    void (*click_column) (GtkCList *clist,
                    gint column);
    void (*resize_column) (GtkCList *clist,
                    gint column,
                    gint width);
    void (*toggle_focus_row) (GtkCList *clist);
    void (*select_all) (GtkCList *clist);
    void (*unselect_all) (GtkCList *clist);
    void (*undo_selection) (GtkCList *clist);
    void (*start_selection) (GtkCList *clist);
    void (*end_selection) (GtkCList *clist);
    void (*extend_selection) (GtkCList *clist,
                    GtkScrollType scroll_type,
                    gfloat position,
                    gboolean auto_start_selection);
    void (*scroll_horizontal) (GtkCList *clist,
                    GtkScrollType scroll_type,
                    gfloat position);
    void (*scroll_vertical) (GtkCList *clist,
                    GtkScrollType scroll_type,
                    gfloat position);
    void (*toggle_add_mode) (GtkCList *clist);
    void (*abort_column_resize) (GtkCList *clist);
    void (*resync_selection) (GtkCList *clist,
                    GdkEvent *event);
    GList* (*selection_find) (GtkCList *clist,
                    gint row_number,
                    GList *row_list_element);
    void (*draw_row) (GtkCList *clist,
                    GdkRectangle *area,
                    gint row,
                    GtkCListRow *clist_row);
    void (*draw_drag_highlight) (GtkCList *clist,
                    GtkCListRow *target_row,
                    gint target_row_number,
                    GtkCListDragPos drag_pos);
    void (*clear) (GtkCList *clist);
    void (*fake_unselect_all) (GtkCList *clist,
                    gint row);
    void (*sort_list) (GtkCList *clist);
    gint (*insert_row) (GtkCList *clist,
                    gint row,
                    gchar *text[]);
    void (*remove_row) (GtkCList *clist,
                    gint row);
    void (*set_cell_contents) (GtkCList *clist,
                    GtkCListRow *clist_row,
                    gint column,
                    GtkCellType type,
                    gchar *text,
                    guint8 spacing,
                    GdkPixmap *pixmap,
                    GdkBitmap *mask);
    void (*cell_size_request) (GtkCList *clist,
                    GtkCListRow *clist_row,
                    gint column,
                    GtkRequisition *requisition);

    }

    struct _GtkCListColumn {
    gchar *title;
    GdkRectangle area;

    GtkWidget *button;
    GdkWindow *window;

    gint width;
    gint min_width;
    gint max_width;
    GtkJustification justification;

    guint visible;
    guint width_set;
    guint resizeable;
    guint auto_resize;
    guint button_passive;
    }

    struct _GtkCListRow {
    GtkCell *cell;
    GtkStateType state;

    GdkColor foreground;
    GdkColor background;

    GtkStyle *style;

    gpointer data;
    GtkDestroyNotify destroy;

    guint fg_set;
    guint bg_set;
    guint selectable;
    }


    struct _GtkCellText {
    GtkCellType type;

    gint16 vertical;
    gint16 horizontal;

    GtkStyle *style;

    gchar *text;
    }

    struct _GtkCellPixmap {
    GtkCellType type;

    gint16 vertical;
    gint16 horizontal;

    GtkStyle *style;

    GdkPixmap *pixmap;
    GdkBitmap *mask;
    }

    struct _GtkCellPixText {
    GtkCellType type;

    gint16 vertical;
    gint16 horizontal;

    GtkStyle *style;

    gchar *text;
    guint8 spacing;
    GdkPixmap *pixmap;
    GdkBitmap *mask;
    }

    struct _GtkCellWidget {
    GtkCellType type;

    gint16 vertical;
    gint16 horizontal;

    GtkStyle *style;

    GtkWidget *widget;
    }

    struct _GtkCell {
    GtkCellType type;

    gint16 vertical;
    gint16 horizontal;

    GtkStyle *style;

    union u_union  {
    gchar *text;

    struct pm_struct  {
    GdkPixmap *pixmap;
    GdkBitmap *mask;
    }

    struct pt_struct  {
    gchar *text;
    guint8 spacing;
    GdkPixmap *pixmap;
    GdkBitmap *mask;
    }

    GtkWidget *widget;
    }
    u_union u;
    }

    GtkType gtk_clist_get_type () ;


    GtkWidget* gtk_clist_new (gint columns);
    GtkWidget* gtk_clist_new_with_titles (gint columns,
                    gchar *titles[]);


    void gtk_clist_set_hadjustment (GtkCList *clist,
                    GtkAdjustment *adjustment);
    void gtk_clist_set_vadjustment (GtkCList *clist,
                    GtkAdjustment *adjustment);


    GtkAdjustment* gtk_clist_get_hadjustment (GtkCList *clist);
    GtkAdjustment* gtk_clist_get_vadjustment (GtkCList *clist);


    void gtk_clist_set_shadow_type (GtkCList *clist,
                    GtkShadowType type);


    void gtk_clist_set_selection_mode (GtkCList *clist,
                    GtkSelectionMode mode);


    void gtk_clist_set_reorderable (GtkCList *clist,
                    gboolean reorderable);
    void gtk_clist_set_use_drag_icons (GtkCList *clist,
                    gboolean use_icons);
    void gtk_clist_set_button_actions (GtkCList *clist,
                    guint button,
                    guint8 button_actions);





    void gtk_clist_freeze (GtkCList *clist);
    void gtk_clist_thaw (GtkCList *clist);


    void gtk_clist_column_titles_show (GtkCList *clist);
    void gtk_clist_column_titles_hide (GtkCList *clist);





    void gtk_clist_column_title_active (GtkCList *clist,
                    gint column);
    void gtk_clist_column_title_passive (GtkCList *clist,
                    gint column);
    void gtk_clist_column_titles_active (GtkCList *clist);
    void gtk_clist_column_titles_passive (GtkCList *clist);


    void gtk_clist_set_column_title (GtkCList *clist,
                    gint column,
                    gchar *title);


    gchar * gtk_clist_get_column_title (GtkCList *clist,
                    gint column);


    void gtk_clist_set_column_widget (GtkCList *clist,
                    gint column,
                    GtkWidget *widget);


    GtkWidget * gtk_clist_get_column_widget (GtkCList *clist,
                        gint column);


    void gtk_clist_set_column_justification (GtkCList *clist,
                        gint column,
                        GtkJustification justification);


    void gtk_clist_set_column_visibility (GtkCList *clist,
                    gint column,
                    gboolean visible);


    void gtk_clist_set_column_resizeable (GtkCList *clist,
                    gint column,
                    gboolean resizeable);


    void gtk_clist_set_column_auto_resize (GtkCList *clist,
                    gint column,
                    gboolean auto_resize);

    gint gtk_clist_columns_autosize (GtkCList *clist);


    gint gtk_clist_optimal_column_width (GtkCList *clist,
                    gint column);





    void gtk_clist_set_column_width (GtkCList *clist,
                    gint column,
                    gint width);


    void gtk_clist_set_column_min_width (GtkCList *clist,
                    gint column,
                    gint min_width);
    void gtk_clist_set_column_max_width (GtkCList *clist,
                    gint column,
                    gint max_width);




    void gtk_clist_set_row_height (GtkCList *clist,
                guint height);






    void gtk_clist_moveto (GtkCList *clist,
            gint row,
            gint column,
            gfloat row_align,
            gfloat col_align);


    GtkVisibility gtk_clist_row_is_visible (GtkCList *clist,
                        gint row);


    GtkCellType gtk_clist_get_cell_type (GtkCList *clist,
                    gint row,
                    gint column);


    void gtk_clist_set_text (GtkCList *clist,
                gint row,
                gint column,
                gchar *text);




    gint gtk_clist_get_text (GtkCList *clist,
                gint row,
                gint column,
                gchar **text);


    void gtk_clist_set_pixmap (GtkCList *clist,
                gint row,
                gint column,
                GdkPixmap *pixmap,
                GdkBitmap *mask);

    gint gtk_clist_get_pixmap (GtkCList *clist,
                gint row,
                gint column,
                GdkPixmap **pixmap,
                GdkBitmap **mask);


    void gtk_clist_set_pixtext (GtkCList *clist,
                gint row,
                gint column,
                gchar *text,
                guint8 spacing,
                GdkPixmap *pixmap,
                GdkBitmap *mask);

    gint gtk_clist_get_pixtext (GtkCList *clist,
                gint row,
                gint column,
                gchar **text,
                guint8 *spacing,
                GdkPixmap **pixmap,
                GdkBitmap **mask);




    void gtk_clist_set_foreground (GtkCList *clist,
                gint row,
                    GdkColor *color);




    void gtk_clist_set_background (GtkCList *clist,
                gint row,
                    GdkColor *color);


    void gtk_clist_set_cell_style (GtkCList *clist,
                gint row,
                gint column,
                GtkStyle *style);

    GtkStyle *gtk_clist_get_cell_style (GtkCList *clist,
                    gint row,
                    gint column);

    void gtk_clist_set_row_style (GtkCList *clist,
                gint row,
                GtkStyle *style);

    GtkStyle *gtk_clist_get_row_style (GtkCList *clist,
                    gint row);





    void gtk_clist_set_shift (GtkCList *clist,
                gint row,
                gint column,
                gint vertical,
                gint horizontal);


    void gtk_clist_set_selectable (GtkCList *clist,
                gint row,
                gboolean selectable);
    gboolean gtk_clist_get_selectable (GtkCList *clist,
                    gint row);




    gint gtk_clist_prepend (GtkCList *clist,
                gchar *text[]);
    gint gtk_clist_append (GtkCList *clist,
                gchar *text[]);




    gint gtk_clist_insert (GtkCList *clist,
            gint row,
            gchar *text[]);


    void gtk_clist_remove (GtkCList *clist,
            gint row);


    void gtk_clist_set_row_data (GtkCList *clist,
                gint row,
                gpointer data);


    void gtk_clist_set_row_data_full (GtkCList *clist,
                    gint row,
                    gpointer data,
                    GtkDestroyNotify destroy);


    gpointer gtk_clist_get_row_data (GtkCList *clist,
                    gint row);




    gint gtk_clist_find_row_from_data (GtkCList *clist,
                    gpointer data);


    void gtk_clist_select_row (GtkCList *clist,
                gint row,
                gint column);


    void gtk_clist_unselect_row (GtkCList *clist,
                gint row,
                gint column);


    void gtk_clist_undo_selection (GtkCList *clist);




    void gtk_clist_clear (GtkCList *clist);





    gint gtk_clist_get_selection_info (GtkCList *clist,
                    gint x,
                    gint y,
                    gint *row,
                    gint *column);


    void gtk_clist_select_all (GtkCList *clist);


    void gtk_clist_unselect_all (GtkCList *clist);


    void gtk_clist_swap_rows (GtkCList *clist,
                gint row1,
                gint row2);


    void gtk_clist_row_move (GtkCList *clist,
                gint source_row,
                gint dest_row);


    void gtk_clist_set_compare_func (GtkCList *clist,
                    GtkCListCompareFunc cmp_func);


    void gtk_clist_set_sort_column (GtkCList *clist,
                    gint column);


    void gtk_clist_set_sort_type (GtkCList *clist,
                GtkSortType sort_type);


    void gtk_clist_sort (GtkCList *clist);


    void gtk_clist_set_auto_sort (GtkCList *clist,
                gboolean auto_sort);



    PangoLayout *_gtk_clist_create_cell_layout (GtkCList *clist,
                        GtkCListRow *clist_row,
                        gint column);

    alias _GtkColorButton GtkColorButton;

    alias _GtkColorButtonClass GtkColorButtonClass;

    alias _GtkColorButtonPrivate GtkColorButtonPrivate;
    alias void _GtkColorButtonPrivate;


    struct _GtkColorButton {
    GtkButton button;



    GtkColorButtonPrivate *priv;
    }

    struct _GtkColorButtonClass {
    GtkButtonClass parent_class;

    void (* color_set) (GtkColorButton *cp);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_color_button_get_type () ;
    GtkWidget *gtk_color_button_new ();
    GtkWidget *gtk_color_button_new_with_color ( GdkColor *color);
    void gtk_color_button_set_color (GtkColorButton *color_button,
                        GdkColor *color);
    void gtk_color_button_set_alpha (GtkColorButton *color_button,
                        guint16 alpha);
    void gtk_color_button_get_color (GtkColorButton *color_button,
                        GdkColor *color);
    guint16 gtk_color_button_get_alpha (GtkColorButton *color_button);
    void gtk_color_button_set_use_alpha (GtkColorButton *color_button,
                        gboolean use_alpha);
    gboolean gtk_color_button_get_use_alpha (GtkColorButton *color_button);
    void gtk_color_button_set_title (GtkColorButton *color_button,
                        gchar *title);
    gchar *gtk_color_button_get_title (GtkColorButton *color_button);



    enum GtkDialogFlags {
    GTK_DIALOG_MODAL = 1 << 0,
    GTK_DIALOG_DESTROY_WITH_PARENT = 1 << 1,
    GTK_DIALOG_NO_SEPARATOR = 1 << 2
    };

    enum GtkResponseType {



    GTK_RESPONSE_NONE = -1,





    GTK_RESPONSE_REJECT = -2,
    GTK_RESPONSE_ACCEPT = -3,


    GTK_RESPONSE_DELETE_EVENT = -4,




    GTK_RESPONSE_OK = -5,
    GTK_RESPONSE_CANCEL = -6,
    GTK_RESPONSE_CLOSE = -7,
    GTK_RESPONSE_YES = -8,
    GTK_RESPONSE_NO = -9,
    GTK_RESPONSE_APPLY = -10,
    GTK_RESPONSE_HELP = -11
    };

    alias _GtkDialog GtkDialog;

    alias _GtkDialogClass GtkDialogClass;


    struct _GtkDialog {
    GtkWindow window;


    GtkWidget *vbox;
    GtkWidget *action_area;


    GtkWidget *separator;
    }

    struct _GtkDialogClass {
    GtkWindowClass parent_class;

    void (* response) (GtkDialog *dialog, gint response_id);



    void (* close) (GtkDialog *dialog);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_dialog_get_type () ;
    GtkWidget* gtk_dialog_new ();

    GtkWidget* gtk_dialog_new_with_buttons ( gchar *title,
                        GtkWindow *parent,
                        GtkDialogFlags flags,
                        gchar *first_button_text,
                        ...);

    void gtk_dialog_add_action_widget (GtkDialog *dialog,
                        GtkWidget *child,
                        gint response_id);
    GtkWidget* gtk_dialog_add_button (GtkDialog *dialog,
                        gchar *button_text,
                        gint response_id);
    void gtk_dialog_add_buttons (GtkDialog *dialog,
                        gchar *first_button_text,
                        ...);

    void gtk_dialog_set_response_sensitive (GtkDialog *dialog,
                        gint response_id,
                        gboolean setting);
    void gtk_dialog_set_default_response (GtkDialog *dialog,
                        gint response_id);

    void gtk_dialog_set_has_separator (GtkDialog *dialog,
                    gboolean setting);
    gboolean gtk_dialog_get_has_separator (GtkDialog *dialog);


    void gtk_dialog_response (GtkDialog *dialog,
                    gint response_id);


    gint gtk_dialog_run (GtkDialog *dialog);



    void _gtk_dialog_set_ignore_separator (GtkDialog *dialog,
                    gboolean ignore_separator);
    gint _gtk_dialog_get_response_for_widget (GtkDialog *dialog,
                        GtkWidget *widget);
    alias _GtkVBox GtkVBox;

    alias _GtkVBoxClass GtkVBoxClass;


    struct _GtkVBox {
    GtkBox box;
    }

    struct _GtkVBoxClass {
    GtkBoxClass parent_class;
    }


    GType gtk_vbox_get_type () ;
    GtkWidget* gtk_vbox_new (gboolean homogeneous,
                gint spacing);
    alias _GtkColorSelection GtkColorSelection;

    alias _GtkColorSelectionClass GtkColorSelectionClass;



    alias void (* GtkColorSelectionChangePaletteFunc) ( GdkColor *colors,
                            gint n_colors);
    alias void (* GtkColorSelectionChangePaletteWithScreenFunc) (GdkScreen *screen,
                                    GdkColor *colors,
                                gint n_colors);

    struct _GtkColorSelection {
    GtkVBox parent_instance;


    gpointer private_data;
    }

    struct _GtkColorSelectionClass {
    GtkVBoxClass parent_class;

    void (*color_changed) (GtkColorSelection *color_selection);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }




    GType gtk_color_selection_get_type () ;
    GtkWidget *gtk_color_selection_new ();
    gboolean gtk_color_selection_get_has_opacity_control (GtkColorSelection *colorsel);
    void gtk_color_selection_set_has_opacity_control (GtkColorSelection *colorsel,
                                gboolean has_opacity);
    gboolean gtk_color_selection_get_has_palette (GtkColorSelection *colorsel);
    void gtk_color_selection_set_has_palette (GtkColorSelection *colorsel,
                                gboolean has_palette);


    void gtk_color_selection_set_current_color (GtkColorSelection *colorsel,
                            GdkColor *color);
    void gtk_color_selection_set_current_alpha (GtkColorSelection *colorsel,
                            guint16 alpha);
    void gtk_color_selection_get_current_color (GtkColorSelection *colorsel,
                            GdkColor *color);
    guint16 gtk_color_selection_get_current_alpha (GtkColorSelection *colorsel);
    void gtk_color_selection_set_previous_color (GtkColorSelection *colorsel,
                            GdkColor *color);
    void gtk_color_selection_set_previous_alpha (GtkColorSelection *colorsel,
                            guint16 alpha);
    void gtk_color_selection_get_previous_color (GtkColorSelection *colorsel,
                            GdkColor *color);
    guint16 gtk_color_selection_get_previous_alpha (GtkColorSelection *colorsel);

    gboolean gtk_color_selection_is_adjusting (GtkColorSelection *colorsel);

    gboolean gtk_color_selection_palette_from_string ( gchar *str,
                            GdkColor **colors,
                            gint *n_colors);
    gchar* gtk_color_selection_palette_to_string ( GdkColor *colors,
                            gint n_colors);



    GtkColorSelectionChangePaletteFunc gtk_color_selection_set_change_palette_hook (GtkColorSelectionChangePaletteFunc func);



    GtkColorSelectionChangePaletteWithScreenFunc gtk_color_selection_set_change_palette_with_screen_hook (GtkColorSelectionChangePaletteWithScreenFunc func);



    void gtk_color_selection_set_color (GtkColorSelection *colorsel,
                        gdouble *color);
    void gtk_color_selection_get_color (GtkColorSelection *colorsel,
                        gdouble *color);
    void gtk_color_selection_set_update_policy (GtkColorSelection *colorsel,
                        GtkUpdateType policy);
    alias _GtkColorSelectionDialog GtkColorSelectionDialog;

    alias _GtkColorSelectionDialogClass GtkColorSelectionDialogClass;



    struct _GtkColorSelectionDialog {
    GtkDialog parent_instance;

    GtkWidget *colorsel;
    GtkWidget *ok_button;
    GtkWidget *cancel_button;
    GtkWidget *help_button;
    }

    struct _GtkColorSelectionDialogClass {
    GtkDialogClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }



    GType gtk_color_selection_dialog_get_type () ;
    GtkWidget* gtk_color_selection_dialog_new ( gchar *title);
    alias _GtkHBox GtkHBox;

    alias _GtkHBoxClass GtkHBoxClass;


    struct _GtkHBox {
    GtkBox box;
    }

    struct _GtkHBoxClass {
    GtkBoxClass parent_class;
    }


    GType gtk_hbox_get_type () ;
    GtkWidget* gtk_hbox_new (gboolean homogeneous,
                gint spacing);
    alias _GtkCombo GtkCombo;

    alias _GtkComboClass GtkComboClass;



    struct _GtkCombo {
        GtkHBox hbox;


        GtkWidget *entry;


        GtkWidget *button;
        GtkWidget *popup;
        GtkWidget *popwin;


        GtkWidget *list;


        guint entry_change_id;
        guint list_change_id;

        guint value_in_list;
        guint ok_if_empty;
        guint case_sensitive;
        guint use_arrows;
        guint use_arrows_always;

        guint16 current_button;
        guint activate_id;
    }

    struct _GtkComboClass {
        GtkHBoxClass parent_class;


        void (*_gtk_reserved1) ();
        void (*_gtk_reserved2) ();
        void (*_gtk_reserved3) ();
        void (*_gtk_reserved4) ();
    }

    GType gtk_combo_get_type () ;

    GtkWidget* gtk_combo_new ();

    void gtk_combo_set_value_in_list (GtkCombo* combo,
                        gboolean val,
                        gboolean ok_if_empty);

    void gtk_combo_set_use_arrows (GtkCombo* combo,
                        gboolean val);

    void gtk_combo_set_use_arrows_always (GtkCombo* combo,
                        gboolean val);

    void gtk_combo_set_case_sensitive (GtkCombo* combo,
                        gboolean val);


    void gtk_combo_set_item_string (GtkCombo* combo,
                        GtkItem* item,
                        gchar* item_value);

    void gtk_combo_set_popdown_strings (GtkCombo* combo,
                        GList *strings);

    void gtk_combo_disable_activate (GtkCombo* combo);
    enum GtkDestDefaults {
    GTK_DEST_DEFAULT_MOTION = 1 << 0,
    GTK_DEST_DEFAULT_HIGHLIGHT = 1 << 1,
    GTK_DEST_DEFAULT_DROP = 1 << 2,
    GTK_DEST_DEFAULT_ALL = 0x07
    };




    enum GtkTargetFlags {
    GTK_TARGET_SAME_APP = 1 << 0,
    GTK_TARGET_SAME_WIDGET = 1 << 1
    };




    void gtk_drag_get_data (GtkWidget *widget,
                GdkDragContext *context,
                GdkAtom target,
                guint32 time_);
    void gtk_drag_finish (GdkDragContext *context,
                gboolean success,
                gboolean del,
                guint32 time_);

    GtkWidget *gtk_drag_get_source_widget (GdkDragContext *context);

    void gtk_drag_highlight (GtkWidget *widget);
    void gtk_drag_unhighlight (GtkWidget *widget);

    void gtk_drag_dest_set (GtkWidget *widget,
                GtkDestDefaults flags,
                GtkTargetEntry *targets,
                gint n_targets,
                GdkDragAction actions);

    void gtk_drag_dest_set_proxy (GtkWidget *widget,
                GdkWindow *proxy_window,
                GdkDragProtocol protocol,
                gboolean use_coordinates);

    void gtk_drag_dest_unset (GtkWidget *widget);

    GdkAtom gtk_drag_dest_find_target (GtkWidget *widget,
                        GdkDragContext *context,
                        GtkTargetList *target_list);
    GtkTargetList* gtk_drag_dest_get_target_list (GtkWidget *widget);
    void gtk_drag_dest_set_target_list (GtkWidget *widget,
                        GtkTargetList *target_list);



    void gtk_drag_source_set (GtkWidget *widget,
                GdkModifierType start_button_mask,
                GtkTargetEntry *targets,
                gint n_targets,
                GdkDragAction actions);

    void gtk_drag_source_unset (GtkWidget *widget);

    GtkTargetList* gtk_drag_source_get_target_list (GtkWidget *widget);
    void gtk_drag_source_set_target_list (GtkWidget *widget,
                            GtkTargetList *target_list);

    void gtk_drag_source_set_icon (GtkWidget *widget,
                    GdkColormap *colormap,
                    GdkPixmap *pixmap,
                    GdkBitmap *mask);
    void gtk_drag_source_set_icon_pixbuf (GtkWidget *widget,
                    GdkPixbuf *pixbuf);
    void gtk_drag_source_set_icon_stock (GtkWidget *widget,
                    gchar *stock_id);





    GdkDragContext *gtk_drag_begin (GtkWidget *widget,
                    GtkTargetList *targets,
                    GdkDragAction actions,
                    gint button,
                    GdkEvent *event);



    void gtk_drag_set_icon_widget (GdkDragContext *context,
                GtkWidget *widget,
                gint hot_x,
                gint hot_y);
    void gtk_drag_set_icon_pixmap (GdkDragContext *context,
                GdkColormap *colormap,
                GdkPixmap *pixmap,
                GdkBitmap *mask,
                gint hot_x,
                gint hot_y);
    void gtk_drag_set_icon_pixbuf (GdkDragContext *context,
                GdkPixbuf *pixbuf,
                gint hot_x,
                gint hot_y);
    void gtk_drag_set_icon_stock (GdkDragContext *context,
                    gchar *stock_id,
                gint hot_x,
                gint hot_y);

    void gtk_drag_set_icon_default (GdkDragContext *context);

    gboolean gtk_drag_check_threshold (GtkWidget *widget,
                    gint start_x,
                    gint start_y,
                    gint current_x,
                    gint current_y);


    void _gtk_drag_source_handle_event (GtkWidget *widget,
                    GdkEvent *event);
    void _gtk_drag_dest_handle_event (GtkWidget *toplevel,
                    GdkEvent *event);


    void gtk_drag_set_default_icon (GdkColormap *colormap,
                    GdkPixmap *pixmap,
                    GdkBitmap *mask,
                    gint hot_x,
                    gint hot_y);





    enum GtkTreeViewDropPosition {

    GTK_TREE_VIEW_DROP_BEFORE,
    GTK_TREE_VIEW_DROP_AFTER,



    GTK_TREE_VIEW_DROP_INTO_OR_BEFORE,
    GTK_TREE_VIEW_DROP_INTO_OR_AFTER
    };

    alias _GtkTreeView GtkTreeView;

    alias _GtkTreeViewClass GtkTreeViewClass;

    alias _GtkTreeViewPrivate GtkTreeViewPrivate;
    alias void _GtkTreeViewPrivate;

    alias _GtkTreeSelection GtkTreeSelection;

    alias _GtkTreeSelectionClass GtkTreeSelectionClass;


    struct _GtkTreeView {
    GtkContainer parent;

    GtkTreeViewPrivate *priv;
    }

    struct _GtkTreeViewClass {
    GtkContainerClass parent_class;

    void (* set_scroll_adjustments) (GtkTreeView *tree_view,
                        GtkAdjustment *hadjustment,
                        GtkAdjustment *vadjustment);
    void (* row_activated) (GtkTreeView *tree_view,
                        GtkTreePath *path,
                        GtkTreeViewColumn *column);
    gboolean (* test_expand_row) (GtkTreeView *tree_view,
                        GtkTreeIter *iter,
                        GtkTreePath *path);
    gboolean (* test_collapse_row) (GtkTreeView *tree_view,
                        GtkTreeIter *iter,
                        GtkTreePath *path);
    void (* row_expanded) (GtkTreeView *tree_view,
                        GtkTreeIter *iter,
                        GtkTreePath *path);
    void (* row_collapsed) (GtkTreeView *tree_view,
                        GtkTreeIter *iter,
                        GtkTreePath *path);
    void (* columns_changed) (GtkTreeView *tree_view);
    void (* cursor_changed) (GtkTreeView *tree_view);


    gboolean (* move_cursor) (GtkTreeView *tree_view,
                        GtkMovementStep step,
                        gint count);
    gboolean (* select_all) (GtkTreeView *tree_view);
    gboolean (* unselect_all) (GtkTreeView *tree_view);
    gboolean (* select_cursor_row) (GtkTreeView *tree_view,
                        gboolean start_editing);
    gboolean (* toggle_cursor_row) (GtkTreeView *tree_view);
    gboolean (* expand_collapse_cursor_row) (GtkTreeView *tree_view,
                        gboolean logical,
                        gboolean expand,
                        gboolean open_all);
    gboolean (* select_cursor_parent) (GtkTreeView *tree_view);
    gboolean (* start_interactive_search) (GtkTreeView *tree_view);


    void (*_gtk_reserved0) ();
    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    alias gboolean (* GtkTreeViewColumnDropFunc) (GtkTreeView *tree_view,
                            GtkTreeViewColumn *column,
                            GtkTreeViewColumn *prev_column,
                            GtkTreeViewColumn *next_column,
                            gpointer data);
    alias void (* GtkTreeViewMappingFunc) (GtkTreeView *tree_view,
                            GtkTreePath *path,
                            gpointer user_data);
    alias gboolean (*GtkTreeViewSearchEqualFunc) (GtkTreeModel *model,
                            gint column,
                            gchar *key,
                            GtkTreeIter *iter,
                            gpointer search_data);



    GType gtk_tree_view_get_type ();
    GtkWidget *gtk_tree_view_new ();
    GtkWidget *gtk_tree_view_new_with_model (GtkTreeModel *model);


    GtkTreeModel *gtk_tree_view_get_model (GtkTreeView *tree_view);
    void gtk_tree_view_set_model (GtkTreeView *tree_view,
                                    GtkTreeModel *model);
    GtkTreeSelection *gtk_tree_view_get_selection (GtkTreeView *tree_view);
    GtkAdjustment *gtk_tree_view_get_hadjustment (GtkTreeView *tree_view);
    void gtk_tree_view_set_hadjustment (GtkTreeView *tree_view,
                                    GtkAdjustment *adjustment);
    GtkAdjustment *gtk_tree_view_get_vadjustment (GtkTreeView *tree_view);
    void gtk_tree_view_set_vadjustment (GtkTreeView *tree_view,
                                    GtkAdjustment *adjustment);
    gboolean gtk_tree_view_get_headers_visible (GtkTreeView *tree_view);
    void gtk_tree_view_set_headers_visible (GtkTreeView *tree_view,
                                    gboolean headers_visible);
    void gtk_tree_view_columns_autosize (GtkTreeView *tree_view);
    void gtk_tree_view_set_headers_clickable (GtkTreeView *tree_view,
                                    gboolean setting);
    void gtk_tree_view_set_rules_hint (GtkTreeView *tree_view,
                                    gboolean setting);
    gboolean gtk_tree_view_get_rules_hint (GtkTreeView *tree_view);


    gint gtk_tree_view_append_column (GtkTreeView *tree_view,
                                    GtkTreeViewColumn *column);
    gint gtk_tree_view_remove_column (GtkTreeView *tree_view,
                                    GtkTreeViewColumn *column);
    gint gtk_tree_view_insert_column (GtkTreeView *tree_view,
                                    GtkTreeViewColumn *column,
                                    gint position);
    gint gtk_tree_view_insert_column_with_attributes (GtkTreeView *tree_view,
                                    gint position,
                                    gchar *title,
                                    GtkCellRenderer *cell,
                                    ...);
    gint gtk_tree_view_insert_column_with_data_func (GtkTreeView *tree_view,
                                    gint position,
                                    gchar *title,
                                    GtkCellRenderer *cell,
                                    GtkTreeCellDataFunc func,
                                    gpointer data,
                                    GDestroyNotify dnotify);
    GtkTreeViewColumn *gtk_tree_view_get_column (GtkTreeView *tree_view,
                                    gint n);
    GList *gtk_tree_view_get_columns (GtkTreeView *tree_view);
    void gtk_tree_view_move_column_after (GtkTreeView *tree_view,
                                    GtkTreeViewColumn *column,
                                    GtkTreeViewColumn *base_column);
    void gtk_tree_view_set_expander_column (GtkTreeView *tree_view,
                                    GtkTreeViewColumn *column);
    GtkTreeViewColumn *gtk_tree_view_get_expander_column (GtkTreeView *tree_view);
    void gtk_tree_view_set_column_drag_function (GtkTreeView *tree_view,
                                    GtkTreeViewColumnDropFunc func,
                                    gpointer user_data,
                                    GtkDestroyNotify destroy);


    void gtk_tree_view_scroll_to_point (GtkTreeView *tree_view,
                                    gint tree_x,
                                    gint tree_y);
    void gtk_tree_view_scroll_to_cell (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    GtkTreeViewColumn *column,
                                    gboolean use_align,
                                    gfloat row_align,
                                    gfloat col_align);
    void gtk_tree_view_row_activated (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    GtkTreeViewColumn *column);
    void gtk_tree_view_expand_all (GtkTreeView *tree_view);
    void gtk_tree_view_collapse_all (GtkTreeView *tree_view);
    void gtk_tree_view_expand_to_path (GtkTreeView *tree_view,
                                    GtkTreePath *path);
    gboolean gtk_tree_view_expand_row (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    gboolean open_all);
    gboolean gtk_tree_view_collapse_row (GtkTreeView *tree_view,
                                    GtkTreePath *path);
    void gtk_tree_view_map_expanded_rows (GtkTreeView *tree_view,
                                    GtkTreeViewMappingFunc func,
                                    gpointer data);
    gboolean gtk_tree_view_row_expanded (GtkTreeView *tree_view,
                                    GtkTreePath *path);
    void gtk_tree_view_set_reorderable (GtkTreeView *tree_view,
                                    gboolean reorderable);
    gboolean gtk_tree_view_get_reorderable (GtkTreeView *tree_view);
    void gtk_tree_view_set_cursor (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    GtkTreeViewColumn *focus_column,
                                    gboolean start_editing);
    void gtk_tree_view_set_cursor_on_cell (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    GtkTreeViewColumn *focus_column,
                                    GtkCellRenderer *focus_cell,
                                    gboolean start_editing);
    void gtk_tree_view_get_cursor (GtkTreeView *tree_view,
                                    GtkTreePath **path,
                                    GtkTreeViewColumn **focus_column);



    GdkWindow *gtk_tree_view_get_bin_window (GtkTreeView *tree_view);
    gboolean gtk_tree_view_get_path_at_pos (GtkTreeView *tree_view,
                                    gint x,
                                    gint y,
                                    GtkTreePath **path,
                                    GtkTreeViewColumn **column,
                                    gint *cell_x,
                                    gint *cell_y);
    void gtk_tree_view_get_cell_area (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    GtkTreeViewColumn *column,
                                    GdkRectangle *rect);
    void gtk_tree_view_get_background_area (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    GtkTreeViewColumn *column,
                                    GdkRectangle *rect);
    void gtk_tree_view_get_visible_rect (GtkTreeView *tree_view,
                                    GdkRectangle *visible_rect);
    void gtk_tree_view_widget_to_tree_coords (GtkTreeView *tree_view,
                                    gint wx,
                                    gint wy,
                                    gint *tx,
                                    gint *ty);
    void gtk_tree_view_tree_to_widget_coords (GtkTreeView *tree_view,
                                    gint tx,
                                    gint ty,
                                    gint *wx,
                                    gint *wy);


    void gtk_tree_view_enable_model_drag_source (GtkTreeView *tree_view,
                                    GdkModifierType start_button_mask,
                                    GtkTargetEntry *targets,
                                    gint n_targets,
                                    GdkDragAction actions);
    void gtk_tree_view_enable_model_drag_dest (GtkTreeView *tree_view,
                                    GtkTargetEntry *targets,
                                    gint n_targets,
                                    GdkDragAction actions);
    void gtk_tree_view_unset_rows_drag_source (GtkTreeView *tree_view);
    void gtk_tree_view_unset_rows_drag_dest (GtkTreeView *tree_view);



    void gtk_tree_view_set_drag_dest_row (GtkTreeView *tree_view,
                                    GtkTreePath *path,
                                    GtkTreeViewDropPosition pos);
    void gtk_tree_view_get_drag_dest_row (GtkTreeView *tree_view,
                                    GtkTreePath **path,
                                    GtkTreeViewDropPosition *pos);
    gboolean gtk_tree_view_get_dest_row_at_pos (GtkTreeView *tree_view,
                                    gint drag_x,
                                    gint drag_y,
                                    GtkTreePath **path,
                                    GtkTreeViewDropPosition *pos);
    GdkPixmap *gtk_tree_view_create_row_drag_icon (GtkTreeView *tree_view,
                                    GtkTreePath *path);


    void gtk_tree_view_set_enable_search (GtkTreeView *tree_view,
                                    gboolean enable_search);
    gboolean gtk_tree_view_get_enable_search (GtkTreeView *tree_view);
    gint gtk_tree_view_get_search_column (GtkTreeView *tree_view);
    void gtk_tree_view_set_search_column (GtkTreeView *tree_view,
                                    gint column);
    GtkTreeViewSearchEqualFunc gtk_tree_view_get_search_equal_func (GtkTreeView *tree_view);
    void gtk_tree_view_set_search_equal_func (GtkTreeView *tree_view,
                                    GtkTreeViewSearchEqualFunc search_equal_func,
                                    gpointer search_user_data,
                                    GtkDestroyNotify search_destroy);



    alias void (* GtkTreeDestroyCountFunc) (GtkTreeView *tree_view,
                        GtkTreePath *path,
                        gint children,
                        gpointer user_data);
    void gtk_tree_view_set_destroy_count_func (GtkTreeView *tree_view,
                        GtkTreeDestroyCountFunc func,
                        gpointer data,
                        GtkDestroyNotify destroy);


    alias _GtkComboBox GtkComboBox;

    alias _GtkComboBoxClass GtkComboBoxClass;

    alias _GtkComboBoxPrivate GtkComboBoxPrivate;
    alias void _GtkComboBoxPrivate;


    struct _GtkComboBox {
    GtkBin parent_instance;


    GtkComboBoxPrivate *priv;
    }

    struct _GtkComboBoxClass {
    GtkBinClass parent_class;


    void (* changed) (GtkComboBox *combo_box);


    void (*_gtk_reserved0) ();
    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    }



    GType gtk_combo_box_get_type ();
    GtkWidget *gtk_combo_box_new ();
    GtkWidget *gtk_combo_box_new_with_model (GtkTreeModel *model);


    void gtk_combo_box_set_wrap_width (GtkComboBox *combo_box,
                            gint width);
    void gtk_combo_box_set_row_span_column (GtkComboBox *combo_box,
                            gint row_span);
    void gtk_combo_box_set_column_span_column (GtkComboBox *combo_box,
                            gint column_span);


    gint gtk_combo_box_get_active (GtkComboBox *combo_box);
    void gtk_combo_box_set_active (GtkComboBox *combo_box,
                        gint index_);
    gboolean gtk_combo_box_get_active_iter (GtkComboBox *combo_box,
                        GtkTreeIter *iter);
    void gtk_combo_box_set_active_iter (GtkComboBox *combo_box,
                        GtkTreeIter *iter);


    void gtk_combo_box_set_model (GtkComboBox *combo_box,
                        GtkTreeModel *model);
    GtkTreeModel *gtk_combo_box_get_model (GtkComboBox *combo_box);


    GtkWidget *gtk_combo_box_new_text ();
    void gtk_combo_box_append_text (GtkComboBox *combo_box,
                        gchar *text);
    void gtk_combo_box_insert_text (GtkComboBox *combo_box,
                        gint position,
                        gchar *text);
    void gtk_combo_box_prepend_text (GtkComboBox *combo_box,
                        gchar *text);
    void gtk_combo_box_remove_text (GtkComboBox *combo_box,
                        gint position);


    void gtk_combo_box_popup (GtkComboBox *combo_box);
    void gtk_combo_box_popdown (GtkComboBox *combo_box);



    alias _GtkComboBoxEntry GtkComboBoxEntry;

    alias _GtkComboBoxEntryClass GtkComboBoxEntryClass;

    alias _GtkComboBoxEntryPrivate GtkComboBoxEntryPrivate;
    alias void _GtkComboBoxEntryPrivate;


    struct _GtkComboBoxEntry {
    GtkComboBox parent_instance;


    GtkComboBoxEntryPrivate *priv;
    }

    struct _GtkComboBoxEntryClass {
    GtkComboBoxClass parent_class;


    void (*_gtk_reserved0) ();
    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    }


    GType gtk_combo_box_entry_get_type ();
    GtkWidget *gtk_combo_box_entry_new ();
    GtkWidget *gtk_combo_box_entry_new_with_model (GtkTreeModel *model,
                            gint text_column);

    void gtk_combo_box_entry_set_text_column (GtkComboBoxEntry *entry_box,
                            gint text_column);
    gint gtk_combo_box_entry_get_text_column (GtkComboBoxEntry *entry_box);


    GtkWidget *gtk_combo_box_entry_new_text ();




    enum GtkCTreePos {
    GTK_CTREE_POS_BEFORE,
    GTK_CTREE_POS_AS_CHILD,
    GTK_CTREE_POS_AFTER
    };


    enum GtkCTreeLineStyle {
    GTK_CTREE_LINES_NONE,
    GTK_CTREE_LINES_SOLID,
    GTK_CTREE_LINES_DOTTED,
    GTK_CTREE_LINES_TABBED
    };


    enum GtkCTreeExpanderStyle {
    GTK_CTREE_EXPANDER_NONE,
    GTK_CTREE_EXPANDER_SQUARE,
    GTK_CTREE_EXPANDER_TRIANGLE,
    GTK_CTREE_EXPANDER_CIRCULAR
    };


    enum GtkCTreeExpansionType {
    GTK_CTREE_EXPANSION_EXPAND,
    GTK_CTREE_EXPANSION_EXPAND_RECURSIVE,
    GTK_CTREE_EXPANSION_COLLAPSE,
    GTK_CTREE_EXPANSION_COLLAPSE_RECURSIVE,
    GTK_CTREE_EXPANSION_TOGGLE,
    GTK_CTREE_EXPANSION_TOGGLE_RECURSIVE
    };


    alias _GtkCTree GtkCTree;

    alias _GtkCTreeClass GtkCTreeClass;

    alias _GtkCTreeRow GtkCTreeRow;

    alias _GtkCTreeNode GtkCTreeNode;


    alias void (*GtkCTreeFunc) (GtkCTree *ctree,
                GtkCTreeNode *node,
                gpointer data);

    alias gboolean (*GtkCTreeGNodeFunc) (GtkCTree *ctree,
                    guint depth,
                    GNode *gnode,
                    GtkCTreeNode *cnode,
                    gpointer data);

    alias gboolean (*GtkCTreeCompareDragFunc) (GtkCTree *ctree,
                        GtkCTreeNode *source_node,
                        GtkCTreeNode *new_parent,
                        GtkCTreeNode *new_sibling);

    struct _GtkCTree {
    GtkCList clist;

    GdkGC *lines_gc;

    gint tree_indent;
    gint tree_spacing;
    gint tree_column;

    guint line_style;
    guint expander_style;
    guint show_stub;

    GtkCTreeCompareDragFunc drag_compare;
    }

    struct _GtkCTreeClass {
    GtkCListClass parent_class;

    void (*tree_select_row) (GtkCTree *ctree,
                GtkCTreeNode *row,
                gint column);
    void (*tree_unselect_row) (GtkCTree *ctree,
                GtkCTreeNode *row,
                gint column);
    void (*tree_expand) (GtkCTree *ctree,
                GtkCTreeNode *node);
    void (*tree_collapse) (GtkCTree *ctree,
                GtkCTreeNode *node);
    void (*tree_move) (GtkCTree *ctree,
                GtkCTreeNode *node,
                GtkCTreeNode *new_parent,
                GtkCTreeNode *new_sibling);
    void (*change_focus_row_expansion) (GtkCTree *ctree,
                    GtkCTreeExpansionType action);
    }

    struct _GtkCTreeRow {
    GtkCListRow row;

    GtkCTreeNode *parent;
    GtkCTreeNode *sibling;
    GtkCTreeNode *children;

    GdkPixmap *pixmap_closed;
    GdkBitmap *mask_closed;
    GdkPixmap *pixmap_opened;
    GdkBitmap *mask_opened;

    guint16 level;

    guint is_leaf;
    guint expanded;
    }

    struct _GtkCTreeNode {
    GList list;
    }






    GtkType gtk_ctree_get_type () ;
    GtkWidget * gtk_ctree_new_with_titles (gint columns,
                            gint tree_column,
                            gchar *titles[]);
    GtkWidget * gtk_ctree_new (gint columns,
                            gint tree_column);
    GtkCTreeNode * gtk_ctree_insert_node (GtkCTree *ctree,
                            GtkCTreeNode *parent,
                            GtkCTreeNode *sibling,
                            gchar *text[],
                            guint8 spacing,
                            GdkPixmap *pixmap_closed,
                            GdkBitmap *mask_closed,
                            GdkPixmap *pixmap_opened,
                            GdkBitmap *mask_opened,
                            gboolean is_leaf,
                            gboolean expanded);
    void gtk_ctree_remove_node (GtkCTree *ctree,
                            GtkCTreeNode *node);
    GtkCTreeNode * gtk_ctree_insert_gnode (GtkCTree *ctree,
                            GtkCTreeNode *parent,
                            GtkCTreeNode *sibling,
                            GNode *gnode,
                            GtkCTreeGNodeFunc func,
                            gpointer data);
    GNode * gtk_ctree_export_to_gnode (GtkCTree *ctree,
                            GNode *parent,
                            GNode *sibling,
                            GtkCTreeNode *node,
                            GtkCTreeGNodeFunc func,
                            gpointer data);






    void gtk_ctree_post_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GtkCTreeFunc func,
                            gpointer data);
    void gtk_ctree_post_recursive_to_depth (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint depth,
                            GtkCTreeFunc func,
                            gpointer data);
    void gtk_ctree_pre_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GtkCTreeFunc func,
                            gpointer data);
    void gtk_ctree_pre_recursive_to_depth (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint depth,
                            GtkCTreeFunc func,
                            gpointer data);
    gboolean gtk_ctree_is_viewable (GtkCTree *ctree,
                            GtkCTreeNode *node);
    GtkCTreeNode * gtk_ctree_last (GtkCTree *ctree,
                            GtkCTreeNode *node);
    GtkCTreeNode * gtk_ctree_find_node_ptr (GtkCTree *ctree,
                            GtkCTreeRow *ctree_row);
    GtkCTreeNode * gtk_ctree_node_nth (GtkCTree *ctree,
                            guint row);
    gboolean gtk_ctree_find (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GtkCTreeNode *child);
    gboolean gtk_ctree_is_ancestor (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GtkCTreeNode *child);
    GtkCTreeNode * gtk_ctree_find_by_row_data (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gpointer data);

    GList * gtk_ctree_find_all_by_row_data (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gpointer data);
    GtkCTreeNode * gtk_ctree_find_by_row_data_custom (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gpointer data,
                            GCompareFunc func);

    GList * gtk_ctree_find_all_by_row_data_custom (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gpointer data,
                            GCompareFunc func);
    gboolean gtk_ctree_is_hot_spot (GtkCTree *ctree,
                            gint x,
                            gint y);





    void gtk_ctree_move (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GtkCTreeNode *new_parent,
                            GtkCTreeNode *new_sibling);
    void gtk_ctree_expand (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_expand_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_expand_to_depth (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint depth);
    void gtk_ctree_collapse (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_collapse_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_collapse_to_depth (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint depth);
    void gtk_ctree_toggle_expansion (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_toggle_expansion_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_select (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_select_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_unselect (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_unselect_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_real_select_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint state);





    void gtk_ctree_node_set_text (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            gchar *text);
    void gtk_ctree_node_set_pixmap (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            GdkPixmap *pixmap,
                            GdkBitmap *mask);
    void gtk_ctree_node_set_pixtext (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            gchar *text,
                            guint8 spacing,
                            GdkPixmap *pixmap,
                            GdkBitmap *mask);
    void gtk_ctree_set_node_info (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gchar *text,
                            guint8 spacing,
                            GdkPixmap *pixmap_closed,
                            GdkBitmap *mask_closed,
                            GdkPixmap *pixmap_opened,
                            GdkBitmap *mask_opened,
                            gboolean is_leaf,
                            gboolean expanded);
    void gtk_ctree_node_set_shift (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            gint vertical,
                            gint horizontal);
    void gtk_ctree_node_set_selectable (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gboolean selectable);
    gboolean gtk_ctree_node_get_selectable (GtkCTree *ctree,
                            GtkCTreeNode *node);
    GtkCellType gtk_ctree_node_get_cell_type (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column);
    gboolean gtk_ctree_node_get_text (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            gchar **text);
    gboolean gtk_ctree_node_get_pixmap (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            GdkPixmap **pixmap,
                            GdkBitmap **mask);
    gboolean gtk_ctree_node_get_pixtext (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            gchar **text,
                            guint8 *spacing,
                            GdkPixmap **pixmap,
                            GdkBitmap **mask);
    gboolean gtk_ctree_get_node_info (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gchar **text,
                            guint8 *spacing,
                            GdkPixmap **pixmap_closed,
                            GdkBitmap **mask_closed,
                            GdkPixmap **pixmap_opened,
                            GdkBitmap **mask_opened,
                            gboolean *is_leaf,
                            gboolean *expanded);
    void gtk_ctree_node_set_row_style (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GtkStyle *style);
    GtkStyle * gtk_ctree_node_get_row_style (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_node_set_cell_style (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            GtkStyle *style);
    GtkStyle * gtk_ctree_node_get_cell_style (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column);
    void gtk_ctree_node_set_foreground (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GdkColor *color);
    void gtk_ctree_node_set_background (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            GdkColor *color);
    void gtk_ctree_node_set_row_data (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gpointer data);
    void gtk_ctree_node_set_row_data_full (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gpointer data,
                            GtkDestroyNotify destroy);
    gpointer gtk_ctree_node_get_row_data (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_node_moveto (GtkCTree *ctree,
                            GtkCTreeNode *node,
                            gint column,
                            gfloat row_align,
                            gfloat col_align);
    GtkVisibility gtk_ctree_node_is_visible (GtkCTree *ctree,
                            GtkCTreeNode *node);





    void gtk_ctree_set_indent (GtkCTree *ctree,
                    gint indent);
    void gtk_ctree_set_spacing (GtkCTree *ctree,
                    gint spacing);
    void gtk_ctree_set_show_stub (GtkCTree *ctree,
                    gboolean show_stub);
    void gtk_ctree_set_line_style (GtkCTree *ctree,
                    GtkCTreeLineStyle line_style);
    void gtk_ctree_set_expander_style (GtkCTree *ctree,
                    GtkCTreeExpanderStyle expander_style);
    void gtk_ctree_set_drag_compare_func (GtkCTree *ctree,
                    GtkCTreeCompareDragFunc cmp_func);





    void gtk_ctree_sort_node (GtkCTree *ctree,
                            GtkCTreeNode *node);
    void gtk_ctree_sort_recursive (GtkCTree *ctree,
                            GtkCTreeNode *node);
    GType gtk_ctree_node_get_type () ;
    alias _GtkDrawingArea GtkDrawingArea;

    alias _GtkDrawingAreaClass GtkDrawingAreaClass;


    struct _GtkDrawingArea {
    GtkWidget widget;

    gpointer draw_data;
    }

    struct _GtkDrawingAreaClass {
    GtkWidgetClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_drawing_area_get_type () ;
    GtkWidget* gtk_drawing_area_new ();


    void gtk_drawing_area_size (GtkDrawingArea *darea,
                        gint width,
                        gint height);
    alias _GtkCurve GtkCurve;

    alias _GtkCurveClass GtkCurveClass;



    struct _GtkCurve {
    GtkDrawingArea graph;

    gint cursor_type;
    gfloat min_x;
    gfloat max_x;
    gfloat min_y;
    gfloat max_y;
    GdkPixmap *pixmap;
    GtkCurveType curve_type;
    gint height;
    gint grab_point;
    gint last;


    gint num_points;
    GdkPoint *point;


    gint num_ctlpoints;
    gfloat (*ctlpoint)[2];
    }

    struct _GtkCurveClass {
    GtkDrawingAreaClass parent_class;

    void (* curve_type_changed) (GtkCurve *curve);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_curve_get_type () ;
    GtkWidget* gtk_curve_new ();
    void gtk_curve_reset (GtkCurve *curve);
    void gtk_curve_set_gamma (GtkCurve *curve, gfloat gamma_);
    void gtk_curve_set_range (GtkCurve *curve,
                        gfloat min_x, gfloat max_x,
                        gfloat min_y, gfloat max_y);
    void gtk_curve_get_vector (GtkCurve *curve,
                        int veclen, gfloat vector[]);
    void gtk_curve_set_vector (GtkCurve *curve,
                        int veclen, gfloat vector[]);
    void gtk_curve_set_curve_type (GtkCurve *curve, GtkCurveType type);



    alias _GtkEditable GtkEditable;
    alias void _GtkEditable;

    alias _GtkEditableClass GtkEditableClass;


    struct _GtkEditableClass {
    GTypeInterface base_iface;


    void (* insert_text) (GtkEditable *editable,
                    gchar *text,
                    gint length,
                    gint *position);
    void (* delete_text) (GtkEditable *editable,
                    gint start_pos,
                    gint end_pos);
    void (* changed) (GtkEditable *editable);


    void (* do_insert_text) (GtkEditable *editable,
                    gchar *text,
                    gint length,
                    gint *position);
    void (* do_delete_text) (GtkEditable *editable,
                    gint start_pos,
                    gint end_pos);

    gchar* (* get_chars) (GtkEditable *editable,
                    gint start_pos,
                    gint end_pos);
    void (* set_selection_bounds) (GtkEditable *editable,
                    gint start_pos,
                    gint end_pos);
    gboolean (* get_selection_bounds) (GtkEditable *editable,
                    gint *start_pos,
                    gint *end_pos);
    void (* set_position) (GtkEditable *editable,
                    gint position);
    gint (* get_position) (GtkEditable *editable);
    }

    GType gtk_editable_get_type () ;
    void gtk_editable_select_region (GtkEditable *editable,
                        gint start,
                        gint end);
    gboolean gtk_editable_get_selection_bounds (GtkEditable *editable,
                        gint *start,
                        gint *end);
    void gtk_editable_insert_text (GtkEditable *editable,
                        gchar *new_text,
                        gint new_text_length,
                        gint *position);
    void gtk_editable_delete_text (GtkEditable *editable,
                        gint start_pos,
                        gint end_pos);
    gchar* gtk_editable_get_chars (GtkEditable *editable,
                        gint start_pos,
                        gint end_pos);
    void gtk_editable_cut_clipboard (GtkEditable *editable);
    void gtk_editable_copy_clipboard (GtkEditable *editable);
    void gtk_editable_paste_clipboard (GtkEditable *editable);
    void gtk_editable_delete_selection (GtkEditable *editable);
    void gtk_editable_set_position (GtkEditable *editable,
                        gint position);
    gint gtk_editable_get_position (GtkEditable *editable);
    void gtk_editable_set_editable (GtkEditable *editable,
                        gboolean is_editable);
    gboolean gtk_editable_get_editable (GtkEditable *editable);
    alias _GtkIMContext GtkIMContext;

    alias _GtkIMContextClass GtkIMContextClass;


    struct _GtkIMContext {
    GObject parent_instance;
    }

    struct _GtkIMContextClass {



    GtkObjectClass parent_class;


    void (*preedit_start) (GtkIMContext *context);
    void (*preedit_end) (GtkIMContext *context);
    void (*preedit_changed) (GtkIMContext *context);
    void (*commit) (GtkIMContext *context,  gchar *str);
    gboolean (*retrieve_surrounding) (GtkIMContext *context);
    gboolean (*delete_surrounding) (GtkIMContext *context,
                    gint offset,
                    gint n_chars);


    void (*set_client_window) (GtkIMContext *context,
                    GdkWindow *window);
    void (*get_preedit_string) (GtkIMContext *context,
                    gchar **str,
                    PangoAttrList **attrs,
                    gint *cursor_pos);
    gboolean (*filter_keypress) (GtkIMContext *context,
                    GdkEventKey *event);
    void (*focus_in) (GtkIMContext *context);
    void (*focus_out) (GtkIMContext *context);
    void (*reset) (GtkIMContext *context);
    void (*set_cursor_location) (GtkIMContext *context,
                    GdkRectangle *area);
    void (*set_use_preedit) (GtkIMContext *context,
                    gboolean use_preedit);
    void (*set_surrounding) (GtkIMContext *context,
                    gchar *text,
                    gint len,
                    gint cursor_index);
    gboolean (*get_surrounding) (GtkIMContext *context,
                    gchar **text,
                    gint *cursor_index);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    void (*_gtk_reserved5) ();
    void (*_gtk_reserved6) ();
    }

    GType gtk_im_context_get_type () ;

    void gtk_im_context_set_client_window (GtkIMContext *context,
                        GdkWindow *window);
    void gtk_im_context_get_preedit_string (GtkIMContext *context,
                        gchar **str,
                        PangoAttrList **attrs,
                        gint *cursor_pos);
    gboolean gtk_im_context_filter_keypress (GtkIMContext *context,
                        GdkEventKey *event);
    void gtk_im_context_focus_in (GtkIMContext *context);
    void gtk_im_context_focus_out (GtkIMContext *context);
    void gtk_im_context_reset (GtkIMContext *context);
    void gtk_im_context_set_cursor_location (GtkIMContext *context,
                        GdkRectangle *area);
    void gtk_im_context_set_use_preedit (GtkIMContext *context,
                        gboolean use_preedit);
    void gtk_im_context_set_surrounding (GtkIMContext *context,
                        gchar *text,
                        gint len,
                        gint cursor_index);
    gboolean gtk_im_context_get_surrounding (GtkIMContext *context,
                        gchar **text,
                        gint *cursor_index);
    gboolean gtk_im_context_delete_surrounding (GtkIMContext *context,
                        gint offset,
                        gint n_chars);

    alias _GtkListStore GtkListStore;

    alias _GtkListStoreClass GtkListStoreClass;


    struct _GtkListStore {
    GObject parent;


    gint stamp;
    gpointer root;
    gpointer tail;
    GList *sort_list;
    gint n_columns;
    gint sort_column_id;
    GtkSortType order;
    GType *column_headers;
    gint length;
    GtkTreeIterCompareFunc default_sort_func;
    gpointer default_sort_data;
    GtkDestroyNotify default_sort_destroy;
    guint columns_dirty;
    }

    struct _GtkListStoreClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_list_store_get_type ();
    GtkListStore *gtk_list_store_new (gint n_columns,
                        ...);
    GtkListStore *gtk_list_store_newv (gint n_columns,
                        GType *types);
    void gtk_list_store_set_column_types (GtkListStore *list_store,
                        gint n_columns,
                        GType *types);



    void gtk_list_store_set_value (GtkListStore *list_store,
                        GtkTreeIter *iter,
                        gint column,
                        GValue *value);
    void gtk_list_store_set (GtkListStore *list_store,
                        GtkTreeIter *iter,
                        ...);
    void gtk_list_store_set_valist (GtkListStore *list_store,
                        GtkTreeIter *iter,
                        va_list var_args);
    gboolean gtk_list_store_remove (GtkListStore *list_store,
                        GtkTreeIter *iter);
    void gtk_list_store_insert (GtkListStore *list_store,
                        GtkTreeIter *iter,
                        gint position);
    void gtk_list_store_insert_before (GtkListStore *list_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *sibling);
    void gtk_list_store_insert_after (GtkListStore *list_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *sibling);
    void gtk_list_store_prepend (GtkListStore *list_store,
                        GtkTreeIter *iter);
    void gtk_list_store_append (GtkListStore *list_store,
                        GtkTreeIter *iter);
    void gtk_list_store_clear (GtkListStore *list_store);
    gboolean gtk_list_store_iter_is_valid (GtkListStore *list_store,
                        GtkTreeIter *iter);
    void gtk_list_store_reorder (GtkListStore *store,
                        gint *new_order);
    void gtk_list_store_swap (GtkListStore *store,
                        GtkTreeIter *a,
                        GtkTreeIter *b);
    void gtk_list_store_move_after (GtkListStore *store,
                        GtkTreeIter *iter,
                        GtkTreeIter *position);
    void gtk_list_store_move_before (GtkListStore *store,
                        GtkTreeIter *iter,
                        GtkTreeIter *position);


    alias gboolean (* GtkTreeModelFilterVisibleFunc) (GtkTreeModel *model,
                            GtkTreeIter *iter,
                            gpointer data);
    alias void (* GtkTreeModelFilterModifyFunc) (GtkTreeModel *model,
                        GtkTreeIter *iter,
                        GValue *value,
                        gint column,
                        gpointer data);

    alias _GtkTreeModelFilter GtkTreeModelFilter;

    alias _GtkTreeModelFilterClass GtkTreeModelFilterClass;

    alias _GtkTreeModelFilterPrivate GtkTreeModelFilterPrivate;
    alias void _GtkTreeModelFilterPrivate;


    struct _GtkTreeModelFilter {
    GObject parent;


    GtkTreeModelFilterPrivate *priv;
    }

    struct _GtkTreeModelFilterClass {
    GObjectClass parent_class;


    void (*_gtk_reserved0) ();
    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    }


    GType gtk_tree_model_filter_get_type ();
    GtkTreeModel *gtk_tree_model_filter_new (GtkTreeModel *child_model,
                                    GtkTreePath *root);
    void gtk_tree_model_filter_set_visible_func (GtkTreeModelFilter *filter,
                                    GtkTreeModelFilterVisibleFunc func,
                                    gpointer data,
                                    GtkDestroyNotify destroy);
    void gtk_tree_model_filter_set_modify_func (GtkTreeModelFilter *filter,
                                    gint n_columns,
                                    GType *types,
                                    GtkTreeModelFilterModifyFunc func,
                                    gpointer data,
                                    GtkDestroyNotify destroy);
    void gtk_tree_model_filter_set_visible_column (GtkTreeModelFilter *filter,
                                    gint column);

    GtkTreeModel *gtk_tree_model_filter_get_model (GtkTreeModelFilter *filter);


    void gtk_tree_model_filter_convert_child_iter_to_iter (GtkTreeModelFilter *filter,
                                    GtkTreeIter *filter_iter,
                                    GtkTreeIter *child_iter);
    void gtk_tree_model_filter_convert_iter_to_child_iter (GtkTreeModelFilter *filter,
                                    GtkTreeIter *child_iter,
                                    GtkTreeIter *filter_iter);
    GtkTreePath *gtk_tree_model_filter_convert_child_path_to_path (GtkTreeModelFilter *filter,
                                    GtkTreePath *child_path);
    GtkTreePath *gtk_tree_model_filter_convert_path_to_child_path (GtkTreeModelFilter *filter,
                                    GtkTreePath *filter_path);


    void gtk_tree_model_filter_refilter (GtkTreeModelFilter *filter);
    void gtk_tree_model_filter_clear_cache (GtkTreeModelFilter *filter);




    alias _GtkEntryCompletion GtkEntryCompletion;

    alias _GtkEntryCompletionClass GtkEntryCompletionClass;

    alias _GtkEntryCompletionPrivate GtkEntryCompletionPrivate;
    alias void _GtkEntryCompletionPrivate;


    alias gboolean (* GtkEntryCompletionMatchFunc) (GtkEntryCompletion *completion,
                            gchar *key,
                            GtkTreeIter *iter,
                            gpointer user_data);


    struct _GtkEntryCompletion {
    GObject parent_instance;


    GtkEntryCompletionPrivate *priv;
    }

    struct _GtkEntryCompletionClass {
    GObjectClass parent_class;

    gboolean (* match_selected) (GtkEntryCompletion *completion,
                    GtkTreeModel *model,
                    GtkTreeIter *iter);
    void (* action_activated) (GtkEntryCompletion *completion,
                    gint index_);


    void (*_gtk_reserved0) ();
    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    }


    GType gtk_entry_completion_get_type ();
    GtkEntryCompletion *gtk_entry_completion_new ();

    GtkWidget *gtk_entry_completion_get_entry (GtkEntryCompletion *completion);

    void gtk_entry_completion_set_model (GtkEntryCompletion *completion,
                                    GtkTreeModel *model);
    GtkTreeModel *gtk_entry_completion_get_model (GtkEntryCompletion *completion);

    void gtk_entry_completion_set_match_func (GtkEntryCompletion *completion,
                                    GtkEntryCompletionMatchFunc func,
                                    gpointer func_data,
                                    GDestroyNotify func_notify);
    void gtk_entry_completion_set_minimum_key_length (GtkEntryCompletion *completion,
                                    gint length);
    gint gtk_entry_completion_get_minimum_key_length (GtkEntryCompletion *completion);
    void gtk_entry_completion_complete (GtkEntryCompletion *completion);

    void gtk_entry_completion_insert_action_text (GtkEntryCompletion *completion,
                                    gint index_,
                                    gchar *text);
    void gtk_entry_completion_insert_action_markup (GtkEntryCompletion *completion,
                                    gint index_,
                                    gchar *markup);
    void gtk_entry_completion_delete_action (GtkEntryCompletion *completion,
                                    gint index_);


    void gtk_entry_completion_set_text_column (GtkEntryCompletion *completion,
                                    gint column);


    alias _GtkEntry GtkEntry;

    alias _GtkEntryClass GtkEntryClass;


    struct _GtkEntry {
    GtkWidget widget;

    gchar *text;

    guint editable;
    guint visible;
    guint overwrite_mode;
    guint in_drag;

    guint16 text_length;
    guint16 text_max_length;


    GdkWindow *text_area;
    GtkIMContext *im_context;
    GtkWidget *popup_menu;

    gint current_pos;
    gint selection_bound;

    PangoLayout *cached_layout;
    guint cache_includes_preedit;

    guint need_im_reset;

    guint has_frame;

    guint activates_default;

    guint cursor_visible;

    guint in_click;

    guint is_cell_renderer;
    guint editing_canceled;

    guint mouse_cursor_obscured;

    guint select_words;
    guint select_lines;
    guint resolved_dir;
    guint button;
    guint blink_timeout;
    guint recompute_idle;
    gint scroll_offset;
    gint ascent;
    gint descent;

    guint16 text_size;
    guint16 n_bytes;

    guint16 preedit_length;
    guint16 preedit_cursor;

    gint dnd_position;

    gint drag_start_x;
    gint drag_start_y;

    gunichar invisible_char;

    gint width_chars;
    }

    struct _GtkEntryClass {
    GtkWidgetClass parent_class;


    void (* populate_popup) (GtkEntry *entry,
                GtkMenu *menu);



    void (* activate) (GtkEntry *entry);
    void (* move_cursor) (GtkEntry *entry,
                GtkMovementStep step,
                gint count,
                gboolean extend_selection);
    void (* insert_at_cursor) (GtkEntry *entry,
                    gchar *str);
    void (* delete_from_cursor) (GtkEntry *entry,
                GtkDeleteType type,
                gint count);
    void (* cut_clipboard) (GtkEntry *entry);
    void (* copy_clipboard) (GtkEntry *entry);
    void (* paste_clipboard) (GtkEntry *entry);
    void (* toggle_overwrite) (GtkEntry *entry);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_entry_get_type () ;
    GtkWidget* gtk_entry_new ();
    void gtk_entry_set_visibility (GtkEntry *entry,
                            gboolean visible);
    gboolean gtk_entry_get_visibility (GtkEntry *entry);
    void gtk_entry_set_invisible_char (GtkEntry *entry,
                            gunichar ch);
    gunichar gtk_entry_get_invisible_char (GtkEntry *entry);
    void gtk_entry_set_has_frame (GtkEntry *entry,
                            gboolean setting);
    gboolean gtk_entry_get_has_frame (GtkEntry *entry);

    void gtk_entry_set_max_length (GtkEntry *entry,
                            gint max);
    gint gtk_entry_get_max_length (GtkEntry *entry);
    void gtk_entry_set_activates_default (GtkEntry *entry,
                            gboolean setting);
    gboolean gtk_entry_get_activates_default (GtkEntry *entry);

    void gtk_entry_set_width_chars (GtkEntry *entry,
                            gint n_chars);
    gint gtk_entry_get_width_chars (GtkEntry *entry);



    void gtk_entry_set_text (GtkEntry *entry,
                            gchar *text);

    gchar* gtk_entry_get_text (GtkEntry *entry);

    PangoLayout* gtk_entry_get_layout (GtkEntry *entry);
    void gtk_entry_get_layout_offsets (GtkEntry *entry,
                            gint *x,
                            gint *y);
    void gtk_entry_set_alignment (GtkEntry *entry,
                            gfloat xalign);
    gfloat gtk_entry_get_alignment (GtkEntry *entry);

    void gtk_entry_set_completion (GtkEntry *entry,
                        GtkEntryCompletion *completion);
    GtkEntryCompletion *gtk_entry_get_completion (GtkEntry *entry);





    GtkWidget* gtk_entry_new_with_max_length (gint max);
    void gtk_entry_append_text (GtkEntry *entry,
                            gchar *text);
    void gtk_entry_prepend_text (GtkEntry *entry,
                            gchar *text);
    void gtk_entry_set_position (GtkEntry *entry,
                            gint position);
    void gtk_entry_select_region (GtkEntry *entry,
                            gint start,
                            gint end);
    void gtk_entry_set_editable (GtkEntry *entry,
                            gboolean editable);


    alias _GtkEventBox GtkEventBox;

    alias _GtkEventBoxClass GtkEventBoxClass;


    struct _GtkEventBox {
    GtkBin bin;
    }

    struct _GtkEventBoxClass {
    GtkBinClass parent_class;
    }

    GType gtk_event_box_get_type () ;
    GtkWidget* gtk_event_box_new ();
    gboolean gtk_event_box_get_visible_window (GtkEventBox *event_box);
    void gtk_event_box_set_visible_window (GtkEventBox *event_box,
                        gboolean visible_window);
    gboolean gtk_event_box_get_above_child (GtkEventBox *event_box);
    void gtk_event_box_set_above_child (GtkEventBox *event_box,
                        gboolean above_child);

    alias _GtkExpander GtkExpander;

    alias _GtkExpanderClass GtkExpanderClass;

    alias _GtkExpanderPrivate GtkExpanderPrivate;
    alias void _GtkExpanderPrivate;


    struct _GtkExpander {
    GtkBin bin;

    GtkExpanderPrivate *priv;
    }

    struct _GtkExpanderClass {
    GtkBinClass parent_class;




    void (* activate) (GtkExpander *expander);
    }

    GType gtk_expander_get_type ();

    GtkWidget *gtk_expander_new ( gchar *label);
    GtkWidget *gtk_expander_new_with_mnemonic ( gchar *label);

    void gtk_expander_set_expanded (GtkExpander *expander,
                            gboolean expanded);
    gboolean gtk_expander_get_expanded (GtkExpander *expander);


    void gtk_expander_set_spacing (GtkExpander *expander,
                            gint spacing);
    gint gtk_expander_get_spacing (GtkExpander *expander);

    void gtk_expander_set_label (GtkExpander *expander,
                            gchar *label);
    gchar *gtk_expander_get_label (GtkExpander *expander);

    void gtk_expander_set_use_underline (GtkExpander *expander,
                            gboolean use_underline);
    gboolean gtk_expander_get_use_underline (GtkExpander *expander);

    void gtk_expander_set_use_markup (GtkExpander *expander,
                            gboolean use_markup);
    gboolean gtk_expander_get_use_markup (GtkExpander *expander);

    void gtk_expander_set_label_widget (GtkExpander *expander,
                            GtkWidget *label_widget);
    GtkWidget *gtk_expander_get_label_widget (GtkExpander *expander);


    alias _GtkFileSelection GtkFileSelection;

    alias _GtkFileSelectionClass GtkFileSelectionClass;


    struct _GtkFileSelection {

    GtkDialog parent_instance;


    GtkWidget *dir_list;
    GtkWidget *file_list;
    GtkWidget *selection_entry;
    GtkWidget *selection_text;
    GtkWidget *main_vbox;
    GtkWidget *ok_button;
    GtkWidget *cancel_button;
    GtkWidget *help_button;
    GtkWidget *history_pulldown;
    GtkWidget *history_menu;
    GList *history_list;
    GtkWidget *fileop_dialog;
    GtkWidget *fileop_entry;
    gchar *fileop_file;
    gpointer cmpl_state;

    GtkWidget *fileop_c_dir;
    GtkWidget *fileop_del_file;
    GtkWidget *fileop_ren_file;

    GtkWidget *button_area;
    GtkWidget *action_area;


    GPtrArray *selected_names;
    gchar *last_selected;
    }

    struct _GtkFileSelectionClass {
    GtkDialogClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_file_selection_get_type () ;
    GtkWidget* gtk_file_selection_new ( gchar *title);
    void gtk_file_selection_set_filename (GtkFileSelection *filesel,
                            gchar *filename);






    gchar* gtk_file_selection_get_filename (GtkFileSelection *filesel);

    void gtk_file_selection_complete (GtkFileSelection *filesel,
                            gchar *pattern);
    void gtk_file_selection_show_fileop_buttons (GtkFileSelection *filesel);
    void gtk_file_selection_hide_fileop_buttons (GtkFileSelection *filesel);

    gchar** gtk_file_selection_get_selections (GtkFileSelection *filesel);

    void gtk_file_selection_set_select_multiple (GtkFileSelection *filesel,
                            gboolean select_multiple);
    gboolean gtk_file_selection_get_select_multiple (GtkFileSelection *filesel);
    alias _GtkFixed GtkFixed;

    alias _GtkFixedClass GtkFixedClass;

    alias _GtkFixedChild GtkFixedChild;


    struct _GtkFixed {
    GtkContainer container;

    GList *children;
    }

    struct _GtkFixedClass {
    GtkContainerClass parent_class;
    }

    struct _GtkFixedChild {
    GtkWidget *widget;
    gint x;
    gint y;
    }


    GType gtk_fixed_get_type () ;
    GtkWidget* gtk_fixed_new ();
    void gtk_fixed_put (GtkFixed *fixed,
                        GtkWidget *widget,
                        gint x,
                        gint y);
    void gtk_fixed_move (GtkFixed *fixed,
                        GtkWidget *widget,
                        gint x,
                        gint y);
    void gtk_fixed_set_has_window (GtkFixed *fixed,
                        gboolean has_window);
    gboolean gtk_fixed_get_has_window (GtkFixed *fixed);






    alias _GtkFileFilter GtkFileFilter;
    alias void _GtkFileFilter;

    alias _GtkFileFilterInfo GtkFileFilterInfo;


    enum GtkFileFilterFlags {
    GTK_FILE_FILTER_FILENAME = 1 << 0,
    GTK_FILE_FILTER_URI = 1 << 1,
    GTK_FILE_FILTER_DISPLAY_NAME = 1 << 2,
    GTK_FILE_FILTER_MIME_TYPE = 1 << 3
    };


    alias gboolean (*GtkFileFilterFunc) ( GtkFileFilterInfo *filter_info,
                    gpointer data);

    struct _GtkFileFilterInfo {
    GtkFileFilterFlags contains;

    gchar *filename;
    gchar *uri;
    gchar *display_name;
    gchar *mime_type;
    }

    GType gtk_file_filter_get_type ();

    GtkFileFilter * gtk_file_filter_new ();
    void gtk_file_filter_set_name (GtkFileFilter *filter,
                            gchar *name);
    gchar *gtk_file_filter_get_name (GtkFileFilter *filter);

    void gtk_file_filter_add_mime_type (GtkFileFilter *filter,
                        gchar *mime_type);
    void gtk_file_filter_add_pattern (GtkFileFilter *filter,
                        gchar *pattern);
    void gtk_file_filter_add_custom (GtkFileFilter *filter,
                        GtkFileFilterFlags needed,
                        GtkFileFilterFunc func,
                        gpointer data,
                        GDestroyNotify notify);

    GtkFileFilterFlags gtk_file_filter_get_needed (GtkFileFilter *filter);
    gboolean gtk_file_filter_filter (GtkFileFilter *filter,
                            GtkFileFilterInfo *filter_info);










    alias _GtkFileChooser GtkFileChooser;
    alias void _GtkFileChooser;


    enum GtkFileChooserAction {
    GTK_FILE_CHOOSER_ACTION_OPEN,
    GTK_FILE_CHOOSER_ACTION_SAVE,
    GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER,
    GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER
    };


    GType gtk_file_chooser_get_type ();





    enum GtkFileChooserError {
    GTK_FILE_CHOOSER_ERROR_NONEXISTENT,
    GTK_FILE_CHOOSER_ERROR_BAD_FILENAME
    };


    GQuark gtk_file_chooser_error_quark ();



    void gtk_file_chooser_set_action (GtkFileChooser *chooser,
                                GtkFileChooserAction action);
    GtkFileChooserAction gtk_file_chooser_get_action (GtkFileChooser *chooser);
    void gtk_file_chooser_set_local_only (GtkFileChooser *chooser,
                                gboolean local_only);
    gboolean gtk_file_chooser_get_local_only (GtkFileChooser *chooser);
    void gtk_file_chooser_set_select_multiple (GtkFileChooser *chooser,
                                gboolean select_multiple);
    gboolean gtk_file_chooser_get_select_multiple (GtkFileChooser *chooser);



    void gtk_file_chooser_set_current_name (GtkFileChooser *chooser,
                        gchar *name);



    gchar * gtk_file_chooser_get_filename (GtkFileChooser *chooser);
    gboolean gtk_file_chooser_set_filename (GtkFileChooser *chooser,
                        char *filename);
    gboolean gtk_file_chooser_select_filename (GtkFileChooser *chooser,
                        char *filename);
    void gtk_file_chooser_unselect_filename (GtkFileChooser *chooser,
                        char *filename);
    void gtk_file_chooser_select_all (GtkFileChooser *chooser);
    void gtk_file_chooser_unselect_all (GtkFileChooser *chooser);
    GSList * gtk_file_chooser_get_filenames (GtkFileChooser *chooser);
    gboolean gtk_file_chooser_set_current_folder (GtkFileChooser *chooser,
                        gchar *filename);
    gchar * gtk_file_chooser_get_current_folder (GtkFileChooser *chooser);




    gchar * gtk_file_chooser_get_uri (GtkFileChooser *chooser);
    gboolean gtk_file_chooser_set_uri (GtkFileChooser *chooser,
                            char *uri);
    gboolean gtk_file_chooser_select_uri (GtkFileChooser *chooser,
                            char *uri);
    void gtk_file_chooser_unselect_uri (GtkFileChooser *chooser,
                            char *uri);
    GSList * gtk_file_chooser_get_uris (GtkFileChooser *chooser);
    gboolean gtk_file_chooser_set_current_folder_uri (GtkFileChooser *chooser,
                            gchar *uri);
    gchar * gtk_file_chooser_get_current_folder_uri (GtkFileChooser *chooser);



    void gtk_file_chooser_set_preview_widget (GtkFileChooser *chooser,
                            GtkWidget *preview_widget);
    GtkWidget *gtk_file_chooser_get_preview_widget (GtkFileChooser *chooser);
    void gtk_file_chooser_set_preview_widget_active (GtkFileChooser *chooser,
                            gboolean active);
    gboolean gtk_file_chooser_get_preview_widget_active (GtkFileChooser *chooser);
    void gtk_file_chooser_set_use_preview_label (GtkFileChooser *chooser,
                            gboolean use_label);
    gboolean gtk_file_chooser_get_use_preview_label (GtkFileChooser *chooser);

    char *gtk_file_chooser_get_preview_filename (GtkFileChooser *chooser);
    char *gtk_file_chooser_get_preview_uri (GtkFileChooser *chooser);



    void gtk_file_chooser_set_extra_widget (GtkFileChooser *chooser,
                        GtkWidget *extra_widget);
    GtkWidget *gtk_file_chooser_get_extra_widget (GtkFileChooser *chooser);



    void gtk_file_chooser_add_filter (GtkFileChooser *chooser,
                        GtkFileFilter *filter);
    void gtk_file_chooser_remove_filter (GtkFileChooser *chooser,
                        GtkFileFilter *filter);
    GSList *gtk_file_chooser_list_filters (GtkFileChooser *chooser);



    void gtk_file_chooser_set_filter (GtkFileChooser *chooser,
                        GtkFileFilter *filter);
    GtkFileFilter *gtk_file_chooser_get_filter (GtkFileChooser *chooser);



    gboolean gtk_file_chooser_add_shortcut_folder (GtkFileChooser *chooser,
                            char *folder,
                            GError **error);
    gboolean gtk_file_chooser_remove_shortcut_folder (GtkFileChooser *chooser,
                            char *folder,
                            GError **error);
    GSList *gtk_file_chooser_list_shortcut_folders (GtkFileChooser *chooser);

    gboolean gtk_file_chooser_add_shortcut_folder_uri (GtkFileChooser *chooser,
                            char *uri,
                            GError **error);
    gboolean gtk_file_chooser_remove_shortcut_folder_uri (GtkFileChooser *chooser,
                            char *uri,
                            GError **error);
    GSList *gtk_file_chooser_list_shortcut_folder_uris (GtkFileChooser *chooser);




    alias _GtkFileChooserDialog GtkFileChooserDialog;

    alias _GtkFileChooserDialogClass GtkFileChooserDialogClass;


    alias _GtkFileChooserDialogPrivate GtkFileChooserDialogPrivate;
    alias void _GtkFileChooserDialogPrivate;


    struct _GtkFileChooserDialogClass {
    GtkDialogClass parent_class;
    }

    struct _GtkFileChooserDialog {
    GtkDialog parent_instance;

    GtkFileChooserDialogPrivate *priv;
    }

    GType gtk_file_chooser_dialog_get_type ();
    GtkWidget *gtk_file_chooser_dialog_new ( gchar *title,
                            GtkWindow *parent,
                            GtkFileChooserAction action,
                            gchar *first_button_text,
                            ...);
    GtkWidget *gtk_file_chooser_dialog_new_with_backend ( gchar *title,
                            GtkWindow *parent,
                            GtkFileChooserAction action,
                            gchar *backend,
                            gchar *first_button_text,
                            ...);



    alias _GtkFileChooserWidget GtkFileChooserWidget;

    alias _GtkFileChooserWidgetClass GtkFileChooserWidgetClass;


    alias _GtkFileChooserWidgetPrivate GtkFileChooserWidgetPrivate;
    alias void _GtkFileChooserWidgetPrivate;


    struct _GtkFileChooserWidgetClass {
    GtkVBoxClass parent_class;
    }

    struct _GtkFileChooserWidget {
    GtkVBox parent_instance;

    GtkFileChooserWidgetPrivate *priv;
    }

    GType gtk_file_chooser_widget_get_type ();
    GtkWidget *gtk_file_chooser_widget_new (GtkFileChooserAction action);
    GtkWidget *gtk_file_chooser_widget_new_with_backend (GtkFileChooserAction action,
                            gchar *backend);


    alias _GtkFontButton GtkFontButton;

    alias _GtkFontButtonClass GtkFontButtonClass;

    alias _GtkFontButtonPrivate GtkFontButtonPrivate;
    alias void _GtkFontButtonPrivate;


    struct _GtkFontButton {
    GtkButton button;


    GtkFontButtonPrivate *priv;
    }

    struct _GtkFontButtonClass {
    GtkButtonClass parent_class;


    void (* font_set) (GtkFontButton *gfp);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_font_button_get_type () ;
    GtkWidget *gtk_font_button_new ();
    GtkWidget *gtk_font_button_new_with_font ( gchar *fontname);

    gchar *gtk_font_button_get_title (GtkFontButton *font_button);
    void gtk_font_button_set_title (GtkFontButton *font_button,
                            gchar *title);
    gboolean gtk_font_button_get_use_font (GtkFontButton *font_button);
    void gtk_font_button_set_use_font (GtkFontButton *font_button,
                            gboolean use_font);
    gboolean gtk_font_button_get_use_size (GtkFontButton *font_button);
    void gtk_font_button_set_use_size (GtkFontButton *font_button,
                            gboolean use_size);
    gchar* gtk_font_button_get_font_name (GtkFontButton *font_button);
    gboolean gtk_font_button_set_font_name (GtkFontButton *font_button,
                            gchar *fontname);
    gboolean gtk_font_button_get_show_style (GtkFontButton *font_button);
    void gtk_font_button_set_show_style (GtkFontButton *font_button,
                            gboolean show_style);
    gboolean gtk_font_button_get_show_size (GtkFontButton *font_button);
    void gtk_font_button_set_show_size (GtkFontButton *font_button,
                            gboolean show_size);


    alias _GtkFontSelection GtkFontSelection;

    alias _GtkFontSelectionClass GtkFontSelectionClass;


    alias _GtkFontSelectionDialog GtkFontSelectionDialog;

    alias _GtkFontSelectionDialogClass GtkFontSelectionDialogClass;


    struct _GtkFontSelection {
    GtkVBox parent_instance;

    GtkWidget *font_entry;
    GtkWidget *family_list;
    GtkWidget *font_style_entry;
    GtkWidget *face_list;
    GtkWidget *size_entry;
    GtkWidget *size_list;
    GtkWidget *pixels_button;
    GtkWidget *points_button;
    GtkWidget *filter_button;
    GtkWidget *preview_entry;

    PangoFontFamily *family;
    PangoFontFace *face;

    gint size;

    GdkFont *font;


    }

    struct _GtkFontSelectionClass {
    GtkVBoxClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    struct _GtkFontSelectionDialog {
    GtkDialog parent_instance;


    GtkWidget *fontsel;

    GtkWidget *main_vbox;
    GtkWidget *action_area;

    GtkWidget *ok_button;
    GtkWidget *apply_button;
    GtkWidget *cancel_button;






    gint dialog_width;
    gboolean auto_resize;
    }

    struct _GtkFontSelectionDialogClass {
    GtkDialogClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }
    GType gtk_font_selection_get_type () ;
    GtkWidget* gtk_font_selection_new ();
    gchar* gtk_font_selection_get_font_name (GtkFontSelection *fontsel);


    GdkFont* gtk_font_selection_get_font (GtkFontSelection *fontsel);


    gboolean gtk_font_selection_set_font_name (GtkFontSelection *fontsel,
                                gchar *fontname);
    gchar* gtk_font_selection_get_preview_text (GtkFontSelection *fontsel);
    void gtk_font_selection_set_preview_text (GtkFontSelection *fontsel,
                                gchar *text);







    GType gtk_font_selection_dialog_get_type () ;
    GtkWidget* gtk_font_selection_dialog_new ( gchar *title);






    gchar* gtk_font_selection_dialog_get_font_name (GtkFontSelectionDialog *fsd);





    GdkFont* gtk_font_selection_dialog_get_font (GtkFontSelectionDialog *fsd);






    gboolean gtk_font_selection_dialog_set_font_name (GtkFontSelectionDialog *fsd,
                            gchar *fontname);



    gchar* gtk_font_selection_dialog_get_preview_text (GtkFontSelectionDialog *fsd);



    void gtk_font_selection_dialog_set_preview_text (GtkFontSelectionDialog *fsd,
                            gchar *text);

    alias _GtkGammaCurve GtkGammaCurve;

    alias _GtkGammaCurveClass GtkGammaCurveClass;



    struct _GtkGammaCurve {
    GtkVBox vbox;

    GtkWidget *table;
    GtkWidget *curve;
    GtkWidget *button[5];

    gfloat gamma;
    GtkWidget *gamma_dialog;
    GtkWidget *gamma_text;
    }

    struct _GtkGammaCurveClass {
    GtkVBoxClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_gamma_curve_get_type () ;
    GtkWidget* gtk_gamma_curve_new ();
    GdkGC* gtk_gc_get (gint depth,
            GdkColormap *colormap,
            GdkGCValues *values,
            GdkGCValuesMask values_mask);
    void gtk_gc_release (GdkGC *gc);
    alias _GtkHandleBox GtkHandleBox;

    alias _GtkHandleBoxClass GtkHandleBoxClass;


    struct _GtkHandleBox {
    GtkBin bin;

    GdkWindow *bin_window;
    GdkWindow *float_window;
    GtkShadowType shadow_type;
    guint handle_position;
    guint float_window_mapped;
    guint child_detached;
    guint in_drag;
    guint shrink_on_detach;

    int snap_edge;



    gint deskoff_x, deskoff_y;

    GtkAllocation attach_allocation;
    GtkAllocation float_allocation;
    }

    struct _GtkHandleBoxClass {
    GtkBinClass parent_class;

    void (*child_attached) (GtkHandleBox *handle_box,
                    GtkWidget *child);
    void (*child_detached) (GtkHandleBox *handle_box,
                    GtkWidget *child);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_handle_box_get_type () ;
    GtkWidget* gtk_handle_box_new ();
    void gtk_handle_box_set_shadow_type (GtkHandleBox *handle_box,
                            GtkShadowType type);
    GtkShadowType gtk_handle_box_get_shadow_type (GtkHandleBox *handle_box);
    void gtk_handle_box_set_handle_position (GtkHandleBox *handle_box,
                            GtkPositionType position);
    GtkPositionType gtk_handle_box_get_handle_position(GtkHandleBox *handle_box);
    void gtk_handle_box_set_snap_edge (GtkHandleBox *handle_box,
                            GtkPositionType edge);
    GtkPositionType gtk_handle_box_get_snap_edge (GtkHandleBox *handle_box);
    alias _GtkHButtonBox GtkHButtonBox;

    alias _GtkHButtonBoxClass GtkHButtonBoxClass;


    struct _GtkHButtonBox {
    GtkButtonBox button_box;
    }

    struct _GtkHButtonBoxClass {
    GtkButtonBoxClass parent_class;
    }


    GType gtk_hbutton_box_get_type () ;
    GtkWidget* gtk_hbutton_box_new ();




    gint gtk_hbutton_box_get_spacing_default ();
    GtkButtonBoxStyle gtk_hbutton_box_get_layout_default ();

    void gtk_hbutton_box_set_spacing_default (gint spacing);
    void gtk_hbutton_box_set_layout_default (GtkButtonBoxStyle layout);

    alias _GtkPaned GtkPaned;

    alias _GtkPanedClass GtkPanedClass;

    alias _GtkPanedPrivate GtkPanedPrivate;
    alias void _GtkPanedPrivate;


    struct _GtkPaned {
    GtkContainer container;

    GtkWidget *child1;
    GtkWidget *child2;

    GdkWindow *handle;
    GdkGC *xor_gc;
    GdkCursorType cursor_type;


    GdkRectangle handle_pos;

    gint child1_size;
    gint last_allocation;
    gint min_position;
    gint max_position;

    guint position_set;
    guint in_drag;
    guint child1_shrink;
    guint child1_resize;
    guint child2_shrink;
    guint child2_resize;
    guint orientation;
    guint in_recursion;
    guint handle_prelit;

    GtkWidget *last_child1_focus;
    GtkWidget *last_child2_focus;
    GtkPanedPrivate *priv;

    gint drag_pos;
    gint original_position;
    }

    struct _GtkPanedClass {
    GtkContainerClass parent_class;

    gboolean (* cycle_child_focus) (GtkPaned *paned,
                    gboolean reverse);
    gboolean (* toggle_handle_focus) (GtkPaned *paned);
    gboolean (* move_handle) (GtkPaned *paned,
                    GtkScrollType scroll);
    gboolean (* cycle_handle_focus) (GtkPaned *paned,
                    gboolean reverse);
    gboolean (* accept_position) (GtkPaned *paned);
    gboolean (* cancel_position) (GtkPaned *paned);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_paned_get_type () ;
    void gtk_paned_add1 (GtkPaned *paned,
                    GtkWidget *child);
    void gtk_paned_add2 (GtkPaned *paned,
                    GtkWidget *child);
    void gtk_paned_pack1 (GtkPaned *paned,
                    GtkWidget *child,
                    gboolean resize,
                    gboolean shrink);
    void gtk_paned_pack2 (GtkPaned *paned,
                    GtkWidget *child,
                    gboolean resize,
                    gboolean shrink);
    gint gtk_paned_get_position (GtkPaned *paned);
    void gtk_paned_set_position (GtkPaned *paned,
                    gint position);

    GtkWidget *gtk_paned_get_child1 (GtkPaned *paned);
    GtkWidget *gtk_paned_get_child2 (GtkPaned *paned);



    void gtk_paned_compute_position (GtkPaned *paned,
                    gint allocation,
                    gint child1_req,
                    gint child2_req);
    alias _GtkHPaned GtkHPaned;

    alias _GtkHPanedClass GtkHPanedClass;


    struct _GtkHPaned {
    GtkPaned paned;
    }

    struct _GtkHPanedClass {
    GtkPanedClass parent_class;
    }

    GType gtk_hpaned_get_type () ;
    GtkWidget *gtk_hpaned_new ();
    alias _GtkRuler GtkRuler;

    alias _GtkRulerClass GtkRulerClass;

    alias _GtkRulerMetric GtkRulerMetric;





    struct _GtkRuler {
    GtkWidget widget;

    GdkPixmap *backing_store;
    GdkGC *non_gr_exp_gc;
    GtkRulerMetric *metric;
    gint xsrc, ysrc;
    gint slider_size;


    gdouble lower;

    gdouble upper;

    gdouble position;

    gdouble max_size;
    }

    struct _GtkRulerClass {
    GtkWidgetClass parent_class;

    void (* draw_ticks) (GtkRuler *ruler);
    void (* draw_pos) (GtkRuler *ruler);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    struct _GtkRulerMetric {
    gchar *metric_name;
    gchar *abbrev;


    gdouble pixels_per_unit;
    gdouble ruler_scale[10];
    gint subdivide[5];
    }


    GType gtk_ruler_get_type () ;
    void gtk_ruler_set_metric (GtkRuler *ruler,
                GtkMetricType metric);
    void gtk_ruler_set_range (GtkRuler *ruler,
                gdouble lower,
                gdouble upper,
                gdouble position,
                gdouble max_size);
    void gtk_ruler_draw_ticks (GtkRuler *ruler);
    void gtk_ruler_draw_pos (GtkRuler *ruler);

    GtkMetricType gtk_ruler_get_metric (GtkRuler *ruler);
    void gtk_ruler_get_range (GtkRuler *ruler,
                    gdouble *lower,
                    gdouble *upper,
                    gdouble *position,
                    gdouble *max_size);
    alias _GtkHRuler GtkHRuler;

    alias _GtkHRulerClass GtkHRulerClass;


    struct _GtkHRuler {
    GtkRuler ruler;
    }

    struct _GtkHRulerClass {
    GtkRulerClass parent_class;
    }


    GType gtk_hruler_get_type () ;
    GtkWidget* gtk_hruler_new ();
    alias _GtkScale GtkScale;

    alias _GtkScaleClass GtkScaleClass;


    struct _GtkScale {
    GtkRange range;

    gint digits;
    guint draw_value;
    guint value_pos;
    }

    struct _GtkScaleClass {
    GtkRangeClass parent_class;

    gchar* (* format_value) (GtkScale *scale,
                gdouble value);

    void (* draw_value) (GtkScale *scale);

    void (* get_layout_offsets) (GtkScale *scale,
                gint *x,
                gint *y);

    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_scale_get_type () ;

    void gtk_scale_set_digits (GtkScale *scale,
                        gint digits);
    gint gtk_scale_get_digits (GtkScale *scale);
    void gtk_scale_set_draw_value (GtkScale *scale,
                        gboolean draw_value);
    gboolean gtk_scale_get_draw_value (GtkScale *scale);
    void gtk_scale_set_value_pos (GtkScale *scale,
                        GtkPositionType pos);
    GtkPositionType gtk_scale_get_value_pos (GtkScale *scale);

    PangoLayout *gtk_scale_get_layout (GtkScale *scale);
    void gtk_scale_get_layout_offsets (GtkScale *scale,
                        gint *x,
                        gint *y);
    void _gtk_scale_clear_layout (GtkScale *scale);

    void _gtk_scale_get_value_size (GtkScale *scale,
                    gint *width,
                    gint *height);
    gchar *_gtk_scale_format_value (GtkScale *scale,
                    gdouble value);
    alias _GtkHScale GtkHScale;

    alias _GtkHScaleClass GtkHScaleClass;


    struct _GtkHScale {
    GtkScale scale;
    }

    struct _GtkHScaleClass {
    GtkScaleClass parent_class;
    }


    GType gtk_hscale_get_type () ;
    GtkWidget* gtk_hscale_new (GtkAdjustment *adjustment);
    GtkWidget* gtk_hscale_new_with_range (gdouble min,
                    gdouble max,
                    gdouble step);

    alias _GtkSeparator GtkSeparator;

    alias _GtkSeparatorClass GtkSeparatorClass;


    struct _GtkSeparator {
    GtkWidget widget;
    }

    struct _GtkSeparatorClass {
    GtkWidgetClass parent_class;
    }


    GType gtk_separator_get_type () ;
    alias _GtkHSeparator GtkHSeparator;

    alias _GtkHSeparatorClass GtkHSeparatorClass;


    struct _GtkHSeparator {
    GtkSeparator separator;
    }

    struct _GtkHSeparatorClass {
    GtkSeparatorClass parent_class;
    }


    GType gtk_hseparator_get_type () ;
    GtkWidget* gtk_hseparator_new ();
    alias _GtkIconFactoryClass GtkIconFactoryClass;

    struct _GtkIconFactory {
    GObject parent_instance;

    GHashTable *icons;
    }

    struct _GtkIconFactoryClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_icon_factory_get_type ();
    GtkIconFactory* gtk_icon_factory_new ();
    void gtk_icon_factory_add (GtkIconFactory *factory,
                        gchar *stock_id,
                        GtkIconSet *icon_set);
    GtkIconSet* gtk_icon_factory_lookup (GtkIconFactory *factory,
                        gchar *stock_id);



    void gtk_icon_factory_add_default (GtkIconFactory *factory);
    void gtk_icon_factory_remove_default (GtkIconFactory *factory);
    GtkIconSet* gtk_icon_factory_lookup_default ( gchar *stock_id);
    gboolean gtk_icon_size_lookup (GtkIconSize size,
                        gint *width,
                        gint *height);

    gboolean gtk_icon_size_lookup_for_settings (GtkSettings *settings,
                        GtkIconSize size,
                        gint *width,
                        gint *height);

    GtkIconSize gtk_icon_size_register ( gchar *name,
                            gint width,
                            gint height);
    void gtk_icon_size_register_alias ( gchar *Alias,
                            GtkIconSize target);
    GtkIconSize gtk_icon_size_from_name ( gchar *name);
    gchar* gtk_icon_size_get_name (GtkIconSize size);



    GType gtk_icon_set_get_type ();
    GtkIconSet* gtk_icon_set_new ();
    GtkIconSet* gtk_icon_set_new_from_pixbuf (GdkPixbuf *pixbuf);

    GtkIconSet* gtk_icon_set_ref (GtkIconSet *icon_set);
    void gtk_icon_set_unref (GtkIconSet *icon_set);
    GtkIconSet* gtk_icon_set_copy (GtkIconSet *icon_set);




    GdkPixbuf* gtk_icon_set_render_icon (GtkIconSet *icon_set,
                        GtkStyle *style,
                        GtkTextDirection direction,
                        GtkStateType state,
                        GtkIconSize size,
                        GtkWidget *widget,
                        char *detail);


    void gtk_icon_set_add_source (GtkIconSet *icon_set,
                        GtkIconSource *source);

    void gtk_icon_set_get_sizes (GtkIconSet *icon_set,
                        GtkIconSize **sizes,
                        gint *n_sizes);

    GType gtk_icon_source_get_type ();
    GtkIconSource* gtk_icon_source_new ();
    GtkIconSource* gtk_icon_source_copy ( GtkIconSource *source);
    void gtk_icon_source_free (GtkIconSource *source);

    void gtk_icon_source_set_filename (GtkIconSource *source,
                                gchar *filename);
    void gtk_icon_source_set_icon_name (GtkIconSource *source,
                                gchar *icon_name);
    void gtk_icon_source_set_pixbuf (GtkIconSource *source,
                                GdkPixbuf *pixbuf);

    gchar* gtk_icon_source_get_filename ( GtkIconSource *source);
    gchar* gtk_icon_source_get_icon_name ( GtkIconSource *source);
    GdkPixbuf* gtk_icon_source_get_pixbuf ( GtkIconSource *source);

    void gtk_icon_source_set_direction_wildcarded (GtkIconSource *source,
                                gboolean setting);
    void gtk_icon_source_set_state_wildcarded (GtkIconSource *source,
                                gboolean setting);
    void gtk_icon_source_set_size_wildcarded (GtkIconSource *source,
                                gboolean setting);
    gboolean gtk_icon_source_get_size_wildcarded ( GtkIconSource *source);
    gboolean gtk_icon_source_get_state_wildcarded ( GtkIconSource *source);
    gboolean gtk_icon_source_get_direction_wildcarded ( GtkIconSource *source);
    void gtk_icon_source_set_direction (GtkIconSource *source,
                                GtkTextDirection direction);
    void gtk_icon_source_set_state (GtkIconSource *source,
                                GtkStateType state);
    void gtk_icon_source_set_size (GtkIconSource *source,
                                GtkIconSize size);
    GtkTextDirection gtk_icon_source_get_direction ( GtkIconSource *source);
    GtkStateType gtk_icon_source_get_state ( GtkIconSource *source);
    GtkIconSize gtk_icon_source_get_size ( GtkIconSource *source);



    void _gtk_icon_set_invalidate_caches ();
    GSList* _gtk_icon_factory_list_ids ();

    alias _GtkIconInfo GtkIconInfo;
    alias void _GtkIconInfo;

    alias _GtkIconTheme GtkIconTheme;

    alias _GtkIconThemeClass GtkIconThemeClass;

    alias _GtkIconThemePrivate GtkIconThemePrivate;
    alias void _GtkIconThemePrivate;


    struct _GtkIconTheme {

    GObject parent_instance;

    GtkIconThemePrivate *priv;
    }

    struct _GtkIconThemeClass {
    GObjectClass parent_class;

    void (* changed) (GtkIconTheme *icon_theme);
    }
    enum GtkIconLookupFlags {
    GTK_ICON_LOOKUP_NO_SVG = 1 << 0,
    GTK_ICON_LOOKUP_FORCE_SVG = 1 << 1,
    GTK_ICON_LOOKUP_USE_BUILTIN = 1 << 2
    };

    enum GtkIconThemeError {
    GTK_ICON_THEME_NOT_FOUND,
    GTK_ICON_THEME_FAILED
    };


    GQuark gtk_icon_theme_error_quark () ;

    GType gtk_icon_theme_get_type () ;

    GtkIconTheme *gtk_icon_theme_new ();
    GtkIconTheme *gtk_icon_theme_get_default ();
    GtkIconTheme *gtk_icon_theme_get_for_screen (GdkScreen *screen);
    void gtk_icon_theme_set_screen (GtkIconTheme *icon_theme,
                            GdkScreen *screen);

    void gtk_icon_theme_set_search_path (GtkIconTheme *icon_theme,
                            gchar *path[],
                            gint n_elements);
    void gtk_icon_theme_get_search_path (GtkIconTheme *icon_theme,
                            gchar **path[],
                            gint *n_elements);
    void gtk_icon_theme_append_search_path (GtkIconTheme *icon_theme,
                            gchar *path);
    void gtk_icon_theme_prepend_search_path (GtkIconTheme *icon_theme,
                            gchar *path);

    void gtk_icon_theme_set_custom_theme (GtkIconTheme *icon_theme,
                            gchar *theme_name);

    gboolean gtk_icon_theme_has_icon (GtkIconTheme *icon_theme,
                            gchar *icon_name);
    GtkIconInfo * gtk_icon_theme_lookup_icon (GtkIconTheme *icon_theme,
                            gchar *icon_name,
                            gint size,
                            GtkIconLookupFlags flags);
    GdkPixbuf * gtk_icon_theme_load_icon (GtkIconTheme *icon_theme,
                            gchar *icon_name,
                            gint size,
                            GtkIconLookupFlags flags,
                            GError **error);

    GList * gtk_icon_theme_list_icons (GtkIconTheme *icon_theme,
                            gchar *context);
    char * gtk_icon_theme_get_example_icon_name (GtkIconTheme *icon_theme);

    gboolean gtk_icon_theme_rescan_if_needed (GtkIconTheme *icon_theme);

    void gtk_icon_theme_add_builtin_icon ( gchar *icon_name,
                        gint size,
                        GdkPixbuf *pixbuf);

    GType gtk_icon_info_get_type ();
    GtkIconInfo *gtk_icon_info_copy (GtkIconInfo *icon_info);
    void gtk_icon_info_free (GtkIconInfo *icon_info);

    gint gtk_icon_info_get_base_size (GtkIconInfo *icon_info);
    gchar *gtk_icon_info_get_filename (GtkIconInfo *icon_info);
    GdkPixbuf * gtk_icon_info_get_builtin_pixbuf (GtkIconInfo *icon_info);
    GdkPixbuf * gtk_icon_info_load_icon (GtkIconInfo *icon_info,
                                GError **error);

    void gtk_icon_info_set_raw_coordinates (GtkIconInfo *icon_info,
                                gboolean raw_coordinates);

    gboolean gtk_icon_info_get_embedded_rect (GtkIconInfo *icon_info,
                            GdkRectangle *rectangle);
    gboolean gtk_icon_info_get_attach_points (GtkIconInfo *icon_info,
                            GdkPoint **points,
                            gint *n_points);
    gchar *gtk_icon_info_get_display_name (GtkIconInfo *icon_info);


    alias _GtkImage GtkImage;

    alias _GtkImageClass GtkImageClass;


    alias _GtkImagePixmapData GtkImagePixmapData;

    alias _GtkImageImageData GtkImageImageData;

    alias _GtkImagePixbufData GtkImagePixbufData;

    alias _GtkImageStockData GtkImageStockData;

    alias _GtkImageIconSetData GtkImageIconSetData;

    alias _GtkImageAnimationData GtkImageAnimationData;


    struct _GtkImagePixmapData {
    GdkPixmap *pixmap;
    }

    struct _GtkImageImageData {
    GdkImage *image;
    }

    struct _GtkImagePixbufData {
    GdkPixbuf *pixbuf;
    }

    struct _GtkImageStockData {
    gchar *stock_id;
    }

    struct _GtkImageIconSetData {
    GtkIconSet *icon_set;
    }

    struct _GtkImageAnimationData {
    GdkPixbufAnimation *anim;
    GdkPixbufAnimationIter *iter;
    guint frame_timeout;
    }

    enum GtkImageType {
    GTK_IMAGE_EMPTY,
    GTK_IMAGE_PIXMAP,
    GTK_IMAGE_IMAGE,
    GTK_IMAGE_PIXBUF,
    GTK_IMAGE_STOCK,
    GTK_IMAGE_ICON_SET,
    GTK_IMAGE_ANIMATION
    };


    struct _GtkImage {
    GtkMisc misc;

    GtkImageType storage_type;

    union data_union
    {
    GtkImagePixmapData pixmap;
    GtkImageImageData image;
    GtkImagePixbufData pixbuf;
    GtkImageStockData stock;
    GtkImageIconSetData icon_set;
    GtkImageAnimationData anim;
    }
    data_union data;


    GdkBitmap *mask;


    GtkIconSize icon_size;
    }

    struct _GtkImageClass {
    GtkMiscClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_image_get_type () ;

    GtkWidget* gtk_image_new ();
    GtkWidget* gtk_image_new_from_pixmap (GdkPixmap *pixmap,
                        GdkBitmap *mask);
    GtkWidget* gtk_image_new_from_image (GdkImage *image,
                        GdkBitmap *mask);
    GtkWidget* gtk_image_new_from_file ( gchar *filename);
    GtkWidget* gtk_image_new_from_pixbuf (GdkPixbuf *pixbuf);
    GtkWidget* gtk_image_new_from_stock ( gchar *stock_id,
                        GtkIconSize size);
    GtkWidget* gtk_image_new_from_icon_set (GtkIconSet *icon_set,
                        GtkIconSize size);
    GtkWidget* gtk_image_new_from_animation (GdkPixbufAnimation *animation);

    void gtk_image_set_from_pixmap (GtkImage *image,
                    GdkPixmap *pixmap,
                    GdkBitmap *mask);
    void gtk_image_set_from_image (GtkImage *image,
                    GdkImage *gdk_image,
                    GdkBitmap *mask);
    void gtk_image_set_from_file (GtkImage *image,
                    gchar *filename);
    void gtk_image_set_from_pixbuf (GtkImage *image,
                    GdkPixbuf *pixbuf);
    void gtk_image_set_from_stock (GtkImage *image,
                    gchar *stock_id,
                    GtkIconSize size);
    void gtk_image_set_from_icon_set (GtkImage *image,
                    GtkIconSet *icon_set,
                    GtkIconSize size);
    void gtk_image_set_from_animation (GtkImage *image,
                    GdkPixbufAnimation *animation);

    GtkImageType gtk_image_get_storage_type (GtkImage *image);

    void gtk_image_get_pixmap (GtkImage *image,
                    GdkPixmap **pixmap,
                    GdkBitmap **mask);
    void gtk_image_get_image (GtkImage *image,
                    GdkImage **gdk_image,
                    GdkBitmap **mask);
    GdkPixbuf* gtk_image_get_pixbuf (GtkImage *image);
    void gtk_image_get_stock (GtkImage *image,
                    gchar **stock_id,
                    GtkIconSize *size);
    void gtk_image_get_icon_set (GtkImage *image,
                    GtkIconSet **icon_set,
                    GtkIconSize *size);
    GdkPixbufAnimation* gtk_image_get_animation (GtkImage *image);





    void gtk_image_set (GtkImage *image,
                GdkImage *val,
                GdkBitmap *mask);
    void gtk_image_get (GtkImage *image,
                GdkImage **val,
                GdkBitmap **mask);
    alias _GtkImageMenuItem GtkImageMenuItem;

    alias _GtkImageMenuItemClass GtkImageMenuItemClass;


    struct _GtkImageMenuItem {
    GtkMenuItem menu_item;


    GtkWidget *image;
    }

    struct _GtkImageMenuItemClass {
    GtkMenuItemClass parent_class;
    }


    GType gtk_image_menu_item_get_type () ;
    GtkWidget* gtk_image_menu_item_new ();
    GtkWidget* gtk_image_menu_item_new_with_label ( gchar *label);
    GtkWidget* gtk_image_menu_item_new_with_mnemonic ( gchar *label);
    GtkWidget* gtk_image_menu_item_new_from_stock ( gchar *stock_id,
                            GtkAccelGroup *accel_group);
    void gtk_image_menu_item_set_image (GtkImageMenuItem *image_menu_item,
                            GtkWidget *image);
    GtkWidget* gtk_image_menu_item_get_image (GtkImageMenuItem *image_menu_item);

    alias _GtkIMContextSimple GtkIMContextSimple;

    alias _GtkIMContextSimpleClass GtkIMContextSimpleClass;




    struct _GtkIMContextSimple {
    GtkIMContext object;

    GSList *tables;

    guint compose_buffer[7 + 1];
    gunichar tentative_match;
    gint tentative_match_len;

    guint in_hex_sequence;
    }

    struct _GtkIMContextSimpleClass {
    GtkIMContextClass parent_class;
    }

    GType gtk_im_context_simple_get_type () ;
    GtkIMContext *gtk_im_context_simple_new ();

    void gtk_im_context_simple_add_table (GtkIMContextSimple *context_simple,
                        guint16 *data,
                        gint max_seq_len,
                        gint n_seqs);
    alias _GtkIMMulticontext GtkIMMulticontext;

    alias _GtkIMMulticontextClass GtkIMMulticontextClass;

    alias _GtkIMMulticontextPrivate GtkIMMulticontextPrivate;
    alias void _GtkIMMulticontextPrivate;


    struct _GtkIMMulticontext {
    GtkIMContext object;

    GtkIMContext *slave;

    GtkIMMulticontextPrivate *priv;

    gchar *context_id;
    }

    struct _GtkIMMulticontextClass {
    GtkIMContextClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_im_multicontext_get_type () ;
    GtkIMContext *gtk_im_multicontext_new ();

    void gtk_im_multicontext_append_menuitems (GtkIMMulticontext *context,
                            GtkMenuShell *menushell);
    alias _GtkInputDialog GtkInputDialog;

    alias _GtkInputDialogClass GtkInputDialogClass;


    struct _GtkInputDialog {
    GtkDialog dialog;

    GtkWidget *axis_list;
    GtkWidget *axis_listbox;
    GtkWidget *mode_optionmenu;

    GtkWidget *close_button;
    GtkWidget *save_button;

    GtkWidget *axis_items[GdkAxisUse.GDK_AXIS_LAST];
    GdkDevice *current_device;

    GtkWidget *keys_list;
    GtkWidget *keys_listbox;
    }

    struct _GtkInputDialogClass {
    GtkDialogClass parent_class;

    void (* enable_device) (GtkInputDialog *inputd,
                        GdkDevice *device);
    void (* disable_device) (GtkInputDialog *inputd,
                        GdkDevice *device);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_input_dialog_get_type () ;
    GtkWidget* gtk_input_dialog_new ();

    alias _GtkInvisible GtkInvisible;

    alias _GtkInvisibleClass GtkInvisibleClass;


    struct _GtkInvisible {
    GtkWidget widget;
    gboolean has_user_ref_count;
    GdkScreen *screen;
    }

    struct _GtkInvisibleClass {
    GtkWidgetClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_invisible_get_type () ;

    GtkWidget* gtk_invisible_new ();
    GtkWidget* gtk_invisible_new_for_screen (GdkScreen *screen);
    void gtk_invisible_set_screen (GtkInvisible *invisible,
                        GdkScreen *screen);
    GdkScreen* gtk_invisible_get_screen (GtkInvisible *invisible);





    alias _GtkLayout GtkLayout;

    alias _GtkLayoutClass GtkLayoutClass;


    struct _GtkLayout {
    GtkContainer container;

    GList *children;

    guint width;
    guint height;

    GtkAdjustment *hadjustment;
    GtkAdjustment *vadjustment;


    GdkWindow *bin_window;


    GdkVisibilityState visibility;
    gint scroll_x;
    gint scroll_y;

    guint freeze_count;
    }

    struct _GtkLayoutClass {
    GtkContainerClass parent_class;

    void (*set_scroll_adjustments) (GtkLayout *layout,
                    GtkAdjustment *hadjustment,
                    GtkAdjustment *vadjustment);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_layout_get_type () ;
    GtkWidget* gtk_layout_new (GtkAdjustment *hadjustment,
                        GtkAdjustment *vadjustment);
    void gtk_layout_put (GtkLayout *layout,
                        GtkWidget *child_widget,
                        gint x,
                        gint y);

    void gtk_layout_move (GtkLayout *layout,
                        GtkWidget *child_widget,
                        gint x,
                        gint y);

    void gtk_layout_set_size (GtkLayout *layout,
                        guint width,
                        guint height);
    void gtk_layout_get_size (GtkLayout *layout,
                        guint *width,
                        guint *height);

    GtkAdjustment* gtk_layout_get_hadjustment (GtkLayout *layout);
    GtkAdjustment* gtk_layout_get_vadjustment (GtkLayout *layout);
    void gtk_layout_set_hadjustment (GtkLayout *layout,
                        GtkAdjustment *adjustment);
    void gtk_layout_set_vadjustment (GtkLayout *layout,
                        GtkAdjustment *adjustment);
    void gtk_layout_freeze (GtkLayout *layout);
    void gtk_layout_thaw (GtkLayout *layout);
    alias _GtkListItem GtkListItem;

    alias _GtkListItemClass GtkListItemClass;


    struct _GtkListItem {
    GtkItem item;
    }

    struct _GtkListItemClass {
    GtkItemClass parent_class;

    void (*toggle_focus_row) (GtkListItem *list_item);
    void (*select_all) (GtkListItem *list_item);
    void (*unselect_all) (GtkListItem *list_item);
    void (*undo_selection) (GtkListItem *list_item);
    void (*start_selection) (GtkListItem *list_item);
    void (*end_selection) (GtkListItem *list_item);
    void (*extend_selection) (GtkListItem *list_item,
                GtkScrollType scroll_type,
                gfloat position,
                gboolean auto_start_selection);
    void (*scroll_horizontal) (GtkListItem *list_item,
                GtkScrollType scroll_type,
                gfloat position);
    void (*scroll_vertical) (GtkListItem *list_item,
                GtkScrollType scroll_type,
                gfloat position);
    void (*toggle_add_mode) (GtkListItem *list_item);
    }


    GtkType gtk_list_item_get_type () ;
    GtkWidget* gtk_list_item_new ();
    GtkWidget* gtk_list_item_new_with_label ( gchar *label);
    void gtk_list_item_select (GtkListItem *list_item);
    void gtk_list_item_deselect (GtkListItem *list_item);
    alias _GtkList GtkList;

    alias _GtkListClass GtkListClass;


    struct _GtkList {
    GtkContainer container;

    GList *children;
    GList *selection;

    GList *undo_selection;
    GList *undo_unselection;

    GtkWidget *last_focus_child;
    GtkWidget *undo_focus_child;

    guint htimer;
    guint vtimer;

    gint anchor;
    gint drag_pos;
    GtkStateType anchor_state;

    guint selection_mode;
    guint drag_selection;
    guint add_mode;
    }

    struct _GtkListClass {
    GtkContainerClass parent_class;

    void (* selection_changed) (GtkList *list);
    void (* select_child) (GtkList *list,
                GtkWidget *child);
    void (* unselect_child) (GtkList *list,
                GtkWidget *child);
    }


    GtkType gtk_list_get_type () ;
    GtkWidget* gtk_list_new ();
    void gtk_list_insert_items (GtkList *list,
                        GList *items,
                        gint position);
    void gtk_list_append_items (GtkList *list,
                        GList *items);
    void gtk_list_prepend_items (GtkList *list,
                        GList *items);
    void gtk_list_remove_items (GtkList *list,
                        GList *items);
    void gtk_list_remove_items_no_unref (GtkList *list,
                        GList *items);
    void gtk_list_clear_items (GtkList *list,
                        gint start,
                        gint end);
    void gtk_list_select_item (GtkList *list,
                        gint item);
    void gtk_list_unselect_item (GtkList *list,
                        gint item);
    void gtk_list_select_child (GtkList *list,
                        GtkWidget *child);
    void gtk_list_unselect_child (GtkList *list,
                        GtkWidget *child);
    gint gtk_list_child_position (GtkList *list,
                        GtkWidget *child);
    void gtk_list_set_selection_mode (GtkList *list,
                        GtkSelectionMode mode);

    void gtk_list_extend_selection (GtkList *list,
                        GtkScrollType scroll_type,
                        gfloat position,
                        gboolean auto_start_selection);
    void gtk_list_start_selection (GtkList *list);
    void gtk_list_end_selection (GtkList *list);
    void gtk_list_select_all (GtkList *list);
    void gtk_list_unselect_all (GtkList *list);
    void gtk_list_scroll_horizontal (GtkList *list,
                        GtkScrollType scroll_type,
                        gfloat position);
    void gtk_list_scroll_vertical (GtkList *list,
                        GtkScrollType scroll_type,
                        gfloat position);
    void gtk_list_toggle_add_mode (GtkList *list);
    void gtk_list_toggle_focus_row (GtkList *list);
    void gtk_list_toggle_row (GtkList *list,
                        GtkWidget *item);
    void gtk_list_undo_selection (GtkList *list);
    void gtk_list_end_drag_selection (GtkList *list);

    alias void (*GtkModuleInitFunc) (gint *argc,
                        gchar ***argv);
    alias void (*GtkModuleDisplayInitFunc) (GdkDisplay *display);
    alias gint (*GtkKeySnoopFunc) (GtkWidget *grab_widget,
                        GdkEventKey *event,
                        gpointer func_data);
    guint gtk_major_version;
    guint gtk_minor_version;
    guint gtk_micro_version;
    guint gtk_binary_age;
    guint gtk_interface_age;
    gchar* gtk_check_version (guint required_major,
                guint required_minor,
                guint required_micro);





    gboolean gtk_parse_args (int *argc,
                    char ***argv);

    void gtk_init (int *argc,
                    char ***argv);

    gboolean gtk_init_check (int *argc,
                    char ***argv);
    void gtk_exit (gint error_code);


    void gtk_disable_setlocale ();
    gchar * gtk_set_locale ();
    PangoLanguage *gtk_get_default_language ();
    gboolean gtk_events_pending ();





    void gtk_main_do_event (GdkEvent *event);

    void gtk_main ();
    guint gtk_main_level ();
    void gtk_main_quit ();
    gboolean gtk_main_iteration ();

    gboolean gtk_main_iteration_do (gboolean blocking);

    gboolean gtk_true () ;
    gboolean gtk_false () ;

    void gtk_grab_add (GtkWidget *widget);
    GtkWidget* gtk_grab_get_current ();
    void gtk_grab_remove (GtkWidget *widget);

    void gtk_init_add (GtkFunction Function,
                    gpointer data);
    void gtk_quit_add_destroy (guint main_level,
                    GtkObject *object);
    guint gtk_quit_add (guint main_level,
                    GtkFunction Function,
                    gpointer data);
    guint gtk_quit_add_full (guint main_level,
                    GtkFunction Function,
                    GtkCallbackMarshal marshal,
                    gpointer data,
                    GtkDestroyNotify destroy);
    void gtk_quit_remove (guint quit_handler_id);
    void gtk_quit_remove_by_data (gpointer data);

    guint gtk_timeout_add (guint32 interval,
                    GtkFunction Function,
                    gpointer data);
    guint gtk_timeout_add_full (guint32 interval,
                    GtkFunction Function,
                    GtkCallbackMarshal marshal,
                    gpointer data,
                    GtkDestroyNotify destroy);
    void gtk_timeout_remove (guint timeout_handler_id);

    guint gtk_idle_add (GtkFunction Function,
                    gpointer data);
    guint gtk_idle_add_priority (gint priority,
                    GtkFunction Function,
                    gpointer data);
    guint gtk_idle_add_full (gint priority,
                    GtkFunction Function,
                    GtkCallbackMarshal marshal,
                    gpointer data,
                    GtkDestroyNotify destroy);
    void gtk_idle_remove (guint idle_handler_id);
    void gtk_idle_remove_by_data (gpointer data);
    guint gtk_input_add_full (gint source,
                    GdkInputCondition condition,
                    GdkInputFunction Function,
                    GtkCallbackMarshal marshal,
                    gpointer data,
                    GtkDestroyNotify destroy);
    void gtk_input_remove (guint input_handler_id);


    guint gtk_key_snooper_install (GtkKeySnoopFunc snooper,
                    gpointer func_data);
    void gtk_key_snooper_remove (guint snooper_handler_id);

    GdkEvent* gtk_get_current_event ();
    guint32 gtk_get_current_event_time ();
    gboolean gtk_get_current_event_state (GdkModifierType *state);

    GtkWidget* gtk_get_event_widget (GdkEvent *event);




    void gtk_propagate_event (GtkWidget *widget,
                    GdkEvent *event);

    gboolean _gtk_boolean_handled_accumulator (GSignalInvocationHint *ihint,
                    GValue *return_accu,
                    GValue *handler_return,
                    gpointer dummy);

    gchar * _gtk_find_module ( gchar *name,
                gchar *type);
    gchar **_gtk_get_module_path ( gchar *type);

    gchar *_gtk_get_lc_ctype ();

    alias _GtkMenuBar GtkMenuBar;

    alias _GtkMenuBarClass GtkMenuBarClass;


    struct _GtkMenuBar {
    GtkMenuShell menu_shell;
    }

    struct _GtkMenuBarClass {
    GtkMenuShellClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_menu_bar_get_type () ;
    GtkWidget* gtk_menu_bar_new ();
    void _gtk_menu_bar_cycle_focus (GtkMenuBar *menubar,
                    GtkDirectionType dir);


    enum GtkMessageType {
    GTK_MESSAGE_INFO,
    GTK_MESSAGE_WARNING,
    GTK_MESSAGE_QUESTION,
    GTK_MESSAGE_ERROR
    };


    enum GtkButtonsType {
    GTK_BUTTONS_NONE,
    GTK_BUTTONS_OK,
    GTK_BUTTONS_CLOSE,
    GTK_BUTTONS_CANCEL,
    GTK_BUTTONS_YES_NO,
    GTK_BUTTONS_OK_CANCEL
    };

    alias _GtkMessageDialog GtkMessageDialog;

    alias _GtkMessageDialogClass GtkMessageDialogClass;


    struct _GtkMessageDialog {


    GtkDialog parent_instance;

    GtkWidget *image;
    GtkWidget *label;
    }

    struct _GtkMessageDialogClass {
    GtkDialogClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_message_dialog_get_type ();

    GtkWidget* gtk_message_dialog_new (GtkWindow *parent,
                        GtkDialogFlags flags,
                        GtkMessageType type,
                        GtkButtonsType buttons,
                        gchar *message_format,
                        ...) ;

    GtkWidget* gtk_message_dialog_new_with_markup (GtkWindow *parent,
                            GtkDialogFlags flags,
                            GtkMessageType type,
                            GtkButtonsType buttons,
                            gchar *message_format,
                            ...) ;


    void gtk_message_dialog_set_markup (GtkMessageDialog *message_dialog,
                        gchar *str);

    enum GtkNotebookTab {
    GTK_NOTEBOOK_TAB_FIRST,
    GTK_NOTEBOOK_TAB_LAST
    };


    alias _GtkNotebook GtkNotebook;

    alias _GtkNotebookClass GtkNotebookClass;

    alias _GtkNotebookPage GtkNotebookPage;
    alias void _GtkNotebookPage;


    struct _GtkNotebook {
    GtkContainer container;

    GtkNotebookPage *cur_page;
    GList *children;
    GList *first_tab;
    GList *focus_tab;

    GtkWidget *menu;
    GdkWindow *event_window;

    guint32 timer;

    guint16 tab_hborder;
    guint16 tab_vborder;

    guint show_tabs;
    guint homogeneous;
    guint show_border;
    guint tab_pos;
    guint scrollable;
    guint in_child;
    guint click_child;
    guint button;
    guint need_timer;
    guint child_has_focus;
    guint have_visible_child;
    guint focus_out;

    guint has_before_previous;
    guint has_before_next;
    guint has_after_previous;
    guint has_after_next;
    }

    struct _GtkNotebookClass {
    GtkContainerClass parent_class;

    void (* switch_page) (GtkNotebook *notebook,
                GtkNotebookPage *page,
                guint page_num);


    gboolean (* select_page) (GtkNotebook *notebook,
                    gboolean move_focus);
    gboolean (* focus_tab) (GtkNotebook *notebook,
                    GtkNotebookTab type);
    void (* change_current_page) (GtkNotebook *notebook,
                    gint offset);
    void (* move_focus_out) (GtkNotebook *notebook,
                    GtkDirectionType direction);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }





    GType gtk_notebook_get_type () ;
    GtkWidget * gtk_notebook_new ();
    gint gtk_notebook_append_page (GtkNotebook *notebook,
                    GtkWidget *child,
                    GtkWidget *tab_label);
    gint gtk_notebook_append_page_menu (GtkNotebook *notebook,
                    GtkWidget *child,
                    GtkWidget *tab_label,
                    GtkWidget *menu_label);
    gint gtk_notebook_prepend_page (GtkNotebook *notebook,
                    GtkWidget *child,
                    GtkWidget *tab_label);
    gint gtk_notebook_prepend_page_menu (GtkNotebook *notebook,
                    GtkWidget *child,
                    GtkWidget *tab_label,
                    GtkWidget *menu_label);
    gint gtk_notebook_insert_page (GtkNotebook *notebook,
                    GtkWidget *child,
                    GtkWidget *tab_label,
                    gint position);
    gint gtk_notebook_insert_page_menu (GtkNotebook *notebook,
                    GtkWidget *child,
                    GtkWidget *tab_label,
                    GtkWidget *menu_label,
                    gint position);
    void gtk_notebook_remove_page (GtkNotebook *notebook,
                    gint page_num);





    gint gtk_notebook_get_current_page (GtkNotebook *notebook);
    GtkWidget* gtk_notebook_get_nth_page (GtkNotebook *notebook,
                        gint page_num);
    gint gtk_notebook_get_n_pages (GtkNotebook *notebook);
    gint gtk_notebook_page_num (GtkNotebook *notebook,
                        GtkWidget *child);
    void gtk_notebook_set_current_page (GtkNotebook *notebook,
                        gint page_num);
    void gtk_notebook_next_page (GtkNotebook *notebook);
    void gtk_notebook_prev_page (GtkNotebook *notebook);





    void gtk_notebook_set_show_border (GtkNotebook *notebook,
                        gboolean show_border);
    gboolean gtk_notebook_get_show_border (GtkNotebook *notebook);
    void gtk_notebook_set_show_tabs (GtkNotebook *notebook,
                        gboolean show_tabs);
    gboolean gtk_notebook_get_show_tabs (GtkNotebook *notebook);
    void gtk_notebook_set_tab_pos (GtkNotebook *notebook,
                        GtkPositionType pos);
    GtkPositionType gtk_notebook_get_tab_pos (GtkNotebook *notebook);


    void gtk_notebook_set_homogeneous_tabs (GtkNotebook *notebook,
                        gboolean homogeneous);
    void gtk_notebook_set_tab_border (GtkNotebook *notebook,
                        guint border_width);
    void gtk_notebook_set_tab_hborder (GtkNotebook *notebook,
                        guint tab_hborder);
    void gtk_notebook_set_tab_vborder (GtkNotebook *notebook,
                        guint tab_vborder);


    void gtk_notebook_set_scrollable (GtkNotebook *notebook,
                        gboolean scrollable);
    gboolean gtk_notebook_get_scrollable (GtkNotebook *notebook);





    void gtk_notebook_popup_enable (GtkNotebook *notebook);
    void gtk_notebook_popup_disable (GtkNotebook *notebook);





    GtkWidget * gtk_notebook_get_tab_label (GtkNotebook *notebook,
                        GtkWidget *child);
    void gtk_notebook_set_tab_label (GtkNotebook *notebook,
                        GtkWidget *child,
                        GtkWidget *tab_label);
    void gtk_notebook_set_tab_label_text (GtkNotebook *notebook,
                        GtkWidget *child,
                        gchar *tab_text);
    gchar *gtk_notebook_get_tab_label_text (GtkNotebook *notebook,
                            GtkWidget *child);
    GtkWidget * gtk_notebook_get_menu_label (GtkNotebook *notebook,
                        GtkWidget *child);
    void gtk_notebook_set_menu_label (GtkNotebook *notebook,
                        GtkWidget *child,
                        GtkWidget *menu_label);
    void gtk_notebook_set_menu_label_text (GtkNotebook *notebook,
                        GtkWidget *child,
                        gchar *menu_text);
    gchar *gtk_notebook_get_menu_label_text (GtkNotebook *notebook,
                                GtkWidget *child);
    void gtk_notebook_query_tab_label_packing (GtkNotebook *notebook,
                        GtkWidget *child,
                        gboolean *expand,
                        gboolean *fill,
                        GtkPackType *pack_type);
    void gtk_notebook_set_tab_label_packing (GtkNotebook *notebook,
                        GtkWidget *child,
                        gboolean expand,
                        gboolean fill,
                        GtkPackType pack_type);
    void gtk_notebook_reorder_child (GtkNotebook *notebook,
                        GtkWidget *child,
                        gint position);

    alias _GtkOldEditable GtkOldEditable;

    alias _GtkOldEditableClass GtkOldEditableClass;


    alias void (*GtkTextFunction) (GtkOldEditable *editable, guint32 time_);

    struct _GtkOldEditable {
    GtkWidget widget;


    guint current_pos;

    guint selection_start_pos;
    guint selection_end_pos;
    guint has_selection;


    guint editable;
    guint visible;

    gchar *clipboard_text;
    }

    struct _GtkOldEditableClass {
    GtkWidgetClass parent_class;


    void (* activate) (GtkOldEditable *editable);
    void (* set_editable) (GtkOldEditable *editable,
                gboolean is_editable);
    void (* move_cursor) (GtkOldEditable *editable,
                gint x,
                gint y);
    void (* move_word) (GtkOldEditable *editable,
                gint n);
    void (* move_page) (GtkOldEditable *editable,
                gint x,
                gint y);
    void (* move_to_row) (GtkOldEditable *editable,
                gint row);
    void (* move_to_column) (GtkOldEditable *editable,
                gint row);
    void (* kill_char) (GtkOldEditable *editable,
                gint direction);
    void (* kill_word) (GtkOldEditable *editable,
                gint direction);
    void (* kill_line) (GtkOldEditable *editable,
                gint direction);
    void (* cut_clipboard) (GtkOldEditable *editable);
    void (* copy_clipboard) (GtkOldEditable *editable);
    void (* paste_clipboard) (GtkOldEditable *editable);






    void (* update_text) (GtkOldEditable *editable,
                gint start_pos,
                gint end_pos);
    gchar* (* get_chars) (GtkOldEditable *editable,
                gint start_pos,
                gint end_pos);
    void (* set_selection)(GtkOldEditable *editable,
                gint start_pos,
                gint end_pos);
    void (* set_position) (GtkOldEditable *editable,
                gint position);
    }

    GtkType gtk_old_editable_get_type () ;
    void gtk_old_editable_claim_selection (GtkOldEditable *old_editable,
                        gboolean claim,
                        guint32 time_);
    void gtk_old_editable_changed (GtkOldEditable *old_editable);
    alias _GtkOptionMenu GtkOptionMenu;

    alias _GtkOptionMenuClass GtkOptionMenuClass;


    struct _GtkOptionMenu {
    GtkButton button;

    GtkWidget *menu;
    GtkWidget *menu_item;

    guint16 width;
    guint16 height;
    }

    struct _GtkOptionMenuClass {
    GtkButtonClass parent_class;

    void (*changed) (GtkOptionMenu *option_menu);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_option_menu_get_type () ;
    GtkWidget* gtk_option_menu_new ();
    GtkWidget* gtk_option_menu_get_menu (GtkOptionMenu *option_menu);
    void gtk_option_menu_set_menu (GtkOptionMenu *option_menu,
                        GtkWidget *menu);
    void gtk_option_menu_remove_menu (GtkOptionMenu *option_menu);
    gint gtk_option_menu_get_history (GtkOptionMenu *option_menu);
    void gtk_option_menu_set_history (GtkOptionMenu *option_menu,
                        guint index_);

    alias _GtkPixmap GtkPixmap;

    alias _GtkPixmapClass GtkPixmapClass;


    struct _GtkPixmap {
    GtkMisc misc;

    GdkPixmap *pixmap;
    GdkBitmap *mask;

    GdkPixmap *pixmap_insensitive;
    guint build_insensitive;
    }

    struct _GtkPixmapClass {
    GtkMiscClass parent_class;
    }


    GtkType gtk_pixmap_get_type () ;
    GtkWidget* gtk_pixmap_new (GdkPixmap *pixmap,
                    GdkBitmap *mask);
    void gtk_pixmap_set (GtkPixmap *pixmap,
                    GdkPixmap *val,
                    GdkBitmap *mask);
    void gtk_pixmap_get (GtkPixmap *pixmap,
                    GdkPixmap **val,
                    GdkBitmap **mask);

    void gtk_pixmap_set_build_insensitive (GtkPixmap *pixmap,
                        gboolean build);
    alias _GtkSocket GtkSocket;

    alias _GtkSocketClass GtkSocketClass;


    struct _GtkSocket {
    GtkContainer container;

    guint16 request_width;
    guint16 request_height;
    guint16 current_width;
    guint16 current_height;

    GdkWindow *plug_window;
    GtkWidget *plug_widget;

    gshort xembed_version;
    guint same_app;
    guint focus_in;
    guint have_size;
    guint need_map;
    guint is_mapped;
    guint active;

    GtkAccelGroup *accel_group;
    GtkWidget *toplevel;
    }

    struct _GtkSocketClass {
    GtkContainerClass parent_class;

    void (*plug_added) (GtkSocket *socket_);
    gboolean (*plug_removed) (GtkSocket *socket_);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_socket_get_type () ;
    GtkWidget* gtk_socket_new ();

    void gtk_socket_add_id (GtkSocket *socket_,
                    GdkNativeWindow window_id);
    GdkNativeWindow gtk_socket_get_id (GtkSocket *socket_);


    void gtk_socket_steal (GtkSocket *socket_,
                    GdkNativeWindow wid);
    alias _GtkPlug GtkPlug;

    alias _GtkPlugClass GtkPlugClass;



    struct _GtkPlug {
    GtkWindow window;

    GdkWindow *socket_window;
    GtkWidget *modality_window;
    GtkWindowGroup *modality_group;
    GHashTable *grabbed_keys;

    guint same_app;
    }

    struct _GtkPlugClass {
    GtkWindowClass parent_class;

    void (*embedded) (GtkPlug *plug);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_plug_get_type () ;


    void gtk_plug_ruct (GtkPlug *plug,
                GdkNativeWindow socket_id);
    GtkWidget* gtk_plug_new (GdkNativeWindow socket_id);


    void gtk_plug_ruct_for_display (GtkPlug *plug,
                        GdkDisplay *display,
                        GdkNativeWindow socket_id);
    GtkWidget* gtk_plug_new_for_display (GdkDisplay *display,
                        GdkNativeWindow socket_id);

    GdkNativeWindow gtk_plug_get_id (GtkPlug *plug);

    void _gtk_plug_add_to_socket (GtkPlug *plug,
                    GtkSocket *socket_);
    void _gtk_plug_remove_from_socket (GtkPlug *plug,
                    GtkSocket *socket_);
    alias _GtkPreview GtkPreview;

    alias _GtkPreviewInfo GtkPreviewInfo;

    alias _GtkDitherInfo GtkDitherInfo;

    alias _GtkPreviewClass GtkPreviewClass;


    struct _GtkPreview {
    GtkWidget widget;

    guchar *buffer;
    guint16 buffer_width;
    guint16 buffer_height;

    guint16 bpp;
    guint16 rowstride;

    GdkRgbDither dither;

    guint type;
    guint expand;
    }

    struct _GtkPreviewInfo {
    guchar *lookup;

    gdouble gamma;
    }

    union _GtkDitherInfo {
    gushort s[2];
    guchar c[4];
    }

    struct _GtkPreviewClass {
    GtkWidgetClass parent_class;

    GtkPreviewInfo info;

    }


    GtkType gtk_preview_get_type () ;
    void gtk_preview_uninit ();
    GtkWidget* gtk_preview_new (GtkPreviewType type);
    void gtk_preview_size (GtkPreview *preview,
                            gint width,
                            gint height);
    void gtk_preview_put (GtkPreview *preview,
                            GdkWindow *window,
                            GdkGC *gc,
                            gint srcx,
                            gint srcy,
                            gint destx,
                            gint desty,
                            gint width,
                            gint height);
    void gtk_preview_draw_row (GtkPreview *preview,
                            guchar *data,
                            gint x,
                            gint y,
                            gint w);
    void gtk_preview_set_expand (GtkPreview *preview,
                            gboolean expand);

    void gtk_preview_set_gamma (double gamma_);
    void gtk_preview_set_color_cube (guint nred_shades,
                            guint ngreen_shades,
                            guint nblue_shades,
                            guint ngray_shades);
    void gtk_preview_set_install_cmap (gint install_cmap);
    void gtk_preview_set_reserved (gint nreserved);
    void gtk_preview_set_dither (GtkPreview *preview,
                            GdkRgbDither dither);

    GdkVisual* gtk_preview_get_visual ();
    GdkColormap* gtk_preview_get_cmap ();

    GtkPreviewInfo* gtk_preview_get_info ();






    void gtk_preview_reset ();
    alias _GtkProgress GtkProgress;

    alias _GtkProgressClass GtkProgressClass;



    struct _GtkProgress {
    GtkWidget widget;

    GtkAdjustment *adjustment;
    GdkPixmap *offscreen_pixmap;
    gchar *format;
    gfloat x_align;
    gfloat y_align;

    guint show_text;
    guint activity_mode;
    guint use_text_format;
    }

    struct _GtkProgressClass {
    GtkWidgetClass parent_class;

    void (* paint) (GtkProgress *progress);
    void (* update) (GtkProgress *progress);
    void (* act_mode_enter) (GtkProgress *progress);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }







    GType gtk_progress_get_type () ;
    void gtk_progress_set_show_text (GtkProgress *progress,
                        gboolean show_text);
    void gtk_progress_set_text_alignment (GtkProgress *progress,
                        gfloat x_align,
                        gfloat y_align);
    void gtk_progress_set_format_string (GtkProgress *progress,
                        gchar *format);
    void gtk_progress_set_adjustment (GtkProgress *progress,
                        GtkAdjustment *adjustment);
    void gtk_progress_configure (GtkProgress *progress,
                        gdouble value,
                        gdouble min,
                        gdouble max);
    void gtk_progress_set_percentage (GtkProgress *progress,
                        gdouble percentage);
    void gtk_progress_set_value (GtkProgress *progress,
                        gdouble value);
    gdouble gtk_progress_get_value (GtkProgress *progress);
    void gtk_progress_set_activity_mode (GtkProgress *progress,
                        gboolean activity_mode);
    gchar* gtk_progress_get_current_text (GtkProgress *progress);
    gchar* gtk_progress_get_text_from_value (GtkProgress *progress,
                        gdouble value);
    gdouble gtk_progress_get_current_percentage (GtkProgress *progress);
    gdouble gtk_progress_get_percentage_from_value (GtkProgress *progress,
                            gdouble value);
    alias _GtkProgressBar GtkProgressBar;

    alias _GtkProgressBarClass GtkProgressBarClass;


    enum GtkProgressBarStyle {
    GTK_PROGRESS_CONTINUOUS,
    GTK_PROGRESS_DISCRETE
    };


    enum GtkProgressBarOrientation {
    GTK_PROGRESS_LEFT_TO_RIGHT,
    GTK_PROGRESS_RIGHT_TO_LEFT,
    GTK_PROGRESS_BOTTOM_TO_TOP,
    GTK_PROGRESS_TOP_TO_BOTTOM
    };


    struct _GtkProgressBar {
    GtkProgress progress;

    GtkProgressBarStyle bar_style;
    GtkProgressBarOrientation orientation;

    guint blocks;
    gint in_block;

    gint activity_pos;
    guint activity_step;
    guint activity_blocks;

    gdouble pulse_fraction;

    guint activity_dir;
    }

    struct _GtkProgressBarClass {
    GtkProgressClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_progress_bar_get_type () ;
    GtkWidget* gtk_progress_bar_new ();
    void gtk_progress_bar_pulse (GtkProgressBar *pbar);
    void gtk_progress_bar_set_text (GtkProgressBar *pbar,
                            gchar *text);
    void gtk_progress_bar_set_fraction (GtkProgressBar *pbar,
                            gdouble fraction);

    void gtk_progress_bar_set_pulse_step (GtkProgressBar *pbar,
                            gdouble fraction);
    void gtk_progress_bar_set_orientation (GtkProgressBar *pbar,
                            GtkProgressBarOrientation orientation);

    gchar* gtk_progress_bar_get_text (GtkProgressBar *pbar);
    gdouble gtk_progress_bar_get_fraction (GtkProgressBar *pbar);
    gdouble gtk_progress_bar_get_pulse_step (GtkProgressBar *pbar);

    GtkProgressBarOrientation gtk_progress_bar_get_orientation (GtkProgressBar *pbar);





    GtkWidget* gtk_progress_bar_new_with_adjustment (GtkAdjustment *adjustment);
    void gtk_progress_bar_set_bar_style (GtkProgressBar *pbar,
                            GtkProgressBarStyle style);
    void gtk_progress_bar_set_discrete_blocks (GtkProgressBar *pbar,
                            guint blocks);




    void gtk_progress_bar_set_activity_step (GtkProgressBar *pbar,
                            guint step);
    void gtk_progress_bar_set_activity_blocks (GtkProgressBar *pbar,
                            guint blocks);
    void gtk_progress_bar_update (GtkProgressBar *pbar,
                            gdouble percentage);

    alias _GtkToggleAction GtkToggleAction;

    alias _GtkToggleActionPrivate GtkToggleActionPrivate;
    alias void _GtkToggleActionPrivate;

    alias _GtkToggleActionClass GtkToggleActionClass;


    struct _GtkToggleAction {
    GtkAction parent;



    GtkToggleActionPrivate *private_data;
    }

    struct _GtkToggleActionClass {
    GtkActionClass parent_class;

    void (* toggled) (GtkToggleAction *action);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_toggle_action_get_type ();
    GtkToggleAction *gtk_toggle_action_new ( gchar *name,
                            gchar *label,
                            gchar *tooltip,
                            gchar *stock_id);
    void gtk_toggle_action_toggled (GtkToggleAction *action);
    void gtk_toggle_action_set_active (GtkToggleAction *action,
                            gboolean is_active);
    gboolean gtk_toggle_action_get_active (GtkToggleAction *action);
    void gtk_toggle_action_set_draw_as_radio (GtkToggleAction *action,
                            gboolean draw_as_radio);
    gboolean gtk_toggle_action_get_draw_as_radio (GtkToggleAction *action);





    alias _GtkRadioAction GtkRadioAction;

    alias _GtkRadioActionPrivate GtkRadioActionPrivate;
    alias void _GtkRadioActionPrivate;

    alias _GtkRadioActionClass GtkRadioActionClass;


    struct _GtkRadioAction {
    GtkToggleAction parent;



    GtkRadioActionPrivate *private_data;
    }

    struct _GtkRadioActionClass {
    GtkToggleActionClass parent_class;

    void (* changed) (GtkRadioAction *action, GtkRadioAction *current);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_radio_action_get_type ();
    GtkRadioAction *gtk_radio_action_new ( gchar *name,
                            gchar *label,
                            gchar *tooltip,
                            gchar *stock_id,
                            gint value);
    GSList *gtk_radio_action_get_group (GtkRadioAction *action);
    void gtk_radio_action_set_group (GtkRadioAction *action,
                            GSList *group);
    gint gtk_radio_action_get_current_value (GtkRadioAction *action);



    alias _GtkRadioButton GtkRadioButton;

    alias _GtkRadioButtonClass GtkRadioButtonClass;


    struct _GtkRadioButton {
    GtkCheckButton check_button;

    GSList *group;
    }

    struct _GtkRadioButtonClass {
    GtkCheckButtonClass parent_class;


    void (*group_changed) (GtkRadioButton *radio_button);


    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_radio_button_get_type () ;

    GtkWidget* gtk_radio_button_new (GSList *group);
    GtkWidget* gtk_radio_button_new_from_widget (GtkRadioButton *group);
    GtkWidget* gtk_radio_button_new_with_label (GSList *group,
                                gchar *label);
    GtkWidget* gtk_radio_button_new_with_label_from_widget (GtkRadioButton *group,
                                gchar *label);
    GtkWidget* gtk_radio_button_new_with_mnemonic (GSList *group,
                                gchar *label);
    GtkWidget* gtk_radio_button_new_with_mnemonic_from_widget (GtkRadioButton *group,
                                gchar *label);
    GSList* gtk_radio_button_get_group (GtkRadioButton *radio_button);
    void gtk_radio_button_set_group (GtkRadioButton *radio_button,
                                GSList *group);

    alias _GtkRadioMenuItem GtkRadioMenuItem;

    alias _GtkRadioMenuItemClass GtkRadioMenuItemClass;


    struct _GtkRadioMenuItem {
    GtkCheckMenuItem check_menu_item;

    GSList *group;
    }

    struct _GtkRadioMenuItemClass {
    GtkCheckMenuItemClass parent_class;


    void (*group_changed) (GtkRadioMenuItem *radio_menu_item);


    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_radio_menu_item_get_type () ;

    GtkWidget* gtk_radio_menu_item_new (GSList *group);
    GtkWidget* gtk_radio_menu_item_new_with_label (GSList *group,
                                gchar *label);
    GtkWidget* gtk_radio_menu_item_new_with_mnemonic (GSList *group,
                                gchar *label);
    GtkWidget* gtk_radio_menu_item_new_from_widget (GtkRadioMenuItem *group);
    GtkWidget *gtk_radio_menu_item_new_with_mnemonic_from_widget (GtkRadioMenuItem *group,
                                gchar *label);
    GtkWidget *gtk_radio_menu_item_new_with_label_from_widget (GtkRadioMenuItem *group,
                                gchar *label);
    GSList* gtk_radio_menu_item_get_group (GtkRadioMenuItem *radio_menu_item);
    void gtk_radio_menu_item_set_group (GtkRadioMenuItem *radio_menu_item,
                                GSList *group);






    alias _GtkTooltips GtkTooltips;

    alias _GtkTooltipsClass GtkTooltipsClass;

    alias _GtkTooltipsData GtkTooltipsData;


    struct _GtkTooltipsData {
    GtkTooltips *tooltips;
    GtkWidget *widget;
    gchar *tip_text;
    gchar *tip_private;
    }

    struct _GtkTooltips {
    GtkObject parent_instance;

    GtkWidget *tip_window;
    GtkWidget *tip_label;
    GtkTooltipsData *active_tips_data;
    GList *tips_data_list;

    guint delay;
    guint enabled;
    guint have_grab;
    guint use_sticky_delay;
    gint timer_tag;
    GTimeVal last_popdown;
    }

    struct _GtkTooltipsClass {
    GtkObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_tooltips_get_type () ;
    GtkTooltips* gtk_tooltips_new ();

    void gtk_tooltips_enable (GtkTooltips *tooltips);
    void gtk_tooltips_disable (GtkTooltips *tooltips);

    void gtk_tooltips_set_delay (GtkTooltips *tooltips,
                        guint delay);

    void gtk_tooltips_set_tip (GtkTooltips *tooltips,
                        GtkWidget *widget,
                        gchar *tip_text,
                        gchar *tip_private);
    GtkTooltipsData* gtk_tooltips_data_get (GtkWidget *widget);
    void gtk_tooltips_force_window (GtkTooltips *tooltips);


    void _gtk_tooltips_toggle_keyboard_mode (GtkWidget *widget);

    gboolean gtk_tooltips_get_info_from_tip_window (GtkWindow *tip_window,
                                GtkTooltips **tooltips,
                                GtkWidget **current_widget);



    alias _GtkToolItem GtkToolItem;

    alias _GtkToolItemClass GtkToolItemClass;

    alias _GtkToolItemPrivate GtkToolItemPrivate;
    alias void _GtkToolItemPrivate;


    struct _GtkToolItem {
    GtkBin parent;


    GtkToolItemPrivate *priv;
    }

    struct _GtkToolItemClass {
    GtkBinClass parent_class;


    gboolean (* create_menu_proxy) (GtkToolItem *tool_item);
    void (* toolbar_reconfigured) (GtkToolItem *tool_item);
    gboolean (* set_tooltip) (GtkToolItem *tool_item,
                    GtkTooltips *tooltips,
                        gchar *tip_text,
                        gchar *tip_private);


    void (* _gtk_reserved1) ();
    void (* _gtk_reserved2) ();
    void (* _gtk_reserved3) ();
    void (* _gtk_reserved4) ();
    }

    GType gtk_tool_item_get_type ();
    GtkToolItem *gtk_tool_item_new ();

    void gtk_tool_item_set_homogeneous (GtkToolItem *tool_item,
                                gboolean homogeneous);
    gboolean gtk_tool_item_get_homogeneous (GtkToolItem *tool_item);

    void gtk_tool_item_set_expand (GtkToolItem *tool_item,
                                gboolean expand);
    gboolean gtk_tool_item_get_expand (GtkToolItem *tool_item);

    void gtk_tool_item_set_tooltip (GtkToolItem *tool_item,
                                GtkTooltips *tooltips,
                                gchar *tip_text,
                                gchar *tip_private);

    void gtk_tool_item_set_use_drag_window (GtkToolItem *toolitem,
                                gboolean use_drag_window);
    gboolean gtk_tool_item_get_use_drag_window (GtkToolItem *toolitem);

    void gtk_tool_item_set_visible_horizontal (GtkToolItem *toolitem,
                                gboolean visible_horizontal);
    gboolean gtk_tool_item_get_visible_horizontal (GtkToolItem *toolitem);

    void gtk_tool_item_set_visible_vertical (GtkToolItem *toolitem,
                                gboolean visible_vertical);
    gboolean gtk_tool_item_get_visible_vertical (GtkToolItem *toolitem);

    gboolean gtk_tool_item_get_is_important (GtkToolItem *tool_item);
    void gtk_tool_item_set_is_important (GtkToolItem *tool_item,
                                gboolean is_important);

    GtkIconSize gtk_tool_item_get_icon_size (GtkToolItem *tool_item);
    GtkOrientation gtk_tool_item_get_orientation (GtkToolItem *tool_item);
    GtkToolbarStyle gtk_tool_item_get_toolbar_style (GtkToolItem *tool_item);
    GtkReliefStyle gtk_tool_item_get_relief_style (GtkToolItem *tool_item);

    GtkWidget * gtk_tool_item_retrieve_proxy_menu_item (GtkToolItem *tool_item);
    GtkWidget * gtk_tool_item_get_proxy_menu_item (GtkToolItem *tool_item,
                                gchar *menu_item_id);
    void gtk_tool_item_set_proxy_menu_item (GtkToolItem *tool_item,
                                gchar *menu_item_id,
                                GtkWidget *menu_item);


    void _gtk_tool_item_toolbar_reconfigured (GtkToolItem *tool_item);




    alias _GtkToolButton GtkToolButton;

    alias _GtkToolButtonClass GtkToolButtonClass;

    alias _GtkToolButtonPrivate GtkToolButtonPrivate;
    alias void _GtkToolButtonPrivate;


    struct _GtkToolButton {
    GtkToolItem parent;


    GtkToolButtonPrivate *priv;
    }

    struct _GtkToolButtonClass {
    GtkToolItemClass parent_class;

    GType button_type;


    void (* clicked) (GtkToolButton *tool_item);


    void (* _gtk_reserved1) ();
    void (* _gtk_reserved2) ();
    void (* _gtk_reserved3) ();
    void (* _gtk_reserved4) ();
    }

    GType gtk_tool_button_get_type ();
    GtkToolItem *gtk_tool_button_new (GtkWidget *icon_widget,
                        gchar *label);
    GtkToolItem *gtk_tool_button_new_from_stock ( gchar *stock_id);

    void gtk_tool_button_set_label (GtkToolButton *button,
                                gchar *label);
    gchar *gtk_tool_button_get_label (GtkToolButton *button);
    void gtk_tool_button_set_use_underline (GtkToolButton *button,
                                gboolean use_underline);
    gboolean gtk_tool_button_get_use_underline (GtkToolButton *button);
    void gtk_tool_button_set_stock_id (GtkToolButton *button,
                                gchar *stock_id);
    gchar *gtk_tool_button_get_stock_id (GtkToolButton *button);
    void gtk_tool_button_set_icon_widget (GtkToolButton *button,
                                GtkWidget *icon_widget);
    GtkWidget * gtk_tool_button_get_icon_widget (GtkToolButton *button);
    void gtk_tool_button_set_label_widget (GtkToolButton *button,
                                GtkWidget *label_widget);
    GtkWidget * gtk_tool_button_get_label_widget (GtkToolButton *button);



    GtkWidget *_gtk_tool_button_get_button (GtkToolButton *button);




    alias _GtkToggleToolButton GtkToggleToolButton;

    alias _GtkToggleToolButtonClass GtkToggleToolButtonClass;

    alias _GtkToggleToolButtonPrivate GtkToggleToolButtonPrivate;
    alias void _GtkToggleToolButtonPrivate;


    struct _GtkToggleToolButton {
    GtkToolButton parent;


    GtkToggleToolButtonPrivate *priv;
    }

    struct _GtkToggleToolButtonClass {
    GtkToolButtonClass parent_class;


    void (* toggled) (GtkToggleToolButton *button);


    void (* _gtk_reserved1) ();
    void (* _gtk_reserved2) ();
    void (* _gtk_reserved3) ();
    void (* _gtk_reserved4) ();
    }

    GType gtk_toggle_tool_button_get_type () ;
    GtkToolItem *gtk_toggle_tool_button_new ();
    GtkToolItem *gtk_toggle_tool_button_new_from_stock ( gchar *stock_id);

    void gtk_toggle_tool_button_set_active (GtkToggleToolButton *button,
                            gboolean is_active);
    gboolean gtk_toggle_tool_button_get_active (GtkToggleToolButton *button);




    alias _GtkRadioToolButton GtkRadioToolButton;

    alias _GtkRadioToolButtonClass GtkRadioToolButtonClass;


    struct _GtkRadioToolButton {
    GtkToggleToolButton parent;
    }

    struct _GtkRadioToolButtonClass {
    GtkToggleToolButtonClass parent_class;


    void (* _gtk_reserved1) ();
    void (* _gtk_reserved2) ();
    void (* _gtk_reserved3) ();
    void (* _gtk_reserved4) ();
    }

    GType gtk_radio_tool_button_get_type () ;

    GtkToolItem *gtk_radio_tool_button_new (GSList *group);
    GtkToolItem *gtk_radio_tool_button_new_from_stock (GSList *group,
                                    gchar *stock_id);
    GtkToolItem *gtk_radio_tool_button_new_from_widget (GtkRadioToolButton *group);
    GtkToolItem *gtk_radio_tool_button_new_with_stock_from_widget (GtkRadioToolButton *group,
                                    gchar *stock_id);
    GSList * gtk_radio_tool_button_get_group (GtkRadioToolButton *button);
    void gtk_radio_tool_button_set_group (GtkRadioToolButton *button,
                                GSList *group);







    alias _GtkViewport GtkViewport;

    alias _GtkViewportClass GtkViewportClass;


    struct _GtkViewport {
    GtkBin bin;

    GtkShadowType shadow_type;
    GdkWindow *view_window;
    GdkWindow *bin_window;
    GtkAdjustment *hadjustment;
    GtkAdjustment *vadjustment;
    }

    struct _GtkViewportClass {
    GtkBinClass parent_class;

    void (*set_scroll_adjustments) (GtkViewport *viewport,
                        GtkAdjustment *hadjustment,
                        GtkAdjustment *vadjustment);
    }


    GType gtk_viewport_get_type () ;
    GtkWidget* gtk_viewport_new (GtkAdjustment *hadjustment,
                        GtkAdjustment *vadjustment);
    GtkAdjustment* gtk_viewport_get_hadjustment (GtkViewport *viewport);
    GtkAdjustment* gtk_viewport_get_vadjustment (GtkViewport *viewport);
    void gtk_viewport_set_hadjustment (GtkViewport *viewport,
                        GtkAdjustment *adjustment);
    void gtk_viewport_set_vadjustment (GtkViewport *viewport,
                        GtkAdjustment *adjustment);
    void gtk_viewport_set_shadow_type (GtkViewport *viewport,
                        GtkShadowType type);
    GtkShadowType gtk_viewport_get_shadow_type (GtkViewport *viewport);
    alias _GtkScrolledWindow GtkScrolledWindow;

    alias _GtkScrolledWindowClass GtkScrolledWindowClass;


    struct _GtkScrolledWindow {
    GtkBin container;

    GtkWidget *hscrollbar;
    GtkWidget *vscrollbar;

    guint hscrollbar_policy;
    guint vscrollbar_policy;
    guint hscrollbar_visible;
    guint vscrollbar_visible;
    guint window_placement;
    guint focus_out;

    guint16 shadow_type;
    }

    struct _GtkScrolledWindowClass {
    GtkBinClass parent_class;

    gint scrollbar_spacing;
    void (*scroll_child) (GtkScrolledWindow *scrolled_window,
                GtkScrollType scroll,
                gboolean horizontal);

    void (* move_focus_out) (GtkScrolledWindow *scrolled_window,
                GtkDirectionType direction);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_scrolled_window_get_type () ;
    GtkWidget* gtk_scrolled_window_new (GtkAdjustment *hadjustment,
                            GtkAdjustment *vadjustment);
    void gtk_scrolled_window_set_hadjustment (GtkScrolledWindow *scrolled_window,
                            GtkAdjustment *hadjustment);
    void gtk_scrolled_window_set_vadjustment (GtkScrolledWindow *scrolled_window,
                            GtkAdjustment *hadjustment);
    GtkAdjustment* gtk_scrolled_window_get_hadjustment (GtkScrolledWindow *scrolled_window);
    GtkAdjustment* gtk_scrolled_window_get_vadjustment (GtkScrolledWindow *scrolled_window);
    void gtk_scrolled_window_set_policy (GtkScrolledWindow *scrolled_window,
                            GtkPolicyType hscrollbar_policy,
                            GtkPolicyType vscrollbar_policy);
    void gtk_scrolled_window_get_policy (GtkScrolledWindow *scrolled_window,
                            GtkPolicyType *hscrollbar_policy,
                            GtkPolicyType *vscrollbar_policy);
    void gtk_scrolled_window_set_placement (GtkScrolledWindow *scrolled_window,
                            GtkCornerType window_placement);
    GtkCornerType gtk_scrolled_window_get_placement (GtkScrolledWindow *scrolled_window);
    void gtk_scrolled_window_set_shadow_type (GtkScrolledWindow *scrolled_window,
                            GtkShadowType type);
    GtkShadowType gtk_scrolled_window_get_shadow_type (GtkScrolledWindow *scrolled_window);
    void gtk_scrolled_window_add_with_viewport (GtkScrolledWindow *scrolled_window,
                            GtkWidget *child);

    gint _gtk_scrolled_window_get_scrollbar_spacing (GtkScrolledWindow *scrolled_window);


    alias _GtkSeparatorMenuItem GtkSeparatorMenuItem;

    alias _GtkSeparatorMenuItemClass GtkSeparatorMenuItemClass;


    struct _GtkSeparatorMenuItem {
    GtkMenuItem menu_item;
    }

    struct _GtkSeparatorMenuItemClass {
    GtkMenuItemClass parent_class;
    }


    GType gtk_separator_menu_item_get_type () ;
    GtkWidget* gtk_separator_menu_item_new ();

    alias _GtkSeparatorToolItem GtkSeparatorToolItem;

    alias _GtkSeparatorToolItemClass GtkSeparatorToolItemClass;

    alias _GtkSeparatorToolItemPrivate GtkSeparatorToolItemPrivate;
    alias void _GtkSeparatorToolItemPrivate;


    struct _GtkSeparatorToolItem {
    GtkToolItem parent;


    GtkSeparatorToolItemPrivate *priv;
    }

    struct _GtkSeparatorToolItemClass {
    GtkToolItemClass parent_class;


    void (* _gtk_reserved1) ();
    void (* _gtk_reserved2) ();
    void (* _gtk_reserved3) ();
    void (* _gtk_reserved4) ();
    }

    GType gtk_separator_tool_item_get_type () ;
    GtkToolItem *gtk_separator_tool_item_new ();

    gboolean gtk_separator_tool_item_get_draw (GtkSeparatorToolItem *item);
    void gtk_separator_tool_item_set_draw (GtkSeparatorToolItem *item,
                        gboolean draw);




    alias _GtkSizeGroup GtkSizeGroup;

    alias _GtkSizeGroupClass GtkSizeGroupClass;


    struct _GtkSizeGroup {
    GObject parent_instance;

    GSList *widgets;

    guint8 mode;

    guint have_width;
    guint have_height;

    GtkRequisition requisition;
    }

    struct _GtkSizeGroupClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }
    enum GtkSizeGroupMode {
    GTK_SIZE_GROUP_NONE,
    GTK_SIZE_GROUP_HORIZONTAL,
    GTK_SIZE_GROUP_VERTICAL,
    GTK_SIZE_GROUP_BOTH
    };


    GType gtk_size_group_get_type () ;

    GtkSizeGroup * gtk_size_group_new (GtkSizeGroupMode mode);
    void gtk_size_group_set_mode (GtkSizeGroup *size_group,
                        GtkSizeGroupMode mode);
    GtkSizeGroupMode gtk_size_group_get_mode (GtkSizeGroup *size_group);
    void gtk_size_group_add_widget (GtkSizeGroup *size_group,
                        GtkWidget *widget);
    void gtk_size_group_remove_widget (GtkSizeGroup *size_group,
                        GtkWidget *widget);


    void _gtk_size_group_get_child_requisition (GtkWidget *widget,
                        GtkRequisition *requisition);
    void _gtk_size_group_compute_requisition (GtkWidget *widget,
                        GtkRequisition *requisition);
    void _gtk_size_group_queue_resize (GtkWidget *widget);

    enum GtkSpinButtonUpdatePolicy {
    GTK_UPDATE_ALWAYS,
    GTK_UPDATE_IF_VALID
    };


    enum GtkSpinType {
    GTK_SPIN_STEP_FORWARD,
    GTK_SPIN_STEP_BACKWARD,
    GTK_SPIN_PAGE_FORWARD,
    GTK_SPIN_PAGE_BACKWARD,
    GTK_SPIN_HOME,
    GTK_SPIN_END,
    GTK_SPIN_USER_DEFINED
    };



    alias _GtkSpinButton GtkSpinButton;

    alias _GtkSpinButtonClass GtkSpinButtonClass;



    struct _GtkSpinButton {
    GtkEntry entry;

    GtkAdjustment *adjustment;

    GdkWindow *panel;

    guint32 timer;

    gdouble climb_rate;
    gdouble timer_step;

    GtkSpinButtonUpdatePolicy update_policy;

    guint in_child;
    guint click_child;
    guint button;
    guint need_timer;
    guint timer_calls;
    guint digits;
    guint numeric;
    guint wrap;
    guint snap_to_ticks;
    }

    struct _GtkSpinButtonClass {
    GtkEntryClass parent_class;

    gint (*input) (GtkSpinButton *spin_button,
            gdouble *new_value);
    gint (*output) (GtkSpinButton *spin_button);
    void (*value_changed) (GtkSpinButton *spin_button);


    void (*change_value) (GtkSpinButton *spin_button,
                GtkScrollType scroll);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_spin_button_get_type () ;

    void gtk_spin_button_configure (GtkSpinButton *spin_button,
                            GtkAdjustment *adjustment,
                            gdouble climb_rate,
                            guint digits);

    GtkWidget* gtk_spin_button_new (GtkAdjustment *adjustment,
                            gdouble climb_rate,
                            guint digits);

    GtkWidget* gtk_spin_button_new_with_range (gdouble min,
                            gdouble max,
                            gdouble step);

    void gtk_spin_button_set_adjustment (GtkSpinButton *spin_button,
                            GtkAdjustment *adjustment);

    GtkAdjustment* gtk_spin_button_get_adjustment (GtkSpinButton *spin_button);

    void gtk_spin_button_set_digits (GtkSpinButton *spin_button,
                            guint digits);
    guint gtk_spin_button_get_digits (GtkSpinButton *spin_button);

    void gtk_spin_button_set_increments (GtkSpinButton *spin_button,
                            gdouble step,
                            gdouble page);
    void gtk_spin_button_get_increments (GtkSpinButton *spin_button,
                            gdouble *step,
                            gdouble *page);

    void gtk_spin_button_set_range (GtkSpinButton *spin_button,
                            gdouble min,
                            gdouble max);
    void gtk_spin_button_get_range (GtkSpinButton *spin_button,
                            gdouble *min,
                            gdouble *max);

    gdouble gtk_spin_button_get_value (GtkSpinButton *spin_button);

    gint gtk_spin_button_get_value_as_int (GtkSpinButton *spin_button);

    void gtk_spin_button_set_value (GtkSpinButton *spin_button,
                            gdouble value);

    void gtk_spin_button_set_update_policy (GtkSpinButton *spin_button,
                            GtkSpinButtonUpdatePolicy policy);
    GtkSpinButtonUpdatePolicy gtk_spin_button_get_update_policy (GtkSpinButton *spin_button);

    void gtk_spin_button_set_numeric (GtkSpinButton *spin_button,
                            gboolean numeric);
    gboolean gtk_spin_button_get_numeric (GtkSpinButton *spin_button);

    void gtk_spin_button_spin (GtkSpinButton *spin_button,
                            GtkSpinType direction,
                            gdouble increment);

    void gtk_spin_button_set_wrap (GtkSpinButton *spin_button,
                            gboolean wrap);
    gboolean gtk_spin_button_get_wrap (GtkSpinButton *spin_button);

    void gtk_spin_button_set_snap_to_ticks (GtkSpinButton *spin_button,
                            gboolean snap_to_ticks);
    gboolean gtk_spin_button_get_snap_to_ticks (GtkSpinButton *spin_button);
    void gtk_spin_button_update (GtkSpinButton *spin_button);
    alias _GtkStatusbar GtkStatusbar;

    alias _GtkStatusbarClass GtkStatusbarClass;


    struct _GtkStatusbar {
    GtkHBox parent_widget;

    GtkWidget *frame;
    GtkWidget *label;

    GSList *messages;
    GSList *keys;

    guint seq_context_id;
    guint seq_message_id;

    GdkWindow *grip_window;

    guint has_resize_grip;
    }

    struct _GtkStatusbarClass {
    GtkHBoxClass parent_class;

    GMemChunk *messages_mem_chunk;

    void (*text_pushed) (GtkStatusbar *statusbar,
                guint context_id,
                gchar *text);
    void (*text_popped) (GtkStatusbar *statusbar,
                guint context_id,
                gchar *text);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_statusbar_get_type () ;
    GtkWidget* gtk_statusbar_new ();



    guint gtk_statusbar_get_context_id (GtkStatusbar *statusbar,
                        gchar *context_description);

    guint gtk_statusbar_push (GtkStatusbar *statusbar,
                        guint context_id,
                        gchar *text);
    void gtk_statusbar_pop (GtkStatusbar *statusbar,
                        guint context_id);
    void gtk_statusbar_remove (GtkStatusbar *statusbar,
                        guint context_id,
                        guint message_id);

    void gtk_statusbar_set_has_resize_grip (GtkStatusbar *statusbar,
                        gboolean setting);
    gboolean gtk_statusbar_get_has_resize_grip (GtkStatusbar *statusbar);
    alias _GtkStockItem GtkStockItem;


    struct _GtkStockItem {
    gchar *stock_id;
    gchar *label;
    GdkModifierType modifier;
    guint keyval;
    gchar *translation_domain;
    }

    void gtk_stock_add ( GtkStockItem *items,
                guint n_items);
    void gtk_stock_add_static ( GtkStockItem *items,
                guint n_items);
    gboolean gtk_stock_lookup ( gchar *stock_id,
                GtkStockItem *item);




    GSList* gtk_stock_list_ids ();

    GtkStockItem *gtk_stock_item_copy ( GtkStockItem *item);
    void gtk_stock_item_free (GtkStockItem *item);

    alias _GtkTable GtkTable;

    alias _GtkTableClass GtkTableClass;

    alias _GtkTableChild GtkTableChild;

    alias _GtkTableRowCol GtkTableRowCol;


    struct _GtkTable {
    GtkContainer container;

    GList *children;
    GtkTableRowCol *rows;
    GtkTableRowCol *cols;
    guint16 nrows;
    guint16 ncols;
    guint16 column_spacing;
    guint16 row_spacing;
    guint homogeneous;
    }

    struct _GtkTableClass {
    GtkContainerClass parent_class;
    }

    struct _GtkTableChild {
    GtkWidget *widget;
    guint16 left_attach;
    guint16 right_attach;
    guint16 top_attach;
    guint16 bottom_attach;
    guint16 xpadding;
    guint16 ypadding;
    guint xexpand;
    guint yexpand;
    guint xshrink;
    guint yshrink;
    guint xfill;
    guint yfill;
    }

    struct _GtkTableRowCol {
    guint16 requisition;
    guint16 allocation;
    guint16 spacing;
    guint need_expand;
    guint need_shrink;
    guint expand;
    guint shrink;
    guint empty;
    }


    GType gtk_table_get_type () ;
    GtkWidget* gtk_table_new (guint rows,
                    guint columns,
                    gboolean homogeneous);
    void gtk_table_resize (GtkTable *table,
                    guint rows,
                    guint columns);
    void gtk_table_attach (GtkTable *table,
                    GtkWidget *child,
                    guint left_attach,
                    guint right_attach,
                    guint top_attach,
                    guint bottom_attach,
                    GtkAttachOptions xoptions,
                    GtkAttachOptions yoptions,
                    guint xpadding,
                    guint ypadding);
    void gtk_table_attach_defaults (GtkTable *table,
                    GtkWidget *widget,
                    guint left_attach,
                    guint right_attach,
                    guint top_attach,
                    guint bottom_attach);
    void gtk_table_set_row_spacing (GtkTable *table,
                    guint row,
                    guint spacing);
    guint gtk_table_get_row_spacing (GtkTable *table,
                    guint row);
    void gtk_table_set_col_spacing (GtkTable *table,
                    guint column,
                    guint spacing);
    guint gtk_table_get_col_spacing (GtkTable *table,
                    guint column);
    void gtk_table_set_row_spacings (GtkTable *table,
                    guint spacing);
    guint gtk_table_get_default_row_spacing (GtkTable *table);
    void gtk_table_set_col_spacings (GtkTable *table,
                    guint spacing);
    guint gtk_table_get_default_col_spacing (GtkTable *table);
    void gtk_table_set_homogeneous (GtkTable *table,
                    gboolean homogeneous);
    gboolean gtk_table_get_homogeneous (GtkTable *table);
    alias _GtkTearoffMenuItem GtkTearoffMenuItem;

    alias _GtkTearoffMenuItemClass GtkTearoffMenuItemClass;


    struct _GtkTearoffMenuItem {
    GtkMenuItem menu_item;

    guint torn_off;
    }

    struct _GtkTearoffMenuItemClass {
    GtkMenuItemClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_tearoff_menu_item_get_type () ;
    GtkWidget* gtk_tearoff_menu_item_new ();



    alias _GtkTextIter GtkTextIter;

    alias _GtkTextTagTable GtkTextTagTable;


    alias _GtkTextAttributes GtkTextAttributes;

    alias _GtkTextTag GtkTextTag;

    alias _GtkTextTagClass GtkTextTagClass;


    struct _GtkTextTag {
    GObject parent_instance;

    GtkTextTagTable *table;

    char *name;



    int priority;
    GtkTextAttributes *values;




    guint bg_color_set;
    guint bg_stipple_set;
    guint fg_color_set;
    guint scale_set;
    guint fg_stipple_set;
    guint justification_set;
    guint left_margin_set;
    guint indent_set;
    guint rise_set;
    guint strikethrough_set;
    guint right_margin_set;
    guint pixels_above_lines_set;
    guint pixels_below_lines_set;
    guint pixels_inside_wrap_set;
    guint tabs_set;
    guint underline_set;
    guint wrap_mode_set;
    guint bg_full_height_set;
    guint invisible_set;
    guint editable_set;
    guint language_set;
    guint pad1;
    guint pad2;
    guint pad3;
    }

    struct _GtkTextTagClass {
    GObjectClass parent_class;

    gboolean (* event) (GtkTextTag *tag,
            GObject *event_object,
            GdkEvent *event,
            GtkTextIter *iter);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_text_tag_get_type () ;
    GtkTextTag *gtk_text_tag_new ( gchar *name);
    gint gtk_text_tag_get_priority (GtkTextTag *tag);
    void gtk_text_tag_set_priority (GtkTextTag *tag,
                        gint priority);
    gboolean gtk_text_tag_event (GtkTextTag *tag,
                        GObject *event_object,
                        GdkEvent *event,
                        GtkTextIter *iter);





    alias _GtkTextAppearance GtkTextAppearance;


    struct _GtkTextAppearance {

    GdkColor bg_color;
    GdkColor fg_color;
    GdkBitmap *bg_stipple;
    GdkBitmap *fg_stipple;


    gint rise;





    gpointer padding1;


    guint underline;
    guint strikethrough;






    guint draw_bg;





    guint inside_selection;
    guint is_text;


    guint pad1;
    guint pad2;
    guint pad3;
    guint pad4;
    }

    struct _GtkTextAttributes {

    guint refcount;


    GtkTextAppearance appearance;

    GtkJustification justification;
    GtkTextDirection direction;


    PangoFontDescription *font;

    gdouble font_scale;

    gint left_margin;

    gint indent;

    gint right_margin;

    gint pixels_above_lines;

    gint pixels_below_lines;

    gint pixels_inside_wrap;

    PangoTabArray *tabs;

    GtkWrapMode wrap_mode;




    PangoLanguage *language;





    gpointer padding1;



    guint invisible;




    guint bg_full_height;


    guint editable;


    guint realized;


    guint pad1;
    guint pad2;
    guint pad3;
    guint pad4;
    }

    GtkTextAttributes* gtk_text_attributes_new ();
    GtkTextAttributes* gtk_text_attributes_copy (GtkTextAttributes *src);
    void gtk_text_attributes_copy_values (GtkTextAttributes *src,
                            GtkTextAttributes *dest);
    void gtk_text_attributes_unref (GtkTextAttributes *values);
    void gtk_text_attributes_ref (GtkTextAttributes *values);

    GType gtk_text_attributes_get_type ();







    alias void (* GtkTextTagTableForeach) (GtkTextTag *tag, gpointer data);
    alias _GtkTextTagTableClass GtkTextTagTableClass;


    struct _GtkTextTagTable {
    GObject parent_instance;

    GHashTable *hash;
    GSList *anonymous;
    gint anon_count;

    GSList *buffers;
    }

    struct _GtkTextTagTableClass {
    GObjectClass parent_class;

    void (* tag_changed) (GtkTextTagTable *table, GtkTextTag *tag, gboolean size_changed);
    void (* tag_added) (GtkTextTagTable *table, GtkTextTag *tag);
    void (* tag_removed) (GtkTextTagTable *table, GtkTextTag *tag);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_text_tag_table_get_type () ;

    GtkTextTagTable *gtk_text_tag_table_new ();
    void gtk_text_tag_table_add (GtkTextTagTable *table,
                        GtkTextTag *tag);
    void gtk_text_tag_table_remove (GtkTextTagTable *table,
                        GtkTextTag *tag);
    GtkTextTag *gtk_text_tag_table_lookup (GtkTextTagTable *table,
                        gchar *name);
    void gtk_text_tag_table_foreach (GtkTextTagTable *table,
                        GtkTextTagTableForeach func,
                        gpointer data);
    gint gtk_text_tag_table_get_size (GtkTextTagTable *table);





    void _gtk_text_tag_table_add_buffer (GtkTextTagTable *table,
                        gpointer buffer);
    void _gtk_text_tag_table_remove_buffer (GtkTextTagTable *table,
                        gpointer buffer);
    alias _GtkTextChildAnchor GtkTextChildAnchor;

    alias _GtkTextChildAnchorClass GtkTextChildAnchorClass;

    struct _GtkTextChildAnchor {
    GObject parent_instance;

    gpointer segment;
    }

    struct _GtkTextChildAnchorClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_text_child_anchor_get_type () ;

    GtkTextChildAnchor* gtk_text_child_anchor_new ();

    GList* gtk_text_child_anchor_get_widgets (GtkTextChildAnchor *anchor);
    gboolean gtk_text_child_anchor_get_deleted (GtkTextChildAnchor *anchor);





    enum GtkTextSearchFlags {
    GTK_TEXT_SEARCH_VISIBLE_ONLY = 1 << 0,
    GTK_TEXT_SEARCH_TEXT_ONLY = 1 << 1

    };








    alias _GtkTextBuffer GtkTextBuffer;




    struct _GtkTextIter {





    gpointer dummy1;
    gpointer dummy2;
    gint dummy3;
    gint dummy4;
    gint dummy5;
    gint dummy6;
    gint dummy7;
    gint dummy8;
    gpointer dummy9;
    gpointer dummy10;
    gint dummy11;
    gint dummy12;

    gint dummy13;
    gpointer dummy14;
    }




    GtkTextBuffer *gtk_text_iter_get_buffer ( GtkTextIter *iter);





    GtkTextIter *gtk_text_iter_copy ( GtkTextIter *iter);
    void gtk_text_iter_free (GtkTextIter *iter);

    GType gtk_text_iter_get_type ();





    gint gtk_text_iter_get_offset ( GtkTextIter *iter);
    gint gtk_text_iter_get_line ( GtkTextIter *iter);
    gint gtk_text_iter_get_line_offset ( GtkTextIter *iter);
    gint gtk_text_iter_get_line_index ( GtkTextIter *iter);

    gint gtk_text_iter_get_visible_line_offset ( GtkTextIter *iter);
    gint gtk_text_iter_get_visible_line_index ( GtkTextIter *iter);





    gunichar gtk_text_iter_get_char ( GtkTextIter *iter);




    gchar *gtk_text_iter_get_slice ( GtkTextIter *start,
                        GtkTextIter *end);


    gchar *gtk_text_iter_get_text ( GtkTextIter *start,
                        GtkTextIter *end);

    gchar *gtk_text_iter_get_visible_slice ( GtkTextIter *start,
                        GtkTextIter *end);
    gchar *gtk_text_iter_get_visible_text ( GtkTextIter *start,
                        GtkTextIter *end);

    GdkPixbuf* gtk_text_iter_get_pixbuf ( GtkTextIter *iter);
    GSList * gtk_text_iter_get_marks ( GtkTextIter *iter);

    GtkTextChildAnchor* gtk_text_iter_get_child_anchor ( GtkTextIter *iter);




    GSList *gtk_text_iter_get_toggled_tags ( GtkTextIter *iter,
                        gboolean toggled_on);

    gboolean gtk_text_iter_begins_tag ( GtkTextIter *iter,
                        GtkTextTag *tag);

    gboolean gtk_text_iter_ends_tag ( GtkTextIter *iter,
                        GtkTextTag *tag);

    gboolean gtk_text_iter_toggles_tag ( GtkTextIter *iter,
                        GtkTextTag *tag);

    gboolean gtk_text_iter_has_tag ( GtkTextIter *iter,
                        GtkTextTag *tag);
    GSList *gtk_text_iter_get_tags ( GtkTextIter *iter);

    gboolean gtk_text_iter_editable ( GtkTextIter *iter,
                        gboolean default_setting);
    gboolean gtk_text_iter_can_insert ( GtkTextIter *iter,
                        gboolean default_editability);

    gboolean gtk_text_iter_starts_word ( GtkTextIter *iter);
    gboolean gtk_text_iter_ends_word ( GtkTextIter *iter);
    gboolean gtk_text_iter_inside_word ( GtkTextIter *iter);
    gboolean gtk_text_iter_starts_sentence ( GtkTextIter *iter);
    gboolean gtk_text_iter_ends_sentence ( GtkTextIter *iter);
    gboolean gtk_text_iter_inside_sentence ( GtkTextIter *iter);
    gboolean gtk_text_iter_starts_line ( GtkTextIter *iter);
    gboolean gtk_text_iter_ends_line ( GtkTextIter *iter);
    gboolean gtk_text_iter_is_cursor_position ( GtkTextIter *iter);

    gint gtk_text_iter_get_chars_in_line ( GtkTextIter *iter);
    gint gtk_text_iter_get_bytes_in_line ( GtkTextIter *iter);

    gboolean gtk_text_iter_get_attributes ( GtkTextIter *iter,
                        GtkTextAttributes *values);
    PangoLanguage* gtk_text_iter_get_language ( GtkTextIter *iter);
    gboolean gtk_text_iter_is_end ( GtkTextIter *iter);
    gboolean gtk_text_iter_is_start ( GtkTextIter *iter);





    gboolean gtk_text_iter_forward_char (GtkTextIter *iter);
    gboolean gtk_text_iter_backward_char (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_chars (GtkTextIter *iter,
                        gint count);
    gboolean gtk_text_iter_backward_chars (GtkTextIter *iter,
                        gint count);
    gboolean gtk_text_iter_forward_line (GtkTextIter *iter);
    gboolean gtk_text_iter_backward_line (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_lines (GtkTextIter *iter,
                        gint count);
    gboolean gtk_text_iter_backward_lines (GtkTextIter *iter,
                        gint count);
    gboolean gtk_text_iter_forward_word_end (GtkTextIter *iter);
    gboolean gtk_text_iter_backward_word_start (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_word_ends (GtkTextIter *iter,
                        gint count);
    gboolean gtk_text_iter_backward_word_starts (GtkTextIter *iter,
                        gint count);

    gboolean gtk_text_iter_forward_visible_word_end (GtkTextIter *iter);
    gboolean gtk_text_iter_backward_visible_word_start (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_visible_word_ends (GtkTextIter *iter,
                        gint count);
    gboolean gtk_text_iter_backward_visible_word_starts (GtkTextIter *iter,
                        gint count);

    gboolean gtk_text_iter_forward_sentence_end (GtkTextIter *iter);
    gboolean gtk_text_iter_backward_sentence_start (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_sentence_ends (GtkTextIter *iter,
                            gint count);
    gboolean gtk_text_iter_backward_sentence_starts (GtkTextIter *iter,
                            gint count);





    gboolean gtk_text_iter_forward_cursor_position (GtkTextIter *iter);
    gboolean gtk_text_iter_backward_cursor_position (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_cursor_positions (GtkTextIter *iter,
                            gint count);
    gboolean gtk_text_iter_backward_cursor_positions (GtkTextIter *iter,
                            gint count);

    gboolean gtk_text_iter_forward_visible_cursor_position (GtkTextIter *iter);
    gboolean gtk_text_iter_backward_visible_cursor_position (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_visible_cursor_positions (GtkTextIter *iter,
                                gint count);
    gboolean gtk_text_iter_backward_visible_cursor_positions (GtkTextIter *iter,
                                gint count);


    void gtk_text_iter_set_offset (GtkTextIter *iter,
                        gint char_offset);
    void gtk_text_iter_set_line (GtkTextIter *iter,
                        gint line_number);
    void gtk_text_iter_set_line_offset (GtkTextIter *iter,
                        gint char_on_line);
    void gtk_text_iter_set_line_index (GtkTextIter *iter,
                        gint byte_on_line);
    void gtk_text_iter_forward_to_end (GtkTextIter *iter);
    gboolean gtk_text_iter_forward_to_line_end (GtkTextIter *iter);

    void gtk_text_iter_set_visible_line_offset (GtkTextIter *iter,
                            gint char_on_line);
    void gtk_text_iter_set_visible_line_index (GtkTextIter *iter,
                            gint byte_on_line);





    gboolean gtk_text_iter_forward_to_tag_toggle (GtkTextIter *iter,
                        GtkTextTag *tag);

    gboolean gtk_text_iter_backward_to_tag_toggle (GtkTextIter *iter,
                        GtkTextTag *tag);

    alias gboolean (* GtkTextCharPredicate) (gunichar ch, gpointer user_data);

    gboolean gtk_text_iter_forward_find_char (GtkTextIter *iter,
                        GtkTextCharPredicate pred,
                        gpointer user_data,
                        GtkTextIter *limit);
    gboolean gtk_text_iter_backward_find_char (GtkTextIter *iter,
                        GtkTextCharPredicate pred,
                        gpointer user_data,
                        GtkTextIter *limit);

    gboolean gtk_text_iter_forward_search ( GtkTextIter *iter,
                        gchar *str,
                        GtkTextSearchFlags flags,
                        GtkTextIter *match_start,
                        GtkTextIter *match_end,
                        GtkTextIter *limit);

    gboolean gtk_text_iter_backward_search ( GtkTextIter *iter,
                        gchar *str,
                        GtkTextSearchFlags flags,
                        GtkTextIter *match_start,
                        GtkTextIter *match_end,
                        GtkTextIter *limit);





    gboolean gtk_text_iter_equal ( GtkTextIter *lhs,
                        GtkTextIter *rhs);
    gint gtk_text_iter_compare ( GtkTextIter *lhs,
                        GtkTextIter *rhs);
    gboolean gtk_text_iter_in_range ( GtkTextIter *iter,
                        GtkTextIter *start,
                        GtkTextIter *end);


    void gtk_text_iter_order (GtkTextIter *first,
                        GtkTextIter *second);
    alias _GtkTextMark GtkTextMark;

    alias _GtkTextMarkClass GtkTextMarkClass;

    struct _GtkTextMark {
    GObject parent_instance;

    gpointer segment;
    }

    struct _GtkTextMarkClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    GType gtk_text_mark_get_type () ;

    void gtk_text_mark_set_visible (GtkTextMark *mark,
                        gboolean setting);
    gboolean gtk_text_mark_get_visible (GtkTextMark *mark);

    gchar* gtk_text_mark_get_name (GtkTextMark *mark);
    gboolean gtk_text_mark_get_deleted (GtkTextMark *mark);
    GtkTextBuffer* gtk_text_mark_get_buffer (GtkTextMark *mark);
    gboolean gtk_text_mark_get_left_gravity (GtkTextMark *mark);
    alias _GtkTextBTree GtkTextBTree;
    alias void _GtkTextBTree;


    alias _GtkTextLogAttrCache GtkTextLogAttrCache;
    alias void _GtkTextLogAttrCache;

    alias _GtkTextBufferClass GtkTextBufferClass;


    struct _GtkTextBuffer {
    GObject parent_instance;

    GtkTextTagTable *tag_table;
    GtkTextBTree *btree;

    GSList *clipboard_contents_buffers;
    GSList *selection_clipboards;

    GtkTextLogAttrCache *log_attr_cache;

    guint user_action_count;


    guint modified;
    }

    struct _GtkTextBufferClass {
    GObjectClass parent_class;

    void (* insert_text) (GtkTextBuffer *buffer,
                GtkTextIter *pos,
                gchar *text,
                gint length);

    void (* insert_pixbuf) (GtkTextBuffer *buffer,
                GtkTextIter *pos,
                GdkPixbuf *pixbuf);

    void (* insert_child_anchor) (GtkTextBuffer *buffer,
                    GtkTextIter *pos,
                    GtkTextChildAnchor *anchor);

    void (* delete_range) (GtkTextBuffer *buffer,
                GtkTextIter *start,
                GtkTextIter *end);




    void (* changed) (GtkTextBuffer *buffer);



    void (* modified_changed) (GtkTextBuffer *buffer);


    void (* mark_set) (GtkTextBuffer *buffer,
                    GtkTextIter *location,
                GtkTextMark *mark);

    void (* mark_deleted) (GtkTextBuffer *buffer,
                GtkTextMark *mark);

    void (* apply_tag) (GtkTextBuffer *buffer,
                GtkTextTag *tag,
                    GtkTextIter *start_char,
                    GtkTextIter *end_char);

    void (* remove_tag) (GtkTextBuffer *buffer,
                GtkTextTag *tag,
                    GtkTextIter *start_char,
                    GtkTextIter *end_char);


    void (* begin_user_action) (GtkTextBuffer *buffer);
    void (* end_user_action) (GtkTextBuffer *buffer);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    void (*_gtk_reserved5) ();
    void (*_gtk_reserved6) ();
    }

    GType gtk_text_buffer_get_type () ;




    GtkTextBuffer *gtk_text_buffer_new (GtkTextTagTable *table);
    gint gtk_text_buffer_get_line_count (GtkTextBuffer *buffer);
    gint gtk_text_buffer_get_char_count (GtkTextBuffer *buffer);


    GtkTextTagTable* gtk_text_buffer_get_tag_table (GtkTextBuffer *buffer);


    void gtk_text_buffer_set_text (GtkTextBuffer *buffer,
                        gchar *text,
                        gint len);


    void gtk_text_buffer_insert (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        gchar *text,
                        gint len);
    void gtk_text_buffer_insert_at_cursor (GtkTextBuffer *buffer,
                        gchar *text,
                        gint len);

    gboolean gtk_text_buffer_insert_interactive (GtkTextBuffer *buffer,
                            GtkTextIter *iter,
                                gchar *text,
                            gint len,
                            gboolean default_editable);
    gboolean gtk_text_buffer_insert_interactive_at_cursor (GtkTextBuffer *buffer,
                                gchar *text,
                            gint len,
                            gboolean default_editable);

    void gtk_text_buffer_insert_range (GtkTextBuffer *buffer,
                            GtkTextIter *iter,
                            GtkTextIter *start,
                            GtkTextIter *end);
    gboolean gtk_text_buffer_insert_range_interactive (GtkTextBuffer *buffer,
                            GtkTextIter *iter,
                            GtkTextIter *start,
                            GtkTextIter *end,
                            gboolean default_editable);

    void gtk_text_buffer_insert_with_tags (GtkTextBuffer *buffer,
                            GtkTextIter *iter,
                            gchar *text,
                            gint len,
                            GtkTextTag *first_tag,
                            ...);

    void gtk_text_buffer_insert_with_tags_by_name (GtkTextBuffer *buffer,
                            GtkTextIter *iter,
                            gchar *text,
                            gint len,
                            gchar *first_tag_name,
                            ...);


    void gtk_text_buffer_delete (GtkTextBuffer *buffer,
                        GtkTextIter *start,
                        GtkTextIter *end);
    gboolean gtk_text_buffer_delete_interactive (GtkTextBuffer *buffer,
                        GtkTextIter *start_iter,
                        GtkTextIter *end_iter,
                        gboolean default_editable);




    gchar *gtk_text_buffer_get_text (GtkTextBuffer *buffer,
                            GtkTextIter *start,
                            GtkTextIter *end,
                            gboolean include_hidden_chars);

    gchar *gtk_text_buffer_get_slice (GtkTextBuffer *buffer,
                            GtkTextIter *start,
                            GtkTextIter *end,
                            gboolean include_hidden_chars);


    void gtk_text_buffer_insert_pixbuf (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        GdkPixbuf *pixbuf);


    void gtk_text_buffer_insert_child_anchor (GtkTextBuffer *buffer,
                                GtkTextIter *iter,
                                GtkTextChildAnchor *anchor);


    GtkTextChildAnchor *gtk_text_buffer_create_child_anchor (GtkTextBuffer *buffer,
                                GtkTextIter *iter);


    GtkTextMark *gtk_text_buffer_create_mark (GtkTextBuffer *buffer,
                        gchar *mark_name,
                        GtkTextIter *where,
                        gboolean left_gravity);
    void gtk_text_buffer_move_mark (GtkTextBuffer *buffer,
                        GtkTextMark *mark,
                        GtkTextIter *where);
    void gtk_text_buffer_delete_mark (GtkTextBuffer *buffer,
                        GtkTextMark *mark);
    GtkTextMark* gtk_text_buffer_get_mark (GtkTextBuffer *buffer,
                        gchar *name);

    void gtk_text_buffer_move_mark_by_name (GtkTextBuffer *buffer,
                        gchar *name,
                        GtkTextIter *where);
    void gtk_text_buffer_delete_mark_by_name (GtkTextBuffer *buffer,
                        gchar *name);

    GtkTextMark* gtk_text_buffer_get_insert (GtkTextBuffer *buffer);
    GtkTextMark* gtk_text_buffer_get_selection_bound (GtkTextBuffer *buffer);


    void gtk_text_buffer_place_cursor (GtkTextBuffer *buffer,
                    GtkTextIter *where);
    void gtk_text_buffer_select_range (GtkTextBuffer *buffer,
                    GtkTextIter *ins,
                    GtkTextIter *bound);




    void gtk_text_buffer_apply_tag (GtkTextBuffer *buffer,
                        GtkTextTag *tag,
                        GtkTextIter *start,
                        GtkTextIter *end);
    void gtk_text_buffer_remove_tag (GtkTextBuffer *buffer,
                        GtkTextTag *tag,
                        GtkTextIter *start,
                        GtkTextIter *end);
    void gtk_text_buffer_apply_tag_by_name (GtkTextBuffer *buffer,
                        gchar *name,
                        GtkTextIter *start,
                        GtkTextIter *end);
    void gtk_text_buffer_remove_tag_by_name (GtkTextBuffer *buffer,
                        gchar *name,
                        GtkTextIter *start,
                        GtkTextIter *end);
    void gtk_text_buffer_remove_all_tags (GtkTextBuffer *buffer,
                        GtkTextIter *start,
                        GtkTextIter *end);





    GtkTextTag *gtk_text_buffer_create_tag (GtkTextBuffer *buffer,
                        gchar *tag_name,
                        gchar *first_property_name,
                        ...);




    void gtk_text_buffer_get_iter_at_line_offset (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        gint line_number,
                        gint char_offset);
    void gtk_text_buffer_get_iter_at_line_index (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        gint line_number,
                        gint byte_index);
    void gtk_text_buffer_get_iter_at_offset (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        gint char_offset);
    void gtk_text_buffer_get_iter_at_line (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        gint line_number);
    void gtk_text_buffer_get_start_iter (GtkTextBuffer *buffer,
                        GtkTextIter *iter);
    void gtk_text_buffer_get_end_iter (GtkTextBuffer *buffer,
                        GtkTextIter *iter);
    void gtk_text_buffer_get_bounds (GtkTextBuffer *buffer,
                        GtkTextIter *start,
                        GtkTextIter *end);
    void gtk_text_buffer_get_iter_at_mark (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        GtkTextMark *mark);

    void gtk_text_buffer_get_iter_at_child_anchor (GtkTextBuffer *buffer,
                        GtkTextIter *iter,
                        GtkTextChildAnchor *anchor);
    gboolean gtk_text_buffer_get_modified (GtkTextBuffer *buffer);
    void gtk_text_buffer_set_modified (GtkTextBuffer *buffer,
                                gboolean setting);

    void gtk_text_buffer_add_selection_clipboard (GtkTextBuffer *buffer,
                            GtkClipboard *clipboard);
    void gtk_text_buffer_remove_selection_clipboard (GtkTextBuffer *buffer,
                            GtkClipboard *clipboard);

    void gtk_text_buffer_cut_clipboard (GtkTextBuffer *buffer,
                                GtkClipboard *clipboard,
                                gboolean default_editable);
    void gtk_text_buffer_copy_clipboard (GtkTextBuffer *buffer,
                                GtkClipboard *clipboard);
    void gtk_text_buffer_paste_clipboard (GtkTextBuffer *buffer,
                                GtkClipboard *clipboard,
                                GtkTextIter *override_location,
                                gboolean default_editable);

    gboolean gtk_text_buffer_get_selection_bounds (GtkTextBuffer *buffer,
                                GtkTextIter *start,
                                GtkTextIter *end);
    gboolean gtk_text_buffer_delete_selection (GtkTextBuffer *buffer,
                                gboolean interactive,
                                gboolean default_editable);


    void gtk_text_buffer_begin_user_action (GtkTextBuffer *buffer);
    void gtk_text_buffer_end_user_action (GtkTextBuffer *buffer);


    void _gtk_text_buffer_spew (GtkTextBuffer *buffer);

    GtkTextBTree* _gtk_text_buffer_get_btree (GtkTextBuffer *buffer);

    PangoLogAttr* _gtk_text_buffer_get_line_log_attrs (GtkTextBuffer *buffer,
                                GtkTextIter *anywhere_in_line,
                                gint *char_len);

    void _gtk_text_buffer_notify_will_remove_tag (GtkTextBuffer *buffer,
                        GtkTextTag *tag);
    enum GtkTextWindowType {
    GTK_TEXT_WINDOW_PRIVATE,
    GTK_TEXT_WINDOW_WIDGET,
    GTK_TEXT_WINDOW_TEXT,
    GTK_TEXT_WINDOW_LEFT,
    GTK_TEXT_WINDOW_RIGHT,
    GTK_TEXT_WINDOW_TOP,
    GTK_TEXT_WINDOW_BOTTOM
    };




    alias _GtkTextView GtkTextView;

    alias _GtkTextViewClass GtkTextViewClass;



    alias _GtkTextWindow GtkTextWindow;
    alias void _GtkTextWindow;

    alias _GtkTextPendingScroll GtkTextPendingScroll;
    alias void _GtkTextPendingScroll;


    struct _GtkTextView {
    GtkContainer parent_instance;

    void *layout;
    GtkTextBuffer *buffer;

    guint selection_drag_handler;
    guint scroll_timeout;


    gint pixels_above_lines;
    gint pixels_below_lines;
    gint pixels_inside_wrap;
    GtkWrapMode wrap_mode;
    GtkJustification justify;
    gint left_margin;
    gint right_margin;
    gint indent;
    PangoTabArray *tabs;
    guint editable;



    guint overwrite_mode;
    guint cursor_visible;


    guint need_im_reset;

    guint accepts_tab;


    guint reserved;




    guint onscreen_validated;

    guint mouse_cursor_obscured;

    GtkTextWindow *text_window;
    GtkTextWindow *left_window;
    GtkTextWindow *right_window;
    GtkTextWindow *top_window;
    GtkTextWindow *bottom_window;

    GtkAdjustment *hadjustment;
    GtkAdjustment *vadjustment;

    gint xoffset;
    gint yoffset;
    gint width;
    gint height;
    gint virtual_cursor_x;
    gint virtual_cursor_y;

    GtkTextMark *first_para_mark;
    gint first_para_pixels;

    GtkTextMark *dnd_mark;
    guint blink_timeout;

    guint first_validate_idle;
    guint incremental_validate_idle;

    GtkIMContext *im_context;
    GtkWidget *popup_menu;

    gint drag_start_x;
    gint drag_start_y;

    GSList *children;

    GtkTextPendingScroll *pending_scroll;

    gint pending_place_cursor_button;
    }

    struct _GtkTextViewClass {
    GtkContainerClass parent_class;

    void (* set_scroll_adjustments) (GtkTextView *text_view,
                    GtkAdjustment *hadjustment,
                    GtkAdjustment *vadjustment);

    void (* populate_popup) (GtkTextView *text_view,
                    GtkMenu *menu);




    void (* move_cursor) (GtkTextView *text_view,
                GtkMovementStep step,
                gint count,
                gboolean extend_selection);





    void (* page_horizontally) (GtkTextView *text_view,
                gint count,
                gboolean extend_selection);


    void (* set_anchor) (GtkTextView *text_view);


    void (* insert_at_cursor) (GtkTextView *text_view,
                    gchar *str);
    void (* delete_from_cursor) (GtkTextView *text_view,
                    GtkDeleteType type,
                    gint count);


    void (* cut_clipboard) (GtkTextView *text_view);
    void (* copy_clipboard) (GtkTextView *text_view);
    void (* paste_clipboard) (GtkTextView *text_view);

    void (* toggle_overwrite) (GtkTextView *text_view);


    void (* move_focus) (GtkTextView *text_view,
                GtkDirectionType direction);



    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    void (*_gtk_reserved5) ();
    void (*_gtk_reserved6) ();
    void (*_gtk_reserved7) ();
    void (*_gtk_reserved8) ();
    }

    GType gtk_text_view_get_type () ;
    GtkWidget * gtk_text_view_new ();
    GtkWidget * gtk_text_view_new_with_buffer (GtkTextBuffer *buffer);
    void gtk_text_view_set_buffer (GtkTextView *text_view,
                            GtkTextBuffer *buffer);
    GtkTextBuffer *gtk_text_view_get_buffer (GtkTextView *text_view);
    gboolean gtk_text_view_scroll_to_iter (GtkTextView *text_view,
                            GtkTextIter *iter,
                            gdouble within_margin,
                            gboolean use_align,
                            gdouble xalign,
                            gdouble yalign);
    void gtk_text_view_scroll_to_mark (GtkTextView *text_view,
                            GtkTextMark *mark,
                            gdouble within_margin,
                            gboolean use_align,
                            gdouble xalign,
                            gdouble yalign);
    void gtk_text_view_scroll_mark_onscreen (GtkTextView *text_view,
                            GtkTextMark *mark);
    gboolean gtk_text_view_move_mark_onscreen (GtkTextView *text_view,
                            GtkTextMark *mark);
    gboolean gtk_text_view_place_cursor_onscreen (GtkTextView *text_view);

    void gtk_text_view_get_visible_rect (GtkTextView *text_view,
                            GdkRectangle *visible_rect);
    void gtk_text_view_set_cursor_visible (GtkTextView *text_view,
                            gboolean setting);
    gboolean gtk_text_view_get_cursor_visible (GtkTextView *text_view);

    void gtk_text_view_get_iter_location (GtkTextView *text_view,
                            GtkTextIter *iter,
                            GdkRectangle *location);
    void gtk_text_view_get_iter_at_location (GtkTextView *text_view,
                            GtkTextIter *iter,
                            gint x,
                            gint y);
    void gtk_text_view_get_line_yrange (GtkTextView *text_view,
                            GtkTextIter *iter,
                            gint *y,
                            gint *height);

    void gtk_text_view_get_line_at_y (GtkTextView *text_view,
                            GtkTextIter *target_iter,
                            gint y,
                            gint *line_top);

    void gtk_text_view_buffer_to_window_coords (GtkTextView *text_view,
                        GtkTextWindowType win,
                        gint buffer_x,
                        gint buffer_y,
                        gint *window_x,
                        gint *window_y);
    void gtk_text_view_window_to_buffer_coords (GtkTextView *text_view,
                        GtkTextWindowType win,
                        gint window_x,
                        gint window_y,
                        gint *buffer_x,
                        gint *buffer_y);

    GdkWindow* gtk_text_view_get_window (GtkTextView *text_view,
                            GtkTextWindowType win);
    GtkTextWindowType gtk_text_view_get_window_type (GtkTextView *text_view,
                            GdkWindow *window);

    void gtk_text_view_set_border_window_size (GtkTextView *text_view,
                        GtkTextWindowType type,
                        gint size);
    gint gtk_text_view_get_border_window_size (GtkTextView *text_view,
                        GtkTextWindowType type);

    gboolean gtk_text_view_forward_display_line (GtkTextView *text_view,
                            GtkTextIter *iter);
    gboolean gtk_text_view_backward_display_line (GtkTextView *text_view,
                            GtkTextIter *iter);
    gboolean gtk_text_view_forward_display_line_end (GtkTextView *text_view,
                            GtkTextIter *iter);
    gboolean gtk_text_view_backward_display_line_start (GtkTextView *text_view,
                            GtkTextIter *iter);
    gboolean gtk_text_view_starts_display_line (GtkTextView *text_view,
                                GtkTextIter *iter);
    gboolean gtk_text_view_move_visually (GtkTextView *text_view,
                            GtkTextIter *iter,
                            gint count);


    void gtk_text_view_add_child_at_anchor (GtkTextView *text_view,
                        GtkWidget *child,
                        GtkTextChildAnchor *anchor);

    void gtk_text_view_add_child_in_window (GtkTextView *text_view,
                        GtkWidget *child,
                        GtkTextWindowType which_window,

                        gint xpos,
                        gint ypos);

    void gtk_text_view_move_child (GtkTextView *text_view,
                        GtkWidget *child,

                        gint xpos,
                        gint ypos);



    void gtk_text_view_set_wrap_mode (GtkTextView *text_view,
                            GtkWrapMode wrap_mode);
    GtkWrapMode gtk_text_view_get_wrap_mode (GtkTextView *text_view);
    void gtk_text_view_set_editable (GtkTextView *text_view,
                            gboolean setting);
    gboolean gtk_text_view_get_editable (GtkTextView *text_view);
    void gtk_text_view_set_overwrite (GtkTextView *text_view,
                            gboolean overwrite);
    gboolean gtk_text_view_get_overwrite (GtkTextView *text_view);
    void gtk_text_view_set_accepts_tab (GtkTextView *text_view,
                            gboolean accepts_tab);
    gboolean gtk_text_view_get_accepts_tab (GtkTextView *text_view);
    void gtk_text_view_set_pixels_above_lines (GtkTextView *text_view,
                            gint pixels_above_lines);
    gint gtk_text_view_get_pixels_above_lines (GtkTextView *text_view);
    void gtk_text_view_set_pixels_below_lines (GtkTextView *text_view,
                            gint pixels_below_lines);
    gint gtk_text_view_get_pixels_below_lines (GtkTextView *text_view);
    void gtk_text_view_set_pixels_inside_wrap (GtkTextView *text_view,
                            gint pixels_inside_wrap);
    gint gtk_text_view_get_pixels_inside_wrap (GtkTextView *text_view);
    void gtk_text_view_set_justification (GtkTextView *text_view,
                            GtkJustification justification);
    GtkJustification gtk_text_view_get_justification (GtkTextView *text_view);
    void gtk_text_view_set_left_margin (GtkTextView *text_view,
                            gint left_margin);
    gint gtk_text_view_get_left_margin (GtkTextView *text_view);
    void gtk_text_view_set_right_margin (GtkTextView *text_view,
                            gint right_margin);
    gint gtk_text_view_get_right_margin (GtkTextView *text_view);
    void gtk_text_view_set_indent (GtkTextView *text_view,
                            gint indent);
    gint gtk_text_view_get_indent (GtkTextView *text_view);
    void gtk_text_view_set_tabs (GtkTextView *text_view,
                            PangoTabArray *tabs);
    PangoTabArray* gtk_text_view_get_tabs (GtkTextView *text_view);


    GtkTextAttributes* gtk_text_view_get_default_attributes (GtkTextView *text_view);
    alias _GtkTipsQuery GtkTipsQuery;

    alias _GtkTipsQueryClass GtkTipsQueryClass;




    struct _GtkTipsQuery {
    GtkLabel label;

    guint emit_always;
    guint in_query;
    gchar *label_inactive;
    gchar *label_no_tip;

    GtkWidget *caller;
    GtkWidget *last_crossed;

    GdkCursor *query_cursor;
    }

    struct _GtkTipsQueryClass {
    GtkLabelClass parent_class;

    void (*start_query) (GtkTipsQuery *tips_query);
    void (*stop_query) (GtkTipsQuery *tips_query);
    void (*widget_entered) (GtkTipsQuery *tips_query,
                    GtkWidget *widget,
                    gchar *tip_text,
                    gchar *tip_private);
    gint (*widget_selected) (GtkTipsQuery *tips_query,
                    GtkWidget *widget,
                    gchar *tip_text,
                    gchar *tip_private,
                    GdkEventButton *event);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }



    GtkType gtk_tips_query_get_type () ;
    GtkWidget* gtk_tips_query_new ();
    void gtk_tips_query_start_query (GtkTipsQuery *tips_query);
    void gtk_tips_query_stop_query (GtkTipsQuery *tips_query);
    void gtk_tips_query_set_caller (GtkTipsQuery *tips_query,
                            GtkWidget *caller);
    void gtk_tips_query_set_labels (GtkTipsQuery *tips_query,
                            gchar *label_inactive,
                            gchar *label_no_tip);








    enum GtkToolbarChildType {
    GTK_TOOLBAR_CHILD_SPACE,
    GTK_TOOLBAR_CHILD_BUTTON,
    GTK_TOOLBAR_CHILD_TOGGLEBUTTON,
    GTK_TOOLBAR_CHILD_RADIOBUTTON,
    GTK_TOOLBAR_CHILD_WIDGET
    };


    alias _GtkToolbarChild GtkToolbarChild;


    struct _GtkToolbarChild {
    GtkToolbarChildType type;
    GtkWidget *widget;
    GtkWidget *icon;
    GtkWidget *label;
    }



    enum GtkToolbarSpaceStyle {
    GTK_TOOLBAR_SPACE_EMPTY,
    GTK_TOOLBAR_SPACE_LINE
    };


    alias _GtkToolbar GtkToolbar;

    alias _GtkToolbarClass GtkToolbarClass;

    alias _GtkToolbarPrivate GtkToolbarPrivate;
    alias void _GtkToolbarPrivate;


    struct _GtkToolbar {
    GtkContainer container;


    gint num_children;
    GList *children;
    GtkOrientation orientation;
    GtkToolbarStyle style;
    GtkIconSize icon_size;

    GtkTooltips *tooltips;


    gint button_maxw;
    gint button_maxh;

    guint style_set_connection;
    guint icon_size_connection;

    guint style_set;
    guint icon_size_set;
    }

    struct _GtkToolbarClass {
    GtkContainerClass parent_class;


    void (* orientation_changed) (GtkToolbar *toolbar,
                    GtkOrientation orientation);
    void (* style_changed) (GtkToolbar *toolbar,
                    GtkToolbarStyle style);
    gboolean (* popup_context_menu) (GtkToolbar *toolbar,
                    gint x,
                    gint y,
                    gint button_number);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    }

    GType gtk_toolbar_get_type () ;
    GtkWidget* gtk_toolbar_new ();
    void gtk_toolbar_insert (GtkToolbar *toolbar,
                            GtkToolItem *item,
                            gint pos);
    gint gtk_toolbar_get_item_index (GtkToolbar *toolbar,
                            GtkToolItem *item);
    gint gtk_toolbar_get_n_items (GtkToolbar *toolbar);
    GtkToolItem * gtk_toolbar_get_nth_item (GtkToolbar *toolbar,
                            gint n);
    gboolean gtk_toolbar_get_show_arrow (GtkToolbar *toolbar);
    void gtk_toolbar_set_show_arrow (GtkToolbar *toolbar,
                            gboolean show_arrow);
    GtkOrientation gtk_toolbar_get_orientation (GtkToolbar *toolbar);
    void gtk_toolbar_set_orientation (GtkToolbar *toolbar,
                            GtkOrientation orientation);
    gboolean gtk_toolbar_get_tooltips (GtkToolbar *toolbar);
    void gtk_toolbar_set_tooltips (GtkToolbar *toolbar,
                            gboolean enable);
    GtkToolbarStyle gtk_toolbar_get_style (GtkToolbar *toolbar);
    void gtk_toolbar_set_style (GtkToolbar *toolbar,
                            GtkToolbarStyle style);
    void gtk_toolbar_unset_style (GtkToolbar *toolbar);
    GtkIconSize gtk_toolbar_get_icon_size (GtkToolbar *toolbar);
    GtkReliefStyle gtk_toolbar_get_relief_style (GtkToolbar *toolbar);
    gint gtk_toolbar_get_drop_index (GtkToolbar *toolbar,
                            gint x,
                            gint y);
    void gtk_toolbar_set_drop_highlight_item (GtkToolbar *toolbar,
                            GtkToolItem *tool_item,
                            gint index_);


    gchar * _gtk_toolbar_elide_underscores ( gchar *original);
    void _gtk_toolbar_paint_space_line (GtkWidget *widget,
                            GtkToolbar *toolbar,
                            GdkRectangle *area,
                            GtkAllocation *allocation);
    gint _gtk_toolbar_get_default_space_size ();





    void gtk_toolbar_set_icon_size (GtkToolbar *toolbar,
                        GtkIconSize icon_size);
    void gtk_toolbar_unset_icon_size (GtkToolbar *toolbar);


    GtkWidget* gtk_toolbar_append_item (GtkToolbar *toolbar,
                    char *text,
                    char *tooltip_text,
                    char *tooltip_private_text,
                    GtkWidget *icon,
                    GtkSignalFunc callback,
                    gpointer user_data);
    GtkWidget* gtk_toolbar_prepend_item (GtkToolbar *toolbar,
                    char *text,
                    char *tooltip_text,
                    char *tooltip_private_text,
                    GtkWidget *icon,
                    GtkSignalFunc callback,
                    gpointer user_data);
    GtkWidget* gtk_toolbar_insert_item (GtkToolbar *toolbar,
                    char *text,
                    char *tooltip_text,
                    char *tooltip_private_text,
                    GtkWidget *icon,
                    GtkSignalFunc callback,
                    gpointer user_data,
                    gint position);


    GtkWidget* gtk_toolbar_insert_stock (GtkToolbar *toolbar,
                        gchar *stock_id,
                        char *tooltip_text,
                        char *tooltip_private_text,
                        GtkSignalFunc callback,
                        gpointer user_data,
                        gint position);


    void gtk_toolbar_append_space (GtkToolbar *toolbar);
    void gtk_toolbar_prepend_space (GtkToolbar *toolbar);
    void gtk_toolbar_insert_space (GtkToolbar *toolbar,
                        gint position);
    void gtk_toolbar_remove_space (GtkToolbar *toolbar,
                        gint position);

    GtkWidget* gtk_toolbar_append_element (GtkToolbar *toolbar,
                        GtkToolbarChildType type,
                        GtkWidget *widget,
                        char *text,
                        char *tooltip_text,
                        char *tooltip_private_text,
                        GtkWidget *icon,
                        GtkSignalFunc callback,
                        gpointer user_data);

    GtkWidget* gtk_toolbar_prepend_element (GtkToolbar *toolbar,
                        GtkToolbarChildType type,
                        GtkWidget *widget,
                        char *text,
                        char *tooltip_text,
                        char *tooltip_private_text,
                        GtkWidget *icon,
                        GtkSignalFunc callback,
                        gpointer user_data);

    GtkWidget* gtk_toolbar_insert_element (GtkToolbar *toolbar,
                        GtkToolbarChildType type,
                        GtkWidget *widget,
                        char *text,
                        char *tooltip_text,
                        char *tooltip_private_text,
                        GtkWidget *icon,
                        GtkSignalFunc callback,
                        gpointer user_data,
                        gint position);


    void gtk_toolbar_append_widget (GtkToolbar *toolbar,
                        GtkWidget *widget,
                        char *tooltip_text,
                        char *tooltip_private_text);
    void gtk_toolbar_prepend_widget (GtkToolbar *toolbar,
                        GtkWidget *widget,
                        char *tooltip_text,
                        char *tooltip_private_text);
    void gtk_toolbar_insert_widget (GtkToolbar *toolbar,
                        GtkWidget *widget,
                        char *tooltip_text,
                        char *tooltip_private_text,
                        gint position);









    alias _GtkTreeDragSource GtkTreeDragSource;
    alias void _GtkTreeDragSource;

    alias _GtkTreeDragSourceIface GtkTreeDragSourceIface;


    struct _GtkTreeDragSourceIface {
    GTypeInterface g_iface;



    gboolean (* row_draggable) (GtkTreeDragSource *drag_source,
                        GtkTreePath *path);

    gboolean (* drag_data_get) (GtkTreeDragSource *drag_source,
                        GtkTreePath *path,
                        GtkSelectionData *selection_data);

    gboolean (* drag_data_delete) (GtkTreeDragSource *drag_source,
                        GtkTreePath *path);
    }

    GType gtk_tree_drag_source_get_type () ;


    gboolean gtk_tree_drag_source_row_draggable (GtkTreeDragSource *drag_source,
                            GtkTreePath *path);


    gboolean gtk_tree_drag_source_drag_data_delete (GtkTreeDragSource *drag_source,
                            GtkTreePath *path);




    gboolean gtk_tree_drag_source_drag_data_get (GtkTreeDragSource *drag_source,
                            GtkTreePath *path,
                            GtkSelectionData *selection_data);






    alias _GtkTreeDragDest GtkTreeDragDest;
    alias void _GtkTreeDragDest;

    alias _GtkTreeDragDestIface GtkTreeDragDestIface;


    struct _GtkTreeDragDestIface {
    GTypeInterface g_iface;



    gboolean (* drag_data_received) (GtkTreeDragDest *drag_dest,
                    GtkTreePath *dest,
                    GtkSelectionData *selection_data);

    gboolean (* row_drop_possible) (GtkTreeDragDest *drag_dest,
                    GtkTreePath *dest_path,
                    GtkSelectionData *selection_data);
    }

    GType gtk_tree_drag_dest_get_type () ;




    gboolean gtk_tree_drag_dest_drag_data_received (GtkTreeDragDest *drag_dest,
                            GtkTreePath *dest,
                            GtkSelectionData *selection_data);



    gboolean gtk_tree_drag_dest_row_drop_possible (GtkTreeDragDest *drag_dest,
                            GtkTreePath *dest_path,
                            GtkSelectionData *selection_data);





    gboolean gtk_tree_set_row_drag_data (GtkSelectionData *selection_data,
                            GtkTreeModel *tree_model,
                            GtkTreePath *path);
    gboolean gtk_tree_get_row_drag_data (GtkSelectionData *selection_data,
                            GtkTreeModel **tree_model,
                            GtkTreePath **path);



    alias _GtkTreeModelSort GtkTreeModelSort;

    alias _GtkTreeModelSortClass GtkTreeModelSortClass;


    struct _GtkTreeModelSort {
    GObject parent;


    gpointer root;
    gint stamp;
    guint child_flags;
    GtkTreeModel *child_model;
    gint zero_ref_count;


    GList *sort_list;
    gint sort_column_id;
    GtkSortType order;


    GtkTreeIterCompareFunc default_sort_func;
    gpointer default_sort_data;
    GtkDestroyNotify default_sort_destroy;


    guint changed_id;
    guint inserted_id;
    guint has_child_toggled_id;
    guint deleted_id;
    guint reordered_id;
    }

    struct _GtkTreeModelSortClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_tree_model_sort_get_type () ;
    GtkTreeModel *gtk_tree_model_sort_new_with_model (GtkTreeModel *child_model);

    GtkTreeModel *gtk_tree_model_sort_get_model (GtkTreeModelSort *tree_model);
    GtkTreePath *gtk_tree_model_sort_convert_child_path_to_path (GtkTreeModelSort *tree_model_sort,
                                GtkTreePath *child_path);
    void gtk_tree_model_sort_convert_child_iter_to_iter (GtkTreeModelSort *tree_model_sort,
                                GtkTreeIter *sort_iter,
                                GtkTreeIter *child_iter);
    GtkTreePath *gtk_tree_model_sort_convert_path_to_child_path (GtkTreeModelSort *tree_model_sort,
                                GtkTreePath *sorted_path);
    void gtk_tree_model_sort_convert_iter_to_child_iter (GtkTreeModelSort *tree_model_sort,
                                GtkTreeIter *child_iter,
                                GtkTreeIter *sorted_iter);
    void gtk_tree_model_sort_reset_default_sort_func (GtkTreeModelSort *tree_model_sort);
    void gtk_tree_model_sort_clear_cache (GtkTreeModelSort *tree_model_sort);
    gboolean gtk_tree_model_sort_iter_is_valid (GtkTreeModelSort *tree_model_sort,
                                GtkTreeIter *iter);



    alias gboolean (* GtkTreeSelectionFunc) (GtkTreeSelection *selection,
                        GtkTreeModel *model,
                        GtkTreePath *path,
                        gboolean path_currently_selected,
                        gpointer data);
    alias void (* GtkTreeSelectionForeachFunc) (GtkTreeModel *model,
                        GtkTreePath *path,
                        GtkTreeIter *iter,
                        gpointer data);

    struct _GtkTreeSelection {
    GObject parent;



    GtkTreeView *tree_view;
    GtkSelectionMode type;
    GtkTreeSelectionFunc user_func;
    gpointer user_data;
    GtkDestroyNotify destroy;
    }

    struct _GtkTreeSelectionClass {
    GObjectClass parent_class;

    void (* changed) (GtkTreeSelection *selection);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_tree_selection_get_type ();

    void gtk_tree_selection_set_mode (GtkTreeSelection *selection,
                                GtkSelectionMode type);
    GtkSelectionMode gtk_tree_selection_get_mode (GtkTreeSelection *selection);
    void gtk_tree_selection_set_select_function (GtkTreeSelection *selection,
                                GtkTreeSelectionFunc func,
                                gpointer data,
                                GtkDestroyNotify destroy);
    gpointer gtk_tree_selection_get_user_data (GtkTreeSelection *selection);
    GtkTreeView* gtk_tree_selection_get_tree_view (GtkTreeSelection *selection);



    gboolean gtk_tree_selection_get_selected (GtkTreeSelection *selection,
                                GtkTreeModel **model,
                                GtkTreeIter *iter);
    GList * gtk_tree_selection_get_selected_rows (GtkTreeSelection *selection,
                                GtkTreeModel **model);
    gint gtk_tree_selection_count_selected_rows (GtkTreeSelection *selection);
    void gtk_tree_selection_selected_foreach (GtkTreeSelection *selection,
                                GtkTreeSelectionForeachFunc func,
                                gpointer data);
    void gtk_tree_selection_select_path (GtkTreeSelection *selection,
                                GtkTreePath *path);
    void gtk_tree_selection_unselect_path (GtkTreeSelection *selection,
                                GtkTreePath *path);
    void gtk_tree_selection_select_iter (GtkTreeSelection *selection,
                                GtkTreeIter *iter);
    void gtk_tree_selection_unselect_iter (GtkTreeSelection *selection,
                                GtkTreeIter *iter);
    gboolean gtk_tree_selection_path_is_selected (GtkTreeSelection *selection,
                                GtkTreePath *path);
    gboolean gtk_tree_selection_iter_is_selected (GtkTreeSelection *selection,
                                GtkTreeIter *iter);
    void gtk_tree_selection_select_all (GtkTreeSelection *selection);
    void gtk_tree_selection_unselect_all (GtkTreeSelection *selection);
    void gtk_tree_selection_select_range (GtkTreeSelection *selection,
                                GtkTreePath *start_path,
                                GtkTreePath *end_path);
    void gtk_tree_selection_unselect_range (GtkTreeSelection *selection,
                                GtkTreePath *start_path,
                                GtkTreePath *end_path);
    alias _GtkTreeStore GtkTreeStore;

    alias _GtkTreeStoreClass GtkTreeStoreClass;


    struct _GtkTreeStore {
    GObject parent;

    gint stamp;
    gpointer root;
    gpointer last;
    gint n_columns;
    gint sort_column_id;
    GList *sort_list;
    GtkSortType order;
    GType *column_headers;
    GtkTreeIterCompareFunc default_sort_func;
    gpointer default_sort_data;
    GtkDestroyNotify default_sort_destroy;
    guint columns_dirty;
    }

    struct _GtkTreeStoreClass {
    GObjectClass parent_class;


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }


    GType gtk_tree_store_get_type ();
    GtkTreeStore *gtk_tree_store_new (gint n_columns,
                        ...);
    GtkTreeStore *gtk_tree_store_newv (gint n_columns,
                        GType *types);
    void gtk_tree_store_set_column_types (GtkTreeStore *tree_store,
                        gint n_columns,
                        GType *types);



    void gtk_tree_store_set_value (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        gint column,
                        GValue *value);
    void gtk_tree_store_set (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        ...);
    void gtk_tree_store_set_valist (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        va_list var_args);
    gboolean gtk_tree_store_remove (GtkTreeStore *tree_store,
                        GtkTreeIter *iter);
    void gtk_tree_store_insert (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *parent,
                        gint position);
    void gtk_tree_store_insert_before (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *parent,
                        GtkTreeIter *sibling);
    void gtk_tree_store_insert_after (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *parent,
                        GtkTreeIter *sibling);
    void gtk_tree_store_prepend (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *parent);
    void gtk_tree_store_append (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *parent);
    gboolean gtk_tree_store_is_ancestor (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *descendant);
    gint gtk_tree_store_iter_depth (GtkTreeStore *tree_store,
                        GtkTreeIter *iter);
    void gtk_tree_store_clear (GtkTreeStore *tree_store);
    gboolean gtk_tree_store_iter_is_valid (GtkTreeStore *tree_store,
                        GtkTreeIter *iter);
    void gtk_tree_store_reorder (GtkTreeStore *tree_store,
                        GtkTreeIter *parent,
                        gint *new_order);
    void gtk_tree_store_swap (GtkTreeStore *tree_store,
                        GtkTreeIter *a,
                        GtkTreeIter *b);
    void gtk_tree_store_move_before (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *position);
    void gtk_tree_store_move_after (GtkTreeStore *tree_store,
                        GtkTreeIter *iter,
                        GtkTreeIter *position);




    alias _GtkUIManager GtkUIManager;

    alias _GtkUIManagerClass GtkUIManagerClass;

    alias _GtkUIManagerPrivate GtkUIManagerPrivate;
    alias void _GtkUIManagerPrivate;



    struct _GtkUIManager {
    GObject parent;



    GtkUIManagerPrivate *private_data;
    }

    struct _GtkUIManagerClass {
    GObjectClass parent_class;


    void (* add_widget) (GtkUIManager *merge,
                GtkWidget *widget);
    void (* actions_changed) (GtkUIManager *merge);
    void (* connect_proxy) (GtkUIManager *merge,
                GtkAction *action,
                GtkWidget *proxy);
    void (* disconnect_proxy) (GtkUIManager *merge,
                GtkAction *action,
                GtkWidget *proxy);
    void (* pre_activate) (GtkUIManager *merge,
                GtkAction *action);
    void (* post_activate) (GtkUIManager *merge,
                GtkAction *action);


    void (*_gtk_reserved1) ();
    void (*_gtk_reserved2) ();
    void (*_gtk_reserved3) ();
    void (*_gtk_reserved4) ();
    }

    enum GtkUIManagerItemType {
    GTK_UI_MANAGER_AUTO = 0,
    GTK_UI_MANAGER_MENUBAR = 1 << 0,
    GTK_UI_MANAGER_MENU = 1 << 1,
    GTK_UI_MANAGER_TOOLBAR = 1 << 2,
    GTK_UI_MANAGER_PLACEHOLDER = 1 << 3,
    GTK_UI_MANAGER_POPUP = 1 << 4,
    GTK_UI_MANAGER_MENUITEM = 1 << 5,
    GTK_UI_MANAGER_TOOLITEM = 1 << 6,
    GTK_UI_MANAGER_SEPARATOR = 1 << 7,
    GTK_UI_MANAGER_ACCELERATOR = 1 << 8
    };


    GType gtk_ui_manager_get_type ();
    GtkUIManager *gtk_ui_manager_new ();
    void gtk_ui_manager_set_add_tearoffs (GtkUIManager *self,
                            gboolean add_tearoffs);
    gboolean gtk_ui_manager_get_add_tearoffs (GtkUIManager *self);
    void gtk_ui_manager_insert_action_group (GtkUIManager *self,
                            GtkActionGroup *action_group,
                            gint pos);
    void gtk_ui_manager_remove_action_group (GtkUIManager *self,
                            GtkActionGroup *action_group);
    GList *gtk_ui_manager_get_action_groups (GtkUIManager *self);
    GtkAccelGroup *gtk_ui_manager_get_accel_group (GtkUIManager *self);
    GtkWidget *gtk_ui_manager_get_widget (GtkUIManager *self,
                            gchar *path);
    GSList *gtk_ui_manager_get_toplevels (GtkUIManager *self,
                            GtkUIManagerItemType types);
    GtkAction *gtk_ui_manager_get_action (GtkUIManager *self,
                            gchar *path);
    guint gtk_ui_manager_add_ui_from_string (GtkUIManager *self,
                            gchar *buffer,
                            gssize length,
                            GError **error);
    guint gtk_ui_manager_add_ui_from_file (GtkUIManager *self,
                            gchar *filename,
                            GError **error);
    void gtk_ui_manager_add_ui (GtkUIManager *self,
                            guint merge_id,
                            gchar *path,
                            gchar *name,
                            gchar *action,
                            GtkUIManagerItemType type,
                            gboolean top);
    void gtk_ui_manager_remove_ui (GtkUIManager *self,
                            guint merge_id);
    gchar *gtk_ui_manager_get_ui (GtkUIManager *self);
    void gtk_ui_manager_ensure_update (GtkUIManager *self);
    guint gtk_ui_manager_new_merge_id (GtkUIManager *self);


    alias _GtkVButtonBox GtkVButtonBox;

    alias _GtkVButtonBoxClass GtkVButtonBoxClass;


    struct _GtkVButtonBox {
    GtkButtonBox button_box;
    }

    struct _GtkVButtonBoxClass {
    GtkButtonBoxClass parent_class;
    }


    GType gtk_vbutton_box_get_type () ;
    GtkWidget *gtk_vbutton_box_new ();




    gint gtk_vbutton_box_get_spacing_default ();
    void gtk_vbutton_box_set_spacing_default (gint spacing);

    GtkButtonBoxStyle gtk_vbutton_box_get_layout_default ();
    void gtk_vbutton_box_set_layout_default (GtkButtonBoxStyle layout);


    alias _GtkVPaned GtkVPaned;

    alias _GtkVPanedClass GtkVPanedClass;


    struct _GtkVPaned {
    GtkPaned paned;
    }

    struct _GtkVPanedClass {
    GtkPanedClass parent_class;
    }

    GType gtk_vpaned_get_type () ;
    GtkWidget *gtk_vpaned_new ();
    alias _GtkVRuler GtkVRuler;

    alias _GtkVRulerClass GtkVRulerClass;


    struct _GtkVRuler {
    GtkRuler ruler;
    }

    struct _GtkVRulerClass {
    GtkRulerClass parent_class;
    }


    GType gtk_vruler_get_type () ;
    GtkWidget* gtk_vruler_new ();
    alias _GtkVScale GtkVScale;

    alias _GtkVScaleClass GtkVScaleClass;


    struct _GtkVScale {
    GtkScale scale;
    }

    struct _GtkVScaleClass {
    GtkScaleClass parent_class;
    }


    GType gtk_vscale_get_type () ;
    GtkWidget* gtk_vscale_new (GtkAdjustment *adjustment);
    GtkWidget* gtk_vscale_new_with_range (gdouble min,
                    gdouble max,
                    gdouble step);

    alias _GtkVSeparator GtkVSeparator;

    alias _GtkVSeparatorClass GtkVSeparatorClass;


    struct _GtkVSeparator {
    GtkSeparator separator;
    }

    struct _GtkVSeparatorClass {
    GtkSeparatorClass parent_class;
    }


    GType gtk_vseparator_get_type ();
    GtkWidget* gtk_vseparator_new ();

}
